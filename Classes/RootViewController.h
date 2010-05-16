//
//  RootViewController.h
//  WPSC Sales
//
//  Created by Zhimeng Han on 28/04/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

@interface RootViewController : UITableViewController {
	IBOutlet UITableViewCell *blogURLTableViewCell;
    IBOutlet UITableViewCell *userNameTableViewCell;
    IBOutlet UITableViewCell *passwordTableViewCell;
	
	IBOutlet UITextField *blogURLTextField;
    IBOutlet UITextField *userNameTextField;
    IBOutlet UITextField *passwordTextField;
	
	IBOutlet UILabel *blogURLLabel;
    IBOutlet UILabel *userNameLabel;
    IBOutlet UILabel *passwordLabel;
}
-(NSString *)getURL;
-(NSString *)getUsername;
-(NSString *)getPassword;

@end
