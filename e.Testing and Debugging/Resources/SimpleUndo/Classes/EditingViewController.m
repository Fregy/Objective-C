
/*
     File: EditingViewController.m
 Abstract: A generic table view controller responsible for editing a field of data (text or date).
 The controller defines a protocol to communicate changes to the view controller that manages the object being edited.
  
 */

#import "EditingViewController.h"
#import "RootViewController.h"

@implementation EditingViewController

@synthesize textField, editedObject, editedPropertyKey, editedPropertyDisplayName, editingDate, datePicker, sourceController;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	// Set the title to the user-visible name of the field.
	self.title = editedPropertyDisplayName;
	
	// Configure the save and cancel buttons.
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
	self.navigationItem.rightBarButtonItem = saveButton;
	[saveButton release];
	
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
	self.navigationItem.leftBarButtonItem = cancelButton;
	[cancelButton release];
}


- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	
	// Update user interface according to state.
    if (editingDate) {
        textField.hidden = YES;
        datePicker.hidden = NO;
		NSDate *date = [editedObject valueForKey:editedPropertyKey];
        if (date == nil) date = [NSDate date];
        datePicker.date = date;
    }
	else {
        textField.hidden = NO;
        datePicker.hidden = YES;
        textField.text = [editedObject valueForKey:editedPropertyKey];
		textField.placeholder = self.title;
        [textField becomeFirstResponder];
    }
}


#pragma mark -
#pragma mark Save and cancel operations

- (IBAction)save {
	
    // Pass the current value to the source controller, then pop.
    if (editingDate) {
		[sourceController setValue:datePicker.date forEditedProperty:editedPropertyKey];
    }
	else {
		[sourceController setValue:textField.text forEditedProperty:editedPropertyKey];
    }
	
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)cancel {
    // Don't pass the current value to the edited object, just pop.
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [datePicker release];
    [textField release];
    [editedPropertyKey release];
    [editedPropertyDisplayName release];
	[super dealloc];
}


@end

