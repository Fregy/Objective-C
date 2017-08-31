

#import "GCDExampleAppDelegate.h"


@implementation GCDExampleAppDelegate

@synthesize navigationController;
@synthesize window;

#pragma mark - Object Lifecycle

- (void)dealloc
{
    [window release];
    [navigationController release];
	
    [super dealloc];
}

#pragma mark - UIApplicationDelegate Protocol Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[self window] setRootViewController:[self navigationController]];
    [[self window] makeKeyAndVisible];
    
    return YES;
}

#pragma mark -

@end
