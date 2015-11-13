//
//  ViewController.m
//  Receipts++
//
//  Created by Alex on 2015-11-12.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "ViewController.h"
#import "AddReceiptViewController.h"
#import "AppDelegate.h"
#import "Tag.h"
#import "Receipt.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSArray *tags;
@property (nonatomic) NSArray *receipts;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    NSFetchRequest *tagsRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    self.tags = [self.managedObjectContext executeFetchRequest:tagsRequest error:nil];
    
    NSFetchRequest *receiptsRequest = [NSFetchRequest fetchRequestWithEntityName:@"Receipt"];
    self.receipts = [self.managedObjectContext executeFetchRequest:receiptsRequest error:nil];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    AddReceiptViewController *addReceiptVC = [segue destinationViewController];
    addReceiptVC.managedObjectContext = self.managedObjectContext;
}

#pragma mark - Table View

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.tags.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    Tag *tag = self.tags[section];
    
    return tag.tagName;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    Tag *tag = self.tags[section];
    
    return tag.receipts.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"receiptCell" forIndexPath:indexPath];
    
    Tag *tag = self.tags[indexPath.section];
    NSArray *receiptsForTag = [tag.receipts allObjects];
    Receipt *receipt = receiptsForTag[indexPath.row];
    
    cell.textLabel.text = [receipt.amount stringValue];
    cell.detailTextLabel.text = receipt.note;
    
    return cell;
}

@end
