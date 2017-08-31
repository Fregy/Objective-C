

#import "RootViewController.h"




#import "JKCallbacksTableViewCell.h"



@interface RootViewController()



@end


@implementation RootViewController

#pragma mark - Object Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
	if (self) {
		
	}
	
	return self;
}


- (void)dealloc
{
    [imageFolder release];
    [imageArray release];

    
    [super dealloc];
}

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad
{
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    imageFolder = [[resourcePath stringByAppendingPathComponent:@"Pixar-Wallpaper-Pack"] copy];
    imageArray = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:imageFolder
                                                                      error:NULL] retain];

	
    [super viewDidLoad];
}

- (void)viewDidUnload
{

	
	[super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{

	
	[super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource Protocol Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [imageArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    JKCallbacksTableViewCell *cell = (JKCallbacksTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[JKCallbacksTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
												reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Get the filename to load.
    
    NSString *imageFilename = [imageArray objectAtIndex:[indexPath row]];
    NSString *filePath = [imageFolder stringByAppendingPathComponent:imageFilename];
    [[cell textLabel] setText:imageFilename];
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
    UIImage *image = [[UIImage alloc]initWithContentsOfFile:filePath];

    [[cell imageView] setImage:image];
    return cell;
}

#pragma mark -



@end
