//
//  WishAllViewController.m
//  smartemple
//
//  Created by wang on 16/3/10.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "WishAllViewController.h"
#import "smartemple.pch"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "WishTableViewCell.h"
#import "Wishmodel.h"
#import "LZAutoScrollView.h"
@interface WishAllViewController ()
@property(nonatomic, strong)NSMutableArray * WishArr;

@end

@implementation WishAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.WishArr = [[NSMutableArray alloc]init];
    
    
    LZAutoScrollView *autoScrollView = [[LZAutoScrollView alloc] initWithFrame:CGRectMake(0,64,wScreen,3*wScreen/4)];
    
    autoScrollView.pageControlAligment = PageControlAligmentCenter;
    autoScrollView.images = @[
                              @"http://smartemple.com/assets/images/qf1.png",
                              @"http://smartemple.com/assets/images/qf2.png",
                              @"http://smartemple.com/assets/images/qf3.png"
                              ];
    
    
    autoScrollView.itemClicked = ^(int index) {
        NSLog(@"index: %d11", index);
    };
    [self.view addSubview:autoScrollView];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,wScreen*3/4, wScreen, hScreen-wScreen*3/4) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    
    

    
   [self loadWish];
   [self text];
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (NSString *)deviceIPAdress {
//    InitAddresses();
//    GetIPAddresses();
//    GetHWAddresses();
//    return [NSString stringWithFormat:@"%s", ip_names[1]];
//}

-(void)text{
    
    _textView=[[UIView alloc]initWithFrame:CGRectMake(0,hScreen - 44, wScreen, 44)];
    _textView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    [self.view addSubview:_textView];
    
    _textButton=[UIButton buttonWithType:UIButtonTypeSystem];
    _textButton.frame=CGRectMake(wScreen - 55, 8, 45, 30);
    _textButton.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    [_textButton setTitle:@"发送" forState:UIControlStateNormal];
    [_textButton setTitleColor:[UIColor colorWithRed:121/255.0 green:121/255.0 blue:121/255.0 alpha:1] forState:
     UIControlStateNormal];
    
    _textButton.layer.masksToBounds = YES;
    _textButton.layer.cornerRadius = 4.0;
    
    [_textButton addTarget:self action:@selector(sendmessage:) forControlEvents:UIControlEventTouchUpInside];
    [_textView addSubview:_textButton];
    
    _textFiled=[[UITextView alloc]initWithFrame:CGRectMake(10, 4.5, wScreen - 75, 35)];
    _textFiled.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _textFiled.delegate = self;
    _textFiled.returnKeyType=UIReturnKeyDone;
    // _textFiled.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    [_textView addSubview:_textFiled];
    
    //给最外层的view添加一个手势响应UITapGestureRecognizer
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tapGr];
    
    //键盘弹出通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    //键盘隐藏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name: UIKeyboardWillHideNotification object:nil];
    
    
}

-(void)sendmessage:(id)sender{
    
    if (_textFiled.text.length==0) {
        
        return;
        
    }
    
    
//    NSString * ip = [self deviceIPAdress];
//    NSLog(@"本机IP: %@",ip);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString * url = [NSString stringWithFormat:@"%@/message",Temple_API];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"token"];
    NSString *userID = [userDef stringForKey:@"userID"];
    NSString *username = [userDef stringForKey:@"realname"];
    NSDictionary * param = @{@"realname":username,@"content":_textFiled.text,@"templeid":self.temple.templeid,@"location":@"北京",@"fromurl":@"app/qf",@"ip":@"1",@"userid":userID,@"access_token":token};
    [manager POST:url parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSLog(@"评论成功");
              [self.view endEditing:YES];
              self.textFiled.text = @"";
              
              [self loadWish];
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSLog(@"请求失败,%@",error);
          }];
    
    
    
    
}



-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.25 animations:^{
        [UIView setAnimationCurve:7];
        _textView.frame = CGRectMake(0, hScreen-44, wScreen, 44);
        _tableView.frame=CGRectMake(0, 0, wScreen, hScreen);
    }];
    
    [_textFiled resignFirstResponder];
    
}

//键盘显示事件
- (void) keyboardShow:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardEndY = value.CGRectValue.origin.y;
    
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        self.view.center = CGPointMake(self.view.center.x, keyBoardEndY  - self.view.bounds.size.height/2.0);
    }];
    
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
    [UIView animateWithDuration:0.25 animations:^{
        [UIView setAnimationCurve:7];
        _textView.frame = CGRectMake(0, hScreen-44, wScreen,44);
        _tableView.frame=CGRectMake(0, 0, wScreen, hScreen);
    }];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    
    [UIView animateWithDuration:0.25 animations:^{
        [UIView setAnimationCurve:7];
        _textView.frame = CGRectMake(0, hScreen-44, wScreen, 44);
        _tableView.frame=CGRectMake(0, 0, wScreen, hScreen);
    }];
    
    
    return YES;
}



-(void)loadWish{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"token"];
    NSDictionary *parameters = @{@"templeid":self.temple.templeid,@"page":@"1",@"limit":@"10",@"access_token":token};
    NSString *url = [NSString stringWithFormat:@"%@/wish",Temple_API];
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        self.WishArr = [Wishmodel mj_objectArrayWithKeyValuesArray:responseObject[@"temple"]];
        
        
        [self.tableView reloadData];
        
        NSLog(@"请求成功");
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.WishArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *ID = [NSString stringWithFormat:@"WishCell"];
    WishTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[WishTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    
    [cell setup:self.WishArr[indexPath.row]];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Wishmodel *model = [self.WishArr objectAtIndex:indexPath.row];
    return [model getCellHeight];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    
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
