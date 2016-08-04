//
//  ListCoupon.m
//  CouponME!
//
//  Created by macbook pro on 7/24/16.
//  Copyright © 2016 berkaysebat.com.trivia. All rights reserved.
//

#import "ListCoupon.h"
#import "Coupon_Data.h"
#import "Coupon.h"

@interface ListCoupon ()
@property NSString *celltitle;
@end

@implementation ListCoupon
@synthesize fetchedResultsController = _fetchedResultsController;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
  
    NSLog(@"fetched this data %@",self.fetchedResultsController);
    
    
//    NSError *error = nil;
//    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Coupon_Data"];
//    [request setSortDescriptors:[NSArray arrayWithObject:
//                                 [NSSortDescriptor sortDescriptorWithKey:@"quantity" ascending:YES]]];
//    [request setReturnsObjectsAsFaults:NO];
//   
//    NSArray *testArray = [[self managedObjectContext] executeFetchRequest:request error:&error];
//    
//    for (Coupon_Data *obj in testArray) {
//        NSLog(@"obj.id %@", obj.product);
//    }
//    
//    NSLog(@"query records: %@",testArray);
//
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        
        // Handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [[self.fetchedResultsController sections]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    id <NSFetchedResultsSectionInfo> secInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [secInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Coupon_Data *coupon_object_table = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = coupon_object_table.product;
    return cell;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[[self.fetchedResultsController sections]objectAtIndex:section]name];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSManagedObjectContext *context = [self managedObjectContext];
        Coupon_Data *couponToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [context deleteObject:couponToDelete];
        
        
//        
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    Coupon *coupondetail=[segue destinationViewController];
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Coupon_Data *selectedCoupon = (Coupon_Data *) [self.fetchedResultsController objectAtIndexPath:indexPath];
    coupondetail.current_detail=selectedCoupon;
    coupondetail.detail=YES;
    
}


-(NSFetchedResultsController *) fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
   self.managedObjectContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Coupon_Data"
    inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"product" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"category" cacheName:nil];
    
    _fetchedResultsController.delegate = self;
    
    NSLog(@"Object count is %d", _fetchedResultsController.fetchedObjects.count);
    return _fetchedResultsController;
}








@end
