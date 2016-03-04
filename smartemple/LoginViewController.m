//
//  LoginViewController.m
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "LoginViewController.h"
#import "MasterViewController.h"
#import "TempleViewController.h"
#import "MakeViewController.h"
#import "MyViewController.h"
@interface LoginViewController ()
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.account.delegate = self;
    self.password.delegate = self;
    self.account.returnKeyType = UIReturnKeyNext;
    self.password.returnKeyType = UIReturnKeyDone;
    
    
}

- (IBAction)logBtn:(id)sender{
    

    
    UITabBarController *tabBarController = [[UITabBarController alloc]init];

    
    MasterViewController *masterViewController = [[MasterViewController
                                                   alloc] init];
    UINavigationController *masterNavigationController =
    [[UINavigationController alloc] initWithRootViewController:
     masterViewController];
    masterNavigationController.tabBarItem.title=@"法师";
    masterNavigationController.tabBarItem.image=[UIImage imageNamed:@"dian.png"];
    [tabBarController addChildViewController:masterNavigationController];
    
    
    TempleViewController *templeViewController = [[TempleViewController
                                                   alloc] init];
    UINavigationController *templeNavigationController =
    [[UINavigationController alloc] initWithRootViewController:
     templeViewController];
    templeNavigationController.tabBarItem.title=@"寺院";
    templeNavigationController.tabBarItem.image=[UIImage imageNamed:@"dian.png"];
    [tabBarController addChildViewController:templeNavigationController];
    
    
    MakeViewController *makeViewController = [[MakeViewController
                                                   alloc] init];
    UINavigationController *makeNavigationController =
    [[UINavigationController alloc] initWithRootViewController:
     makeViewController];
    makeNavigationController.tabBarItem.title=@"发现";
    makeNavigationController.tabBarItem.image=[UIImage imageNamed:@"dian.png"];
    [tabBarController addChildViewController:makeNavigationController];
    
    
    MyViewController *myViewController = [[MyViewController
                                                   alloc] init];
    UINavigationController *myNavigationController =
    [[UINavigationController alloc] initWithRootViewController:
     myViewController];
    myNavigationController.tabBarItem.title=@"我的";
    myNavigationController.tabBarItem.image=[UIImage imageNamed:@"dian.png"];
    [tabBarController addChildViewController:myNavigationController];
    
    
    
    
    self.view.window.rootViewController = tabBarController;
 

}
- (IBAction)regBtn:(id)sender{
    
   
}
- (IBAction)forgetBtn:(id)sender{
    
 


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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
