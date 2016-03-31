//
//  ActivitySecondViewController.m
//  smartemple
//
//  Created by wang on 16/3/10.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "ActivitySecondViewController.h"
#import "smartemple.pch"
#import "ActiviModel.h"
#import "ActivitySecondTableViewCell.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
@interface ActivitySecondViewController (){

    UIWebView * webView;
    
}

@end

@implementation ActivitySecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    self.navigationItem.title = @"活动详情";
    
    UIColor * color = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    

    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
//    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
//    NSString *token = [userDef stringForKey:@"token"];
//    NSDictionary *parameters = @{@"id":self.activityID,@"access_token":token,@"type":self.type};
//    [manager GET:Temple_activity_API parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
//        NSLog(@"%@",responseObject[@"content"]);
        webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,0, wScreen, hScreen)];
        webView.backgroundColor = [UIColor whiteColor];
        [webView setUserInteractionEnabled:YES];
        webView.delegate = self;
        [webView setOpaque:NO];
        [webView setScalesPageToFit:YES];
    
    if ([self.activityString isEqualToString:@"new"]) {
        
        NSString *urlstring = [NSString stringWithFormat:@"http://temple.irockwill.com/user/activity/id/%@/1/%@",self.activityID,self.type];
        NSURL *url = [[NSURL alloc]initWithString:urlstring];
        
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
        
    }else if ([self.activityString isEqualToString:@"temple"]){
        
        NSString *urlstring = [NSString stringWithFormat:@"http://temple.irockwill.com/activity/id/%@/%@/1/%@",self.templeID,self.activityID,self.type];
        NSURL *url = [[NSURL alloc]initWithString:urlstring];
        
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    }
    
    
        
//        [webView loadHTMLString:responseObject[@"content"] baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];
//        
//        //构造内容
//        NSString *contentImg = [NSString stringWithFormat:@"%@",responseObject[@"content"]];
//        NSString *content =[NSString stringWithFormat:
//                            @"<html>"
//                            "<style type=\"text/css\">"
//                            "<!--"
//                            "body{font-size:40pt;line-height:60pt;}"
//                            "-->"
//                            "</style>"
//                            "<body>"
//                            "%@"
//                            "</body>"
//                            "</html>"
//                            , contentImg];
//        
//        //让self.contentWebView加载content
//        [webView loadHTMLString:content baseURL:nil];
        
        
        
        [self.view addSubview:webView];
        
//        NSLog(@"成功");
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//        
//        
//    }];
    

    
    
    
   


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
