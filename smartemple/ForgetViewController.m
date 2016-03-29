//
//  ForgetViewController.m
//  smartemple
//
//  Created by wang on 16/3/3.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "ForgetViewController.h"
#import "AFNetworking.h"
#import "smartemple.pch"
#import "MJExtension.h"
#import "MBProgressHUD.h"
@interface ForgetViewController ()

@property MBProgressHUD *hud;

@end

@implementation ForgetViewController

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)Back:(id)sender{

    [self dismissViewControllerAnimated:YES completion:nil];
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
        NSDictionary *parameters = @{@"phone":self.phone.text,@"type":@"2"};
        [manager POST:verify_API parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            
//            if ([responseObject[@"msg"]isEqualToString:@"已被注册"]) {
//                self.hud.labelText = @"帐号已被注册";//显示提示
//                self.hud.labelFont = TextFont;
//                [self.hud show:YES];
//                self.hud.square = YES;
//                [self.hud hide:YES afterDelay:2];
//            }else{
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
                
                
                     
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            
            
        }];
        
    }
    
}
-(IBAction)Next:(id)sender{

    if([self.phone.text isEqualToString:@""]||[self.verify.text isEqualToString:@""]||[self.password.text isEqualToString:@""]) {
        
        self.hud.labelText = @"请输入正确格式";//显示提示
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
        
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"vcode":self.verify.text,@"username":self.phone.text,@"password":self.password.text};
        [manager POST:regist_API parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            if ([responseObject[@"msg"]isEqualToString:@"用户名不存在"]) {
                self.hud.labelText = @"没有此帐号";//显示提示
                self.hud.labelFont = TextFont;
                [self.hud show:YES];
                self.hud.square = YES;
                [self.hud hide:YES afterDelay:2];
            }else if([responseObject[@"msg"]isEqualToString:@"验证码不正确"]){
                self.hud.labelText = @"验证码不正确";//显示提示
                self.hud.labelFont = TextFont;
                [self.hud show:YES];
                self.hud.square = YES;
                [self.hud hide:YES afterDelay:2];
                
            }else if([responseObject[@"msg"]isEqualToString:@"修改成功"]){
                self.hud.labelText = @"密码修改成功";//显示提示
                self.hud.labelFont = TextFont;
                [self.hud show:YES];
                self.hud.square = YES;
                [self.hud hide:YES afterDelay:2];
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            
            
        }];
    }
    
    



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
