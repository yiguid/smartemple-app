//
//  SetinformationViewController.h
//  smartemple
//
//  Created by wang on 16/3/29.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetinformationViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>{
    
    IBOutlet UIButton *photo;
    IBOutlet UIImageView *photoView;
    //头像图片上传
    NSData * headImage;
    NSString *headImageStr;
    
    
}


//头像
@property (nonatomic )UIImagePickerController *pickerController;

@property(nonatomic,weak)IBOutlet UIButton * msexBtn;
@property(nonatomic,weak)IBOutlet UIButton * wsexBtn;
@property(nonatomic,weak)IBOutlet UITextField * nickname;
-(IBAction)Back:(id)sender;
-(IBAction)Finsh:(id)sender;
-(IBAction)mSex:(id)sender;
-(IBAction)wSex:(id)sender;
@end
