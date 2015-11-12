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
    
    NSFetchRequest *tagsRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tags"];
    self.tags = [self.managedObjectContext executeFetchRequest:tagsRequest error:nil];
    
    NSFetchRequest *receiptsRequest = [NSFetchRequest fetchRequestWithEntityName:@"Receipts"];
    self.receipts = [self.managedObjectContext executeFetchRequest:receiptsRequest error:nil];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    Tag *tag = self.tags[section];
    
    return tag.receipts.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    return cell;
}

@end
