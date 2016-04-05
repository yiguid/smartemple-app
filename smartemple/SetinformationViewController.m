//
//  SetinformationViewController.m
//  smartemple
//
//  Created by wang on 16/3/29.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "SetinformationViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "smartemple.pch"
#import "UserModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
@interface SetinformationViewController (){

    NSString * sexstring;
    NSString * imagestring;
    NSString *encodedImageStr;
}
@property MBProgressHUD *hud;

@end

@implementation SetinformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //头像圆形
    [photoView.layer setCornerRadius:CGRectGetHeight([photoView bounds])/2];
    photoView.layer.masksToBounds = YES;
    
    //头像边框
    photoView.layer.borderColor = [UIColor whiteColor].CGColor;
    photoView.layer.borderWidth = 1.5;
    
    //头像 图片 获取
    _pickerController = [[UIImagePickerController alloc] init];
    _pickerController.delegate = self;
    _pickerController.allowsEditing = YES;
    sexstring = @"0";
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hud];
    
    
    CGRect rect = self.nickname.frame;
    rect.size.height = 40;
    self.nickname.frame = rect;
    self.nickname.layer.cornerRadius = 6.0;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)photo:(id)sender//获得头像
{
     imagestring = @"头像";
    
     [self selectForAlbumButtonClick];

}

#pragma mark - 头像的选取
- (void)selectForAlbumButtonClick{
    
    UIActionSheet *myActionSheet = [[UIActionSheet alloc]
                                    initWithTitle:nil
                                    delegate:self
                                    cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                    otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    
    [myActionSheet showInView:self.view];
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        return; }
    
    switch (buttonIndex)
    {
        case 0:  //打开照相机拍照
            [self takePhoto];
            break;
            
        case 1:  //打开本地相册
            [self LocalPhoto];
            break;
    }
    //[actionSheet removeFromSuperview];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)takePhoto{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else
    {
        NSLog(@"请在真机中使用");
    }
}
- (void)LocalPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
    
}
-(void)headImage//头像加载
{
    NSString *urlStr=[NSString stringWithFormat:@"%@",headImageStr];
    NSURL *urlHead=[NSURL URLWithString:urlStr];
    NSData *datahead=[NSData dataWithContentsOfURL:urlHead];
    UIImage *imageHead=[UIImage imageWithData:datahead];
    photoView.image = imageHead;
    
}


//图像选取器的委托方法，选完图片后回调该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    
    photoView.image=image;
    //    imageForHead =  editingInfo[UIImagePickerControllerOriginalImage];
    headImage=UIImagePNGRepresentation(image);
    //上传头像方法
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}




-(IBAction)mSex:(id)sender{
    self.msexBtn.backgroundColor = [UIColor orangeColor];
    self.wsexBtn.backgroundColor = [UIColor clearColor];
    if ([sexstring isEqualToString:@"1"]) {
        sexstring=@"0";
    }else{
        sexstring=@"0";
    }
    NSLog(@"%@",sexstring);

}
-(IBAction)wSex:(id)sender{
    
    self.wsexBtn.backgroundColor = [UIColor orangeColor];
    self.msexBtn.backgroundColor = [UIColor clearColor];
    if ([sexstring isEqualToString:@"0"]) {
        sexstring=@"1";
    }else{
        sexstring=@"1";
    }
    NSLog(@"%@",sexstring);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(IBAction)Back:(id)sender{
    
     [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)Finsh:(id)sender{
    
    if([self.nickname.text isEqualToString:@""]) {
        
        self.hud.labelText = @"请输入昵称";//显示提示
        self.hud.labelFont = TextFont;
        [self.hud show:YES];
        self.hud.square = YES;
        [self.hud hide:YES afterDelay:2];
        
    }
//    if ([imagestring isEqualToString:@"头像"]) {
        NSData *data = UIImagePNGRepresentation(photoView.image);
        encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    }else{
//        UIImageView * imageview = [[UIImageView alloc]init];
//        imageview.image = [UIImage imageNamed:@"默认头像"];
//        NSData *data = UIImagePNGRepresentation(imageview.image);
//        encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    
//    }
        
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        NSString *vcode = [Defaults objectForKey:@"vcode"];
        NSString *password = [Defaults objectForKey:@"password"];
    
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        NSDictionary *parameters=@{@"vcode":vcode,@"password":password,@"gender":sexstring,@"realname":self.nickname.text,@"avatar":encodedImageStr};
        [manager POST:regist_API parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
            NSLog(@"%@",responseObject);
            if ([responseObject[@"msg"]isEqualToString:@"用户名已存在"]) {
                                self.hud.labelText = @"帐号已被注册";//显示提示
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
                
                            }else if([responseObject[@"msg"]isEqualToString:@"注册成功"]){
                                self.hud.labelText = @"帐号注册成功";//显示提示
                                self.hud.labelFont = TextFont;
                                [self.hud show:YES];
                                self.hud.square = YES;
                                [self.hud hide:YES afterDelay:2];
                                
                }

    
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];


}

@end
