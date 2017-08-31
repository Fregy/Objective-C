

#import	"EditingViewController.h"

@class Book;

@interface RootViewController : UITableViewController <PropertyEditing> {
    Book *book;
	NSDateFormatter *dateFormatter;
	NSUndoManager *undoManager;
}

@property (nonatomic, retain) Book *book;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;
@property (nonatomic, retain) NSUndoManager *undoManager;

@end
