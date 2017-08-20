//
//  DetailedViewController.m
//  Recipts
//
//  Created by Mohammad Shahzaib Ather on 2017-08-17.
//  Copyright © 2017 Mohammad Shahzaib Ather. All rights reserved.
//

#import "Receipt+CoreDataClass.h"
#import "DetailedViewController.h"
#import "AppDelegate.h"
#import "Tag+CoreDataClass.h"

@interface DetailedViewController () <UITableViewDataSource , UITableViewDelegate >

@property (nonatomic , strong) NSArray <Tag*>* tags;
@property NSMutableSet* selectedTags;

@end

@implementation DetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"New Receipt";
    self.amountTextField.delegate = self;
    self.descriptionTextField.delegate = self;
    
    
    self.selectedTags = [NSMutableSet new];
    
    AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSPersistentContainer *persistentContainer = appdelegate.persistentContainer;
    
    NSError *error = nil;
     
    NSFetchRequest <Tag*> *tagRequest = [Tag fetchRequest];
    self.tags = [persistentContainer.viewContext executeFetchRequest:tagRequest error:&error];
    if(self.tags.count == 0) {
        [self createTags: persistentContainer.viewContext];
    }
    
    [appdelegate saveContext];
}

#pragma core data shit

-(void)createTags : (NSManagedObjectContext*) persistentContainerContext {
    Tag* personal = [[Tag alloc] initWithContext:persistentContainerContext];
    personal.tagName = @"Personal";
    Tag* business = [[Tag alloc] initWithContext:persistentContainerContext];
    business.tagName = @"Business";
    Tag* family= [[Tag alloc] initWithContext:persistentContainerContext];
    family.tagName = @"Family";
    NSArray *arr = [[NSArray alloc] initWithObjects: personal, business,family, nil];
    
    self.tags =arr;
}









#pragma Tableview Setup

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = self.tags[indexPath.row].tagName;
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tags.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectedTags addObject:self.tags[indexPath.row]];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectedTags removeObject:self.tags[indexPath.row]];
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}

- (IBAction)addReceipt:(id)sender {
    Receipt *newReceipt = [[Receipt alloc] initWithContext:[(AppDelegate*)[UIApplication sharedApplication].delegate persistentContainer].viewContext];
    newReceipt.receiptDesc = self.descriptionTextField.text;
    newReceipt.amount = self.amountTextField.text.floatValue;
    newReceipt.tags = self.selectedTags ;
    [(AppDelegate*)[UIApplication sharedApplication].delegate saveContext];
    [self.navigationController popViewControllerAnimated:YES];
}




















//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    for (
//    
//    
//    
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
