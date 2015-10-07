//
//  FirstViewController.m
//  smartemple-app
//
//  Created by Guyi on 15/10/7.
//  Copyright © 2015年 smartemple. All rights reserved.
//

#import "FirstViewController.h"
#import "AFNetworking.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *str=[NSString stringWithFormat:@"https://alpha-api.app.net/stream/0/posts/stream/global"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
