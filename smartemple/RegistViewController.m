//
//  RegistViewController.m
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "RegistViewController.h"
#import "AFNetworking.h"
#import "smartemple.pch"
#import "MJExtension.h"
#import "MBProgressHUD.h"
#import "SetinformationViewController.h"
@interface RegistViewController ()

@property MBProgressHUD *hud;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.phone.delegate = self;
    self.verify.delegate = self;
    self.password.delegate = self;
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hud];
    
     self.view.backgroundColor = [UIColor whiteColor];
    
    verfiy = [[Verfiy alloc]init];
    
    CGRect prect = self.phone.frame;
    prect.size.height = 40;
    self.phone.frame = prect;
    self.phone.layer.cornerRadius = 6.0;
    CGRect vrect = self.verify.frame;
    vrect.size.height = 40;
    self.verify.frame = vrect;
    self.verify.layer.cornerRadius = 6.0;
    CGRect rect = self.password.frame;
    rect.size.height = 40;
    self.password.frame = rect;
    self.password.layer.cornerRadius = 6.0;
}


-(IBAction)verify:(id)sender{
    
      BOOL mobileNum;
       mobileNum = [verfiy validateMobile:self.phone.text];
    
    
    
    if ([self.phone.text isEqualToString:@""]) {
        
        self.hud.labelText = @"手机号不能为空...";//显示提示
        self.hud.labelFont = TextFont;
        [self.hud show:YES];
        self.hud.square = YES;
        [self.hud hide:YES afterDelay:2];
        
    }  else if (!mobileNum) {
        self.hud.labelText = @"请输入正确手机号";//显示提示
        self.hud.labelFont = TextFont;
        [self.hud show:YES];
        self.hud.square = YES;
        [self.hud hide:YES afterDelay:2];
    }

    else{
        
        
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"phone":self.phone.text,@"type":@"1"};
        [manager POST:verify_API parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            
            if ([responseObject[@"msg"]isEqualToString:@"已被注册"]) {
                self.hud.labelText = @"帐号已被注册";//显示提示
                self.hud.labelFont = TextFont;
                [self.hud show:YES];
                self.hud.square = YES;
                [self.hud hide:YES afterDelay:2];
            }else{
                __block int timeout=59; //倒计时时间
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
                dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
                dispatch_source_set_event_handler(_timer, ^{
                    if(timeout<=0){ //倒计时结束，关闭
                        dispatch_source_cancel(_timer);
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.verifyBtn setTitle:@"重发验证码" forState:UIControlStateNormal];
                            //                self.verifyBtn.backgroundColor = [UIColor clearColor];
                            self.verifyBtn.userInteractionEnabled = YES;
                        });
                    }else{
                        //            int minutes = timeout / 60;
                        NSInteger sconds = timeout % 60;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            self.verifyBtn.userInteractionEnabled=NO;
                            //                [self.verifyBtn setBackgroundColor:[UIColor clearColor]];
                            self.verifyBtn.titleLabel.text = [NSString stringWithFormat:@"%ld秒",sconds];
                            [self.verifyBtn setTitle:[NSString stringWithFormat:@"%ld秒",sconds] forState:UIControlStateNormal];
                        });
                        timeout --;
                    }    });
                dispatch_resume(_timer);
                

            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            
            
        }];
        
    }

}
-(IBAction)regist:(id)sender{
    
    
    
    BOOL mobileNum;
    mobileNum = [verfiy validateMobile:self.phone.text];
    
        
    if([self.phone.text isEqualToString:@""]||[self.verify.text isEqualToString:@""]||[self.password.text isEqualToString:@""]) {
        
                self.hud.labelText = @"请输入正确格式";//显示提示
                self.hud.labelFont = TextFont;
                [self.hud show:YES];
                self.hud.square = YES;
                [self.hud hide:YES afterDelay:2];
        
            } else if (!mobileNum) {
                
                self.hud.labelText = @"请输入正确手机号";//显示提示
                self.hud.labelFont = TextFont;
                [self.hud show:YES];
                self.hud.square = YES;
                [self.hud hide:YES afterDelay:2];
                
            }else if(6>self.password.text.length || self.password.text.length>12){
                
                self.hud.labelText = @"密码长度大于6小于12";//显示提示
                self.hud.labelFont = TextFont;
                [self.hud show:YES];
                self.hud.square = YES;
                [self.hud hide:YES afterDelay:2];
                
            }else{
                
                CATransition *animation = [CATransition animation];
                [animation setDuration:1.0];
                [animation setType:kCATransitionFade]; //淡入淡出kCATransitionFade
                [animation setSubtype:kCATransitionFromRight];
                [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
                [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
                
                UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                SetinformationViewController * setinformation = [storyboard instantiateViewControllerWithIdentifier:@"SetScene"];
                
                
                NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
                //保存验证码
                [Defaults setObject:self.verify.text forKey:@"vcode"];
                //保存密码
                [Defaults setObject:self.password.text forKey:@"password"];
                
                [self presentViewController:setinformation animated:NO completion:nil];
            
            }
    
    
}
//
//   if([self.phone.text isEqualToString:@""]||[self.verify.text isEqualToString:@""]||[self.password.text isEqualToString:@""]) {
//        
//        self.hud.labelText = @"请输入正确格式";//显示提示
//        self.hud.labelFont = TextFont;
//        [self.hud show:YES];
//        self.hud.square = YES;
//        [self.hud hide:YES afterDelay:2];
//        
//    }else if(6>self.password.text.length || self.password.text.length>12){
//        self.hud.labelText = @"密码长度大于6小于12";//显示提示
//        self.hud.labelFont = TextFont;
//        [self.hud show:YES];
//        self.hud.square = YES;
//        [self.hud hide:YES afterDelay:2];
//    }else{
//        
//        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
//        NSDictionary *parameters = @{@"vcode":self.verify.text,@"password":self.password.text};
//        [manager POST:regist_API parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"%@",responseObject);
//            if ([responseObject[@"msg"]isEqualToString:@"用户名已存在"]) {
//                self.hud.labelText = @"帐号已被注册";//显示提示
//                self.hud.labelFont = TextFont;
//                [self.hud show:YES];
//                self.hud.square = YES;
//                [self.hud hide:YES afterDelay:2];
//            }else if([responseObject[@"msg"]isEqualToString:@"验证码不正确"]){
//                self.hud.labelText = @"验证码不正确";//显示提示
//                self.hud.labelFont = TextFont;
//                [self.hud show:YES];
//                self.hud.square = YES;
//                [self.hud hide:YES afterDelay:2];
//            
//            }else if([responseObject[@"msg"]isEqualToString:@"注册成功"]){
//                self.hud.labelText = @"帐号注册成功";//显示提示
//                self.hud.labelFont = TextFont;
//                [self.hud show:YES];
//                self.hud.square = YES;
//                [self.hud hide:YES afterDelay:2];
//                
//                          }
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"%@",error);
//            
//            
//        }];
//    }




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)Back:(id)sender{

    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.phone resignFirstResponder];
    [self.verify resignFirstResponder];
    [self.password resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
