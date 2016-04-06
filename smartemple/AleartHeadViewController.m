//
//  AleartHeadViewController.m
//  smartemple
//
//  Created by wang on 16/4/5.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "AleartHeadViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "smartemple.pch"
#import "UserModel.h"
#import "MJExtension.h"
#import "MyViewController.h"
#import "UIImageView+WebCache.h"

@interface AleartHeadViewController (){
    
     NSString *encodedImageStr;
}

@end

@implementation AleartHeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.finishUpload = @"uploading";
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hud];
    self.hud.labelText = @"上传中...";//显示提示
    //hud.dimBackground = YES;//使背景成黑灰色，让MBProgressHUD成高亮显示
    self.hud.square = YES;//设置显示框的高度和宽度一样
    
    
    //    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    
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
    
    
    [self loadHead];
    
    [self modifyUIButton:self.nextBtn];
}

-(void)loadHead{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"token"];
    NSString *userID = [userDef stringForKey:@"userID"];
    NSDictionary *parameters = @{@"userid":userID,@"access_token":token};
    [manager GET:My_API parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);

         photoView.contentMode =  UIViewContentModeScaleAspectFill;
         photoView.clipsToBounds  = YES;
        [photoView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://temple.irockwill.com/userimg/avatar/%@",responseObject[0][@"avatar"]]] placeholderImage:[UIImage imageNamed:@"avatar@2x.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [photoView setImage:photoView.image];
            
            photoView.layer.masksToBounds = YES;
            photoView.layer.cornerRadius = photoView.frame.size.width/2;
            
            //头像边框
            photoView.layer.borderColor = [UIColor whiteColor].CGColor;
            photoView.layer.borderWidth = 2.0;
            
        }];
        
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             //             [self.hud setHidden:YES];
             NSLog(@"请求失败,%@",error);
         }];
    
}


- (void)modifyUIButton: (UIButton *) button {
    button.backgroundColor = [UIColor grayColor];
    CGRect rect = button.frame;
    rect.size.height = 50;
    button.frame = rect;
    button.layer.cornerRadius = 6.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma UIImagePickerController Delegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //	[picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 按钮
-(IBAction)photo:(id)sender//获得头像
{
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
//    [self putimageUp];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 头像上传
//上传头像方法
//
//-(void)putimageUp
//{
//    
//
//    
//}



- (IBAction)saveuserimage:(id)sender {
    
    
    NSData *data = UIImagePNGRepresentation(photoView.image);
    encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"token"];
    NSString *userID = [userDef stringForKey:@"userID"];
    NSDictionary *parameters=@{@"avatar":encodedImageStr,@"access_token":token,@"userid":userID};
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
