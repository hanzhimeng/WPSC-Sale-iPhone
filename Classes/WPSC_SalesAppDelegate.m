//
//  WPSC_SalesAppDelegate.m
//  WPSC Sales
//
//  Created by Allen Han (hanzhimeng@gmail.com) on 28/04/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "WPSC_SalesAppDelegate.h"
#import "RootViewController.h"
//#import "XMLRPCDecoder.h"
#import "XMLRPCRequest.h"
#import "XMLRPCResponse.h"
#import "XMLRPCConnectionManager.h"


@implementation WPSC_SalesAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    

	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

- (void)request: (XMLRPCRequest *)request didReceiveResponse: (XMLRPCResponse *)response{
	//NSLog([response body]);
	NSLog(@"responce");
}

-(void)saveBlog:(id)sender{
	RootViewController *rv = [[navigationController viewControllers] lastObject];
	user = [rv getUsername];
	pwd = [rv getPassword];
	url = [rv getURL];
	
	
    // Override point for customization after app launch
	NSURL *URL = [NSURL URLWithString: @"http://ace.local/WP4E/xmlrpc.php"];
	XMLRPCRequest *request = [[XMLRPCRequest alloc] initWithURL: URL];
	XMLRPCConnectionManager *manager = [XMLRPCConnectionManager sharedManager];
	[request setMethod: @"wp.getUsersBlogs" withParameters: [NSArray arrayWithObjects: @"admin", @"beyondh7", nil]];
	[manager spawnConnectionWithXMLRPCRequest: request delegate: self];
	NSLog(@"Saving");
}

- (void)request: (XMLRPCRequest *)request didFailWithError: (NSError *)error{
	NSLog(@"error");
}

- (void)request: (XMLRPCRequest *)request didReceiveAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge{
	NSLog(@"challenge");
}

- (void)request: (XMLRPCRequest *)request didCancelAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge{
	NSLog(@"cancel");
}

@end

