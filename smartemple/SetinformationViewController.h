//
//  SetinformationViewController.h
//  smartemple
//
//  Created by wang on 16/3/29.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetinformationViewController : UIViewController<UITextFieldDelegate>


@property(nonatomic,weak)IBOutlet UITextField * nickname;
-(IBAction)Back:(id)sender;
-(IBAction)Finsh:(id)sender;
-(IBAction)Sex:(id)sender;

@end
