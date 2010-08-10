    //
//  IAASViewController.m
//  IAAS
//
//  Created by Brandon Williams on 8/10/10.
//  Copyright 2010 Opetopic. All rights reserved.
//

#import "IAASViewController.h"


@implementation IAASViewController

@synthesize delegate;
@synthesize iaasURLPath;
@synthesize showCloseButton;

#pragma mark Initialization methods
-(id) initWithURLPath:(NSString *)path {
	if (self = [super init]) {
		self.iaasURLPath = path;
	}
	return self;
}

-(void) viewDidLoad {
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor blackColor];
	
	// show an activity view while loading the IAAS
	UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activity.center = self.view.center;
	[activity startAnimating];
	[self.view addSubview:activity];
	[activity release];
	
	// full screen webview for the app store
	UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)];
	web.hidden = YES;
	web.delegate = self;
	[self.view addSubview:web];
	NSURLRequest *r = [NSURLRequest requestWithURL:[NSURL URLWithString:iaasURLPath]];
	[web loadRequest:r];
	web.tag = 0;
	[web release];
	
	// add a close button to the top-left corner of the view
	UIImage *closeImage = [UIImage imageNamed:@"IAAS.bundle/close.png"];
	closeButton = [[UIButton alloc] initWithFrame:CGRectMake(2.0f, 2.0f, closeImage.size.width, closeImage.size.height)];
	closeButton.hidden = ! showCloseButton;
	[closeButton setImage:closeImage forState:UIControlStateNormal];
	[closeButton addTarget:self action:@selector(closeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:closeButton];
}
#pragma mark -


#pragma mark Interface actions
-(void) closeButtonPressed {
	
	// let our delegate know we are closing
	if ([(id)delegate respondsToSelector:@selector(IAASDidClose:)])
		[delegate IAASDidClose:self];
	
	// we might show this view modally or inside a navigation controller, so remove us accordingly
	[self dismissModalViewControllerAnimated:YES];
	[self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -


#pragma mark UIWebView delegate methods
-(void) webViewDidFinishLoad:(UIWebView *)webView {
	webView.hidden = NO;
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	
	// the first time the webview fails to load we will try loading the local version of the IAAS
	webView.tag++;
	if (webView.tag == 1) {
		
		NSString *html = [NSString stringWithContentsOfFile:[[[NSBundle mainBundle] pathForResource:@"IAAS" ofType:@"bundle"] stringByAppendingPathComponent:@"index.html"] encoding:NSUTF8StringEncoding error:NULL];
		NSURL *base = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"IAAS" ofType:@"bundle"]];
		[webView loadHTMLString:html baseURL:base];
	}
}

-(BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	
	// allow following links in the webview
	if (navigationType == UIWebViewNavigationTypeLinkClicked)
		[[UIApplication sharedApplication] openURL:[request URL]];
	return YES;
}
#pragma mark -


#pragma mark Custom getters and setters
-(void) setShowCloseButton:(BOOL)b {
	showCloseButton = b;
	closeButton.hidden = !b;
}
-(CGSize) contentSizeForViewInPopover {
	return CGSizeMake(320.0f, 480.0f);
}
#pragma mark -


#pragma mark Memory management
- (void)dealloc {
	delegate = nil;
	[closeButton release], closeButton = nil;
	[iaasURLPath release], iaasURLPath = nil;
    [super dealloc];
}

@end
