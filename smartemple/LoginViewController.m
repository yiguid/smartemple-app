//
//  LoginViewController.m
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "LoginViewController.h"
#import "MasterViewController.h"
#import "MasterFirstViewController.h"
#import "TempleViewController.h"
#import "MakeViewController.h"
#import "MyViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "smartemple.pch"
#import "RegistViewController.h"
#import "MBProgressHUD.h"
@interface LoginViewController ()
@property MBProgressHUD *hud;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hud];
    
    self.account.delegate = self;
    self.password.delegate = self;
    self.account.keyboardType = UIKeyboardTypeNumberPad;
    self.password.returnKeyType = UIReturnKeyDone;
    self.password.secureTextEntry = YES;
    
    CGRect rect = self.account.frame;
    rect.size.height = 40;
    self.account.frame = rect;
    self.account.layer.cornerRadius = 6.0;
    CGRect prect = self.password.frame;
    prect.size.height = 40;
    self.password.frame = prect;
    self.password.layer.cornerRadius = 6.0;
    
    verfiy = [[Verfiy alloc]init];
    
}

- (IBAction)logBtn:(id)sender{
    
    
    BOOL mobileNum;
    mobileNum = [verfiy validateMobile:self.account.text];
    
    
    
    if([self.account.text isEqualToString:@""]||[self.password.text isEqualToString:@""]) {
        
        self.hud.labelText = @"请输入正确格式";//显示提示
        self.hud.labelFont = TextFont;
        [self.hud show:YES];
        self.hud.square = YES;
        [self.hud hide:YES afterDelay:2];
        
    }   else{
        
        
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"username":self.account.text,@"password":self.password.text};
        [manager POST:login_API parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            NSDictionary * userDic = responseObject[@"user"];
            
            
            if ([userDic[@"msg"]isEqualToString:@"error"]) {
                
                self.hud.labelText = @"请输入正确号码";//显示提示
                self.hud.labelFont = TextFont;
                [self.hud show:YES];
                self.hud.square = YES;
                [self.hud hide:YES afterDelay:2];
                
            }else{
                
                
                
                //存储token值
                NSString *Token = userDic[@"access_token"];
                NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
                [userDef setObject:Token forKey:@"token"];
                //存储用户id
                NSString * userID = userDic[@"id"];
                [userDef setObject:userID forKey:@"userID"];
                //存储用户姓名
                NSString * username = userDic[@"realname"];
                [userDef setObject:username forKey:@"realname"];
                NSLog(@"请求成功");
                
                UITabBarController *tabBarController = [[UITabBarController alloc]init];
                
                [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                                   nil] forState:UIControlStateNormal];
                
                [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIColor blackColor], NSForegroundColorAttributeName,
                                                                   nil] forState:UIControlStateSelected];
                
                
                MasterFirstViewController *masterViewController = [[MasterFirstViewController
                                                               alloc] init];
                UINavigationController *masterNavigationController =
                [[UINavigationController alloc] initWithRootViewController:
                 masterViewController];
                masterNavigationController.tabBarItem.title=@"大德";
                masterNavigationController.tabBarItem.image = [[UIImage imageNamed:@"1_n@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                masterNavigationController.tabBarItem.selectedImage = [[UIImage imageNamed:@"1_n@2x-2.png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                [masterNavigationController.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0,0, 0)];
                
                
                
                [tabBarController addChildViewController:masterNavigationController];
                
                
                TempleViewController *templeViewController = [[TempleViewController
                                                               alloc] init];
                UINavigationController *templeNavigationController =
                [[UINavigationController alloc] initWithRootViewController:
                 templeViewController];
                templeNavigationController.tabBarItem.title=@"寺院";
                templeNavigationController.tabBarItem.image = [[UIImage imageNamed:@"2_n@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                templeNavigationController.tabBarItem.selectedImage = [[UIImage imageNamed:@"2_n@2x-2.png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                [templeNavigationController.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0,0, 0)];
                
                [tabBarController addChildViewController:templeNavigationController];
                
                
                MakeViewController *makeViewController = [[MakeViewController
                                                           alloc] init];
                UINavigationController *makeNavigationController =
                [[UINavigationController alloc] initWithRootViewController:
                 makeViewController];
                makeNavigationController.tabBarItem.title=@"发现";
                makeNavigationController.tabBarItem.image = [[UIImage imageNamed:@"3_n@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                makeNavigationController.tabBarItem.selectedImage = [[UIImage imageNamed:@"3_n@2x-2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                [makeNavigationController.tabBarItem setImageInsets:UIEdgeInsetsMake(0,0,0, 0)];
                
                [tabBarController addChildViewController:makeNavigationController];
                
                
                MyViewController *myViewController = [[MyViewController
                                                       alloc] init];
                UINavigationController *myNavigationController =
                [[UINavigationController alloc] initWithRootViewController:
                 myViewController];
                myNavigationController.tabBarItem.title=@"我的";
                myNavigationController.tabBarItem.image = [[UIImage imageNamed:@"4_n@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                myNavigationController.tabBarItem.selectedImage = [[UIImage imageNamed:@"4_n@2x-2.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                [myNavigationController.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0,0, 0)];
                
                [tabBarController addChildViewController:myNavigationController];
                
                
                
                
                self.view.window.rootViewController = tabBarController;
            
            
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            
            
        }];

        
        
    }
}
- (IBAction)weixinBtn:(id)sender{


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 键盘功能
-(IBAction)backgroup:(id)sender
{
    [self.account resignFirstResponder];
    [self.password resignFirstResponder];
    
   
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    if(textField== self.account)
    {
        [self.password becomeFirstResponder];
    }
    else
    {
        [self backgroup:nil];
        [self logBtn:nil];
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.account resignFirstResponder];
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
