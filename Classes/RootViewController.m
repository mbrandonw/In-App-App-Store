//
//  RootViewController.m
//  IAAS
//
//  Created by Brandon Williams on 8/10/10.
//  Copyright 2010 Opetopic. All rights reserved.
//

#import "RootViewController.h"
#import "IAASViewController.h"

@implementation RootViewController

-(IBAction) iaasButtonPressed:(UIButton*)sender {
	
	IAASViewController *iaas = [[IAASViewController alloc] initWithURLPath:@"http://www.opetopic.com/oas"];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		iaas.showCloseButton = NO;
		[popover release];
		popover = [[UIPopoverController alloc] initWithContentViewController:iaas];
		[popover presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}
	else
	{
		iaas.showCloseButton = YES;
		[self presentModalViewController:iaas animated:YES];
	}
	
	[iaas release];
}


-(void) dealloc {
	[popover release], popover = nil;
	[super dealloc];
}


@end
