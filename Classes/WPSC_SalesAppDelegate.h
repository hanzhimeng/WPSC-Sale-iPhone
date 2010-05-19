//
//  WPSC_SalesAppDelegate.h
//  WPSC Sales
//
//  Created by Zhimeng Han on 28/04/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//
#import "XMLRPCConnectionDelegate.h"
@interface WPSC_SalesAppDelegate : NSObject <UIApplicationDelegate, XMLRPCConnectionDelegate>{
    
    UIWindow *window;
    UINavigationController *navigationController;
	NSMutableArray *valueArray;
	BOOL value;
	NSString *user, *url, *pwd, *salesLogRSS;
}

- (IBAction)saveBlog:(id)sender;
- (id)getValueArray;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

