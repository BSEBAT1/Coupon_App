//
//  ScanClass.m
//  CouponME!
//
//  Created by macbook pro on 7/14/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import "ScanClass.h"
#import <AVFoundation/AVFoundation.h>
#import "Coupon.h"
@interface ScanClass () <AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *Spinner;
@property (strong, nonatomic) IBOutlet UIView *ScanCameraPreview;
@property (nonatomic,strong) NSString *barcode;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureLayer;





@end

@implementation ScanClass

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *buttonizeButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:@selector(buttonizeButtonTap:)];
    self.navigationItem.rightBarButtonItems = @[buttonizeButton];
    [self setupScanningSession];
    self.Spinner.hidesWhenStopped=YES;
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.captureSession startRunning];
    
    
    
}

- (void)setupScanningSession {
    // Initalising the Capture session before doing any video capture/scanning.
    self.captureSession = [[AVCaptureSession alloc] init];
    
    NSError *error;
    // Set camera capture device to default and the media type to video.
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [captureDevice lockForConfiguration:nil];
    
    captureDevice.torchMode=AVCaptureTorchModeOn;
    
    // Set video capture input: If there a problem initialising the camera, it will give an error.
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        NSLog(@"Error Getting Camera Input");
        return;
    }
    // Adding input souce for capture session. i.e., Camera
    [self.captureSession addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    // Set output to capture session. Initalising an output object we will use later.
    [self.captureSession addOutput:captureMetadataOutput];
    
    // Create a new queue and set delegate for metadata objects scanned.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("scanQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    // Delegate should implement captureOutput:didOutputMetadataObjects:fromConnection: to get callbacks on detected metadata.
    [captureMetadataOutput setMetadataObjectTypes:[captureMetadataOutput availableMetadataObjectTypes]];
    
    // Layer that will display what the camera is capturing.
    self.captureLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    [self.captureLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.captureLayer setFrame:self.ScanCameraPreview.layer.bounds];
    // Adding the camera AVCaptureVideoPreviewLayer to our view's layer.
    [self.ScanCameraPreview.layer addSublayer:self.captureLayer];
    
}


// AVCaptureMetadataOutputObjectsDelegate method
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    // Do your action on barcode capture here:
    NSString *capturedBarcode = nil;
    
    // Specify the barcodes you want to read here:
    NSArray *supportedBarcodeTypes = @[AVMetadataObjectTypeUPCECode,
                                       AVMetadataObjectTypeCode39Code,
                                       AVMetadataObjectTypeCode39Mod43Code,
                                       AVMetadataObjectTypeEAN13Code,
                                       AVMetadataObjectTypeEAN8Code,
                                       AVMetadataObjectTypeCode93Code,
                                       AVMetadataObjectTypeCode128Code,
                                       AVMetadataObjectTypePDF417Code,
                                       AVMetadataObjectTypeQRCode,
                                       AVMetadataObjectTypeAztecCode];
    
    // In all scanned values..
    for (AVMetadataObject *barcodeMetadata in metadataObjects) {
        // ..check if it is a suported barcode
        for (NSString *supportedBarcode in supportedBarcodeTypes) {
            
            if ([supportedBarcode isEqualToString:barcodeMetadata.type]) {
                // This is a supported barcode
                // Note barcodeMetadata is of type AVMetadataObject
                // AND barcodeObject is of type AVMetadataMachineReadableCodeObject
                AVMetadataMachineReadableCodeObject *barcodeObject = (AVMetadataMachineReadableCodeObject *)[self.captureLayer transformedMetadataObjectForMetadataObject:barcodeMetadata];
                capturedBarcode = [barcodeObject stringValue];
                // Got the barcode. Set the text and break out of the loop.
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self.captureSession stopRunning];
                    self.barcode = capturedBarcode;
                    NSLog(@"barcode is %@",self.barcode);
                    NSLog(@"captured barcode is %@",capturedBarcode);
                    [self post];
                });
                return;
            }
        }
    }
    
    
    
}
-(void)post{
    
    [self.Spinner startAnimating];
    
    NSString *noteDataString=[NSString stringWithFormat:@"UPC=%@",self.barcode];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURL *url = [NSURL URLWithString:@"http://www.berkaysebat.com/selector.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSLog(@"URL REQUEST IS %@",request);
    request.HTTPBody = [noteDataString dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"note body is %@",request.HTTPBody);
    request.HTTPMethod = @"POST";
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *retString = [NSString stringWithUTF8String:[data bytes]];
        
        NSLog(@"json returned: %@", retString);
        
        NSError *parseError = nil;
        self.dictonary=nil;
        
       self.dictonary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        NSLog(@"the first object is%@",[self.dictonary objectForKey:@"upc_code"]);
        
        if (!parseError) {
            [self.Spinner stopAnimating];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self buttonizeButtonTap:self]; 
            });
          
            
            NSLog(@"no error");
           
            
        } else {
            [self.Spinner stopAnimating];
            NSString *err = [parseError localizedDescription];
            NSLog(@"Encountered error parsing: %@", err);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self buttonizeButtonTap:self];
            });
            
        }

        
        
        
    }];
    NSLog(@"DATA SENT");
    [postDataTask resume];
    
    NSLog(@"data is %@",self.dictonary);

    
}

-(void)buttonizeButtonTap:(id)sender{
    [self performSegueWithIdentifier:@"Data" sender:sender];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
        NSString *donkey=[self.dictonary objectForKey:@"upc_code"];
        NSLog(@"donkey vaue is %@",donkey);
    
     
        Coupon *Coupon=[segue destinationViewController];
        [Coupon setBarcodes:self.barcode];
        [Coupon setCategrories:[self.dictonary objectForKey:@"category"]];
        [Coupon setProducts:[self.dictonary objectForKey:@"product"]];
        [Coupon setExp_dates:[self.dictonary objectForKey:@"exp_date"]];
        [Coupon setValues:[self.dictonary objectForKey:@"value"] ];
        [Coupon setDisclaimers:[self.dictonary objectForKey:@"Disclaimer"]];
        [Coupon setQuantity:[self.dictonary objectForKey:@"quantity"]];
    Coupon.detail=NO;
    
    
    
     
    
   
    
    
}


@end
