//
//  MasterViewController.m
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "MasterViewController.h"
#import "smartemple.pch"
#import "MasterCollectionViewCell.h"
#import "AFNetworking.h"
#import "MasterSectionViewController.h"
@interface MasterViewController ()

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, wScreen, hScreen - 44) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[MasterCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
  
    self.navigationItem.title = @"法师";
    
    [self loadData];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
    
  
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
   
    [manager GET:Temple_API parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
       
        
    }];

   }

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MasterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell sizeToFit];
    
//    cell.layer.borderColor=[UIColor grayColor].CGColor;
//    cell.layer.borderWidth=0.3;
    
    cell.imageView.image =  [UIImage imageNamed:@"avatar@2x.png"];
   
    cell.title.text = @"法师";
    
    cell.guanzhuimage.image  =[UIImage imageNamed:@"xin.png"];
    cell.guanzhulabel.text = @"1357";
    
    return cell;
}

//定义每个UICollectionView 的大小（返回CGSize：宽度和高度）
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((wScreen-80)/3,100);
    
}
//定义每个UICollectionView 的间距（返回UIEdgeInsets：上、左、下、右）
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(20,20,10,10);
    
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
  
    MasterSectionViewController * master = [[MasterSectionViewController alloc]init];
    
    master.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:master animated:YES];
    
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    //    self.tabBarController.tabBar.hidden = YES;
    
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
