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

- (id)getValueArray{
	return valueArray;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

- (void)request: (XMLRPCRequest *)request didReceiveResponse: (XMLRPCResponse *)response{
	NSString *message = [response body];
	valueArray = [[NSMutableArray alloc] init];
	//NSLog(message);
	NSData *data = [[NSData alloc] initWithData:[message dataUsingEncoding:NSASCIIStringEncoding]];

	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
	[parser setDelegate:self];
    [parser parse];
	
	NSLog(@"%@", valueArray);
	
	UIViewController *targetViewController = [[UIViewController alloc] initWithNibName:@"RSSTableController" bundle:nil];
	
	[self.navigationController pushViewController:targetViewController animated:YES];
	NSLog(@"response");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName caseInsensitiveCompare:@"struct"] != 0){
		if ([elementName isEqualToString:@"name"]) {
			value = FALSE;
			return;
		} else if ([elementName isEqualToString:@"string"]) {
			value = TRUE;
			return;
		}
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if ((![string hasPrefix:@"\n"]) && (![string hasSuffix:@"\n"])) {
		[valueArray addObject:string];
	}
}

-(void)saveBlog:(id)sender{
	RootViewController *rv = [[navigationController viewControllers] lastObject];
	user = [rv getUsername];
	pwd = [rv getPassword];
	url = [rv getURL];
	
	
    // Override point for customization after app launch
	NSString *xmlrpcURL = [NSString stringWithFormat:@"http://%@/xmlrpc.php", url];
	NSURL *URL = [NSURL URLWithString: xmlrpcURL];
	XMLRPCRequest *request = [[XMLRPCRequest alloc] initWithURL: URL];
	XMLRPCConnectionManager *manager = [XMLRPCConnectionManager sharedManager];
	[request setMethod: @"wp.getUsersBlogs" withParameters: [NSArray arrayWithObjects: user, pwd, nil]];
	[manager spawnConnectionWithXMLRPCRequest: request delegate: self];
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

