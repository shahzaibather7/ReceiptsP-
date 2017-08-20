//
//  ViewController.m
//  Receipts
//
//  Created by Mohammad Shahzaib Ather on 2017-08-17.
//  Copyright © 2017 Mohammad Shahzaib Ather. All rights reserved.
//

#import "ViewController.h"
#import "DetailedViewController.h"
#import "Tag+CoreDataClass.h"
#import "Receipt+CoreDataClass.h"
#import "AppDelegate.h"

@interface ViewController ()

@property NSDictionary<NSString*, NSArray<Receipt*>*>* organizedReciepts;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCoolNavBar];
    
    
    
   
}

-(void)viewWillAppear:(BOOL)animated {
    NSFetchRequest *fr = [Tag fetchRequest];
    NSArray *array = [[(AppDelegate*)[UIApplication sharedApplication].delegate persistentContainer].viewContext executeFetchRequest:fr error:nil];
    for (Tag * tag in array) {
        for (Receipt * receipt in tag.receipts) {
            NSLog(@"%@  :   %@", tag.tagName, receipt.receiptDesc);
            NSSortDescriptor *sortByPersonal = [NSSortDescriptor sortDescriptorWithKey:@"Personal" ascending:YES];
            NSSortDescriptor *sortByBusiness = [NSSortDescriptor sortDescriptorWithKey:@"Business" ascending:YES];
            NSSortDescriptor *sortByFamily =  [NSSortDescriptor sortDescriptorWithKey:@"Family" ascending:YES];
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortByPersonal];
            NSArray *sortDescriptors2 = [NSArray arrayWithObjects:sortByBusiness];
            NSArray *sortDescriptors3 = [NSArray arrayWithObjects: sortByFamily];
         
            
            self.organizedReciepts = [[[array arrayByAddingObjectsFromArray:sortDescriptors] arrayByAddingObjectsFromArray:sortDescriptors2] arrayByAddingObjectsFromArray:sortDescriptors3];
            //   self.organizedReciepts = [array sortedArrayUsingDescriptors:sortDescriptors];
            
        }
        
    }
    
    //forloop
        //forloop
            //put receipt in dictionary
        //endforloop
    //endforloop
    
//    for ( int i = 0 ; i < array.count ; i++) {
//        for (int j = 0 ; j == [[array objectAtIndex:i] count];j++){
//            NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"Personal"
//                                                                         ascending:YES];
//      
//        }
//    }
//    
//    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
//    cell.textLabel.text = self.organizedReceipts[indexPath.section][indexPath.row];
    
    
    return cell;
}

- (IBAction)addRecipt:(id)sender {
    [self performSegueWithIdentifier:@"segueID" sender:sender];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueID"]) {
        DetailedViewController *newVC = segue.destinationViewController;
    }
    
}
-(void) createCoolNavBar {
    self.title = @"Receipt List";
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
   // self.navigationController.navigationBar.titleTextAttributes = [UIColor whiteColor];
}

@end
