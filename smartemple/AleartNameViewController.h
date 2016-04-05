//
//  AleartNameViewController.h
//  smartemple
//
//  Created by wang on 16/4/5.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AleartNameViewController : UIViewController{

    IBOutlet UILabel * name;
}

@property(weak,nonatomic)IBOutlet UITextField * nickname;
@property(weak,nonatomic)IBOutlet UIButton * alterBtn;

-(IBAction)alter:(id)sender;

@end
