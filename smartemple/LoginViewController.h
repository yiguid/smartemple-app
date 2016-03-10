//
//  LoginViewController.h
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LoginViewController : UIViewController<UITextFieldDelegate>


@property(nonatomic,weak) IBOutlet UITextField * account;
@property(nonatomic,weak) IBOutlet UITextField * password;



- (IBAction)logBtn:(id)sender;
- (IBAction)weixinBtn:(id)sender;

@end
