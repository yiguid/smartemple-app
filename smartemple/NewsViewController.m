//
//  NewsViewController.m
//  smartemple
//
//  Created by wang on 16/3/4.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "NewsViewController.h"
#import "smartemple.pch"
#import "NewsModel.h"
#import "NewsTableViewCell.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
@interface NewsViewController (){
    
    UIWebView * webView;
    
}


@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"新闻详情";
    
    UIColor * color = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    self.view.backgroundColor = [UIColor whiteColor];
    
  
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,0, wScreen, hScreen)];
    webView.backgroundColor = [UIColor whiteColor];
    [webView setUserInteractionEnabled:YES];
    webView.delegate = self;
    [webView setOpaque:NO];
    [webView setScalesPageToFit:YES];
    
    
        NSString *urlstring = [NSString stringWithFormat:@"http://temple.irockwill.com/news/id/%@/%@/1",self.templeID,self.newsID];
        NSURL *url = [[NSURL alloc]initWithString:urlstring];
        
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
        
  
    [self.view addSubview:webView];
    
   
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
