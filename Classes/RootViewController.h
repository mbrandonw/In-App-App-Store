//
//  RootViewController.h
//  IAAS
//
//  Created by Brandon Williams on 8/10/10.
//  Copyright 2010 Opetopic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController {

	UIPopoverController *popover;
}

-(IBAction) iaasButtonPressed:(UIButton*)sender;

@end
