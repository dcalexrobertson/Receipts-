//
//  AddReceiptViewController.m
//  Receipts++
//
//  Created by Alex on 2015-11-12.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "AddReceiptViewController.h"
#import "Receipt.h"
#import "Tag.h"
#import "AppDelegate.h"

@interface AddReceiptViewController ()

@property (weak, nonatomic) IBOutlet UITextView *receiptNoteTextView;
@property (weak, nonatomic) IBOutlet UITextField *receiptAmountTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UIButton *familyButton;
@property (weak, nonatomic) IBOutlet UIButton *businessButton;
@property (weak, nonatomic) IBOutlet UIButton *personalButton;

@end

@implementation AddReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.receiptNoteTextView.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [self.receiptNoteTextView.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [self.receiptNoteTextView.layer setBorderWidth: 1.0];
    [self.receiptNoteTextView.layer setCornerRadius:8.0f];
    [self.receiptNoteTextView.layer setMasksToBounds:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)personalButtonPressed:(id)sender {
    self.personalButton.selected = !self.personalButton.selected;
}
- (IBAction)businessButtonPressed:(id)sender {
    self.businessButton.selected = !self.businessButton.selected;
}
- (IBAction)familyButtonPressed:(id)sender {
    self.familyButton.selected = !self.familyButton.selected;
}


- (IBAction)doneButtonPressed:(id)sender {
    
    Receipt *newReceipt = [NSEntityDescription insertNewObjectForEntityForName:@"Receipt" inManagedObjectContext:self.managedObjectContext];
    newReceipt.amount = @([self.receiptAmountTextField.text floatValue]);
    newReceipt.note = self.receiptNoteTextView.text;
    newReceipt.timeStamp = self.datePicker.date;
    
    if (self.personalButton.selected) {
        [newReceipt addTagsObject:[self checkForTagwithName:@"Personal"]];
    }
    if (self.businessButton.selected) {
        [newReceipt addTagsObject:[self checkForTagwithName:@"Business"]];
    }
    if (self.familyButton.selected) {
        [newReceipt addTagsObject:[self checkForTagwithName:@"Family"]];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    AppDelegate *appDel = [[UIApplication sharedApplication] delegate];
    [appDel saveContext];
}


- (IBAction)cancelButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (Tag *)checkForTagwithName:(NSString *)tagName {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tagName = %@", tagName];
    request.predicate = predicate;
    request.fetchLimit = 1;

    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    if ([results count]) {
        
        return [results firstObject];
        
    } else {
        
        Tag *tag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:self.managedObjectContext];
        tag.tagName = tagName;
        return tag;
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
