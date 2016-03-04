//
//  MasterViewController.h
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UISearchDisplayDelegate>

@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,retain)UISearchDisplayController *searchController;



@end
