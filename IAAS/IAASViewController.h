//
//  IAASViewController.h
//  IAAS
//
//  Created by Brandon Williams on 8/10/10.
//  Copyright 2010 Opetopic. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IAASDelegate;

@interface IAASViewController : UIViewController <UIWebViewDelegate> {
	
	id<IAASDelegate> delegate;
	UIButton *closeButton;
	NSString *iaasURLPath;
	BOOL showCloseButton;
}

@property (nonatomic, assign) BOOL showCloseButton;
@property (nonatomic, assign) id<IAASDelegate> delegate;
@property (nonatomic, retain) NSString *iaasURLPath;

-(id) initWithURLPath:(NSString*)path;
-(void) closeButtonPressed;

@end

@protocol IAASDelegate
@optional
-(void) IAASDidClose:(IAASViewController*)iaas;
@end
