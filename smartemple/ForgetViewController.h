//
//  ForgetViewController.h
//  smartemple
//
//  Created by wang on 16/3/3.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Verfiy.h"
#import "Net.h"
@interface ForgetViewController : UIViewController<UITextFieldDelegate>{
    
    Verfiy * verfiy;
    
}

-(IBAction)Back:(id)sender;


@property(nonatomic,weak) IBOutlet UITextField * phone;
@property(nonatomic,weak) IBOutlet UITextField * verify;
@property(nonatomic,weak) IBOutlet UITextField * password;
@property (weak, nonatomic) IBOutlet UIButton * verifyBtn;

-(IBAction)verify:(id)sender;
-(IBAction)Next:(id)sender;

@end
