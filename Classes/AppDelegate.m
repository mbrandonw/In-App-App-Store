//
//  AppDelegate.m
//  IAAS
//
//  Created by Brandon Williams on 8/9/10.
//  Copyright Opetopic 2010. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

#pragma mark Application lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
    // Override point for customization after application launch.
	
	window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
	rootViewController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
	rootViewController.view.frame = window.frame;
	[window addSubview:rootViewController.view];
	
	[window makeKeyAndVisible];
	
	return YES;
}
#pragma mark -


#pragma mark Memory management
- (void)dealloc {
    [window release], rootViewController = nil;
	[rootViewController release], rootViewController = nil;
    [super dealloc];
}


@end
