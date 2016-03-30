//
//  MasterFirstViewController.h
//  smartemple
//
//  Created by wang on 16/3/30.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterFirstViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong)UICollectionView *collectionView;

@end
