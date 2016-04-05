//
//  AleartNameViewController.m
//  smartemple
//
//  Created by wang on 16/4/5.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "AleartNameViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "smartemple.pch"
#import "UserModel.h"
#import "MJExtension.h"
#import "MyViewController.h"
#import "UIImageView+WebCache.h"
@interface AleartNameViewController ()
@property(nonatomic,strong) MBProgressHUD *hud;

@end

@implementation AleartNameViewController

- (void)modifyUITextField: (UITextField *) textField {
    CGRect rect = textField.frame;
    rect.size.height = 50;
    textField.frame = rect;
//    [textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)modifyUIButton: (UIButton *) button {
    button.backgroundColor = [UIColor grayColor];
    CGRect rect = button.frame;
    rect.size.height = 50;
    button.frame = rect;
    button.layer.cornerRadius = 6.0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self modifyUIButton:self.alterBtn];
    [self modifyUITextField:self.nickname];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hud];
    self.hud.labelText = @"上传中...";//显示提示
    //hud.dimBackground = YES;//使背景成黑灰色，让MBProgressHUD成高亮显示
    self.hud.square = YES;//设置显示框的高度和宽度一样
    
    [self loadnickname];

}

-(void)loadnickname{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"token"];
    NSString *userID = [userDef stringForKey:@"userID"];
    NSDictionary *parameters = @{@"userid":userID,@"access_token":token};
    [manager GET:My_API parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);

             
        
             name.text = responseObject[0][@"realname"];
             
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             //             [self.hud setHidden:YES];
             NSLog(@"请求失败,%@",error);
         }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)alter:(id)sender{
  
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"token"];
    NSString *userID = [userDef stringForKey:@"userID"];
    NSDictionary *parameters=@{@"realname":self.nickname.text,@"access_token":token,@"userid":userID};
    [manager POST:Aleart_API parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        self.hud.labelText = @"修改成功";//显示提示
        self.hud.labelFont = TextFont;
        [self.hud show:YES];
        self.hud.square = YES;
        [self.hud hide:YES afterDelay:2];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];


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
