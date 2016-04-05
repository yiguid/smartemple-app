//
//  AleartHeadViewController.h
//  smartemple
//
//  Created by wang on 16/4/5.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface AleartHeadViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>{
    
    IBOutlet UIButton *photo;
    IBOutlet UIImageView *photoView;
    //头像图片上传
    NSData * headImage;
    NSString *headImageStr;
  
}

// 图片的地址
@property(nonatomic,strong)NSString *urlString;
// 图片的路径
@property(nonatomic,strong)NSString *imageQiniuUrl;
@property(nonatomic,strong)NSString *finishUpload;
@property(nonatomic,strong) MBProgressHUD *hud;
//头像
@property (nonatomic )UIImagePickerController *pickerController;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property(nonatomic,strong)NSString * userID;


@end
