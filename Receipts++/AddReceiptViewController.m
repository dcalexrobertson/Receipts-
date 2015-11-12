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

@interface AddReceiptViewController ()

@property (weak, nonatomic) IBOutlet UITextView *receiptNoteTextView;
@property (weak, nonatomic) IBOutlet UITextField *receiptAmountTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tagSegControl;

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


- (IBAction)doneButtonPressed:(id)sender {
    
    Receipt *newReceipt = [NSEntityDescription insertNewObjectForEntityForName:@"Receipt" inManagedObjectContext:self.managedObjectContext];
    newReceipt.amount = @([self.receiptAmountTextField.text intValue]);
    newReceipt.note = self.receiptNoteTextView.text;
    newReceipt.timeStamp = self.datePicker.date;
    
    Tag *newTag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:self.managedObjectContext];
    newTag.tagName = [self.tagSegControl titleForSegmentAtIndex:self.tagSegControl.selectedSegmentIndex];
    
    [newReceipt addTagsObject:newTag];
    
}


- (IBAction)cancelButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
