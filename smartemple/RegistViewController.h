//
//  RegistViewController.h
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Verfiy.h"
#import "Net.h"
@interface RegistViewController : UIViewController<UITextFieldDelegate>{

     Verfiy * verfiy;

}

@property(nonatomic,weak) IBOutlet UITextField * phone;
@property(nonatomic,weak) IBOutlet UITextField * verify;
@property(nonatomic,weak) IBOutlet UITextField * password;
@property (weak, nonatomic) IBOutlet UIButton * verifyBtn;
-(IBAction)Back:(id)sender;
-(IBAction)regist:(id)sender;
-(IBAction)verify:(id)sender;

@end
