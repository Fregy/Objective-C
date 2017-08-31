
/*
     File: RootViewController.m
 Abstract:  Abstract: The table view controller responsible for displaying information about a book. The user can also edit the information.  When editing starts, the root view controller creates an undo manager to record changes. The undo manager supports up to three levels of and redo.  When the user taps Done, changes are considered to be committed and the undo manager is disposed of.
 
   
 */

#import "RootViewController.h"

#import "EditingViewController.h"
#import "Book.h"


@implementation RootViewController

@synthesize book, dateFormatter, undoManager;

#pragma mark -
#pragma mark View loading


- (void)viewDidLoad {
	
	[super viewDidLoad];
    self.title = @"Book";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.tableView.allowsSelectionDuringEditing = YES;
}


- (void)viewDidUnload {
	// Release any properties that are loaded in viewDidLoad or can be recreated lazily.
	self.dateFormatter = nil;
}


- (void)viewWillAppear:(BOOL)animated {
	
    [super viewWillAppear:animated];
    // Redisplay the data.
    [self.tableView reloadData];
}



#pragma mark -
#pragma mark Table view data source methods

/*
 Standard table view data source and delegate methods to display a table view containing a single section with three rows showing different properties of the book.
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // 1 section.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 3 rows.
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
    /*
	 Dequeue or create and then configure a table cell for each attribute of the book.
	 */
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
		cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
	
	switch (indexPath.row) {
        case 0: 
			cell.textLabel.text = @"Title";
			cell.detailTextLabel.text = book.title;
			break;
        case 1: 
			cell.textLabel.text = @"Author";
			cell.detailTextLabel.text = book.author;
			break;
        case 2:
			cell.textLabel.text = @"Copyright";
			cell.detailTextLabel.text = [self.dateFormatter stringFromDate:book.copyright];
			break;
    }
    return cell;
}


- (NSIndexPath *)tableView:(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Only allow selection if editing.
    return (self.editing) ? indexPath : nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    // Only allow selection if editing.
	if (!self.editing) return;
	
	/*
	 Create, configure, and push the editing controller.
	 */
    EditingViewController *controller = [[EditingViewController alloc] initWithNibName:@"EditingView" bundle:nil];
    controller.editedObject = book;
    controller.sourceController = self;
	
    switch (indexPath.row) {
        case 0: {
            controller.editedPropertyKey = @"title";
            controller.editedPropertyDisplayName = NSLocalizedString(@"title", @"display name for title");
            controller.editingDate = NO;
        } break;
        case 1: {
            controller.editedPropertyKey = @"author";
			controller.editedPropertyDisplayName = NSLocalizedString(@"author", @"display name for author");
			controller.editingDate = NO;
        } break;
        case 2: {
            controller.editedPropertyKey = @"copyright";
			controller.editedPropertyDisplayName = NSLocalizedString(@"copyright", @"display name for copyright");
			controller.editingDate = YES;
        } break;
    }
	
    [self.navigationController pushViewController:controller animated:YES];
	[controller release];
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	// Do not allow rows to be deleted when in editing mode.
	return UITableViewCellEditingStyleNone;
}


- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
	// Do not indent rows when in editing mode.
	return NO;
}


#pragma mark -
#pragma mark Editing

/*
 Method to update a value in the book, and at the same time register the undo/redo operation with the undo manager.
 The implementation uses an invocation since the method requires two arguments.
 
 This method is invoked by the editing view controller if the user taps Save.
 */
- (void)setValue:(id)newValue forEditedProperty:(NSString *)field {
	
	/*
	 prepareWithInvocationTarget: pushes a new undo item onto the undo stack (or onto the redop stack if this method is invoked during an undo operation).
	 If the user chooses undo, then the undo manager sends the target (self) setValue:forEditedProperty: message with the arguments currentValueforEditedProperty and field.
	 */
	id currentValueforEditedProperty = [book valueForKey:field];
	[[undoManager prepareWithInvocationTarget:self] setValue:currentValueforEditedProperty forEditedProperty:field];
	
	// Update the book's property to the new value.
	[book setValue:newValue forKey:field];
	
	// Set the action name (which appears in the undo button title) to the user-visible name of the field.
	if (![undoManager isUndoing]) {
		[undoManager setActionName:NSLocalizedString(field, @"string provided dynamically")];
	}
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	
    [super setEditing:editing animated:animated];

	/*
	 Respond to change in editing state:
	 If editing begins, create and set an undo manager to track edits. Then register as an observer of undo manager change notifications, so that if an undo or redo operation is performed, the table view can be reloaded.
	 If editing ends, de-register from the notification center and remove the undo manager.
	*/
	NSNotificationCenter *dnc = [NSNotificationCenter defaultCenter];
	
	if (editing) {
		NSUndoManager *anUndoManager = [[NSUndoManager alloc] init];
		self.undoManager = anUndoManager;
		[anUndoManager release];
		
		/*
		 3 levels of undo is somewhat arbitrary. It happens here to coincide with the number of properties that can be edited, but in general you need to consider the memory overhead of maintaining a large number of undo actions, and the user interaction (how easy will it be for the user to backtrack through a dozen or more actions).
		 */
		[undoManager setLevelsOfUndo:3];
		[dnc addObserver:self selector:@selector(undoManagerDidUndo:) name:NSUndoManagerDidUndoChangeNotification object:undoManager];
		[dnc addObserver:self selector:@selector(undoManagerDidRedo:) name:NSUndoManagerDidRedoChangeNotification object:undoManager];
	}
	else {
		[dnc removeObserver:self];
		self.undoManager = nil;
	}
}


#pragma mark -
#pragma mark Undo support

/*
 Methods invoked in response to undo notifications -- see setEditing:animated:.  Simply redisplay the table view to reflect the changed value.
 */
- (void)undoManagerDidUndo:(NSNotification *)notification {
	[self.tableView reloadData];
}


- (void)undoManagerDidRedo:(NSNotification *)notification {
	[self.tableView reloadData];
}


/*
 The view controller must be first responder in order to be able to receive shake events for undo. It should resign first responder status when it disappears.
 */
- (BOOL)canBecomeFirstResponder {
	return YES;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self resignFirstResponder];
}


#pragma mark -
#pragma mark Date formatter

- (NSDateFormatter *)dateFormatter {	
	if (dateFormatter == nil) {
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
		[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	}
	return dateFormatter;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    NSLog(@"deallaoc");
    [undoManager release];
    [dateFormatter release];
    [book release];
    [super dealloc];
}


@end

