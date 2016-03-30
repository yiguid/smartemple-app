//
//  MasterFirstViewController.m
//  smartemple
//
//  Created by wang on 16/3/30.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "MasterFirstViewController.h"
#import "smartemple.pch"
#import "LZAutoScrollView.h"
#import "MasterCollectionViewCell.h"
#import "AFNetworking.h"
#import "MasterSectionViewController.h"
#import "MJExtension.h"
#import "masterModel.h"
#import "UIImageView+WebCache.h"
@interface MasterFirstViewController ()
@property(nonatomic, strong)NSMutableArray * recMasterArr;
@end

@implementation MasterFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    LZAutoScrollView *autoScrollView = [[LZAutoScrollView alloc] initWithFrame:CGRectMake(0,64,wScreen,150*wScreen/375)];
    autoScrollView.titles = @[@"一", @"二", @"三"];
    autoScrollView.placeHolder = [UIImage imageNamed:@"place.jpg"];
    autoScrollView.pageControlAligment = PageControlAligmentCenter;
    autoScrollView.images = @[
                              @"http://img2.3lian.com/2014/f7/5/d/22.jpg",
                              @"http://image.tianjimedia.com/uploadImages/2011/327/1VPRY46Q4GB7.jpg",
                              @"http://img6.faloo.com/Picture/0x0/0/747/747488.jpg"
                              ];
    
    autoScrollView.itemClicked = ^(int index) {
        NSLog(@"index: %d", index);
    };
    [self.view addSubview:autoScrollView];
    
    self.navigationItem.title = @"大德";
    
    UIColor * color = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    self.navigationController.navigationBar.tintColor =[UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,170*wScreen/375+64, wScreen, hScreen-150*wScreen/375+64) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[MasterCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.recMasterArr = [[NSMutableArray alloc]init];
    [self loadData];
    
}
- (void)imageClicked:(NSInteger)index {
    NSLog(@"index: %ld", index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadData{
    
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"token"];
    NSDictionary *parameters = @{@"page": @"1",@"limit":@"8",@"access_token":token};
    [manager GET:Master_recommend_API parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        self.recMasterArr = [masterModel mj_objectArrayWithKeyValuesArray:responseObject[@"master"]];
        
        [self.collectionView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];
    
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
  
        return self.recMasterArr.count;
        
}


//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MasterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell sizeToFit];
    

        masterModel * model = self.recMasterArr[indexPath.row];
        
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://smartemple.com/%@",model.avatar]] placeholderImage:[UIImage imageNamed:@"avatar@2x.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [cell.imageView setImage:cell.imageView.image];
            //头像圆形
            cell.imageView.layer.masksToBounds = YES;
            cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width/2;
        }];
        
        
        cell.title.text = model.realname;
        
        cell.guanzhuimage.image  =[UIImage imageNamed:@"xin.png"];
        
        if (model.likes==NULL) {
            cell.guanzhulabel.text = @"0";
        }else{
            cell.guanzhulabel.text = model.views;
        }
        
  
    
    return cell;
}

//定义每个UICollectionView 的大小（返回CGSize：宽度和高度）
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(wScreen/5,wScreen/3);
    
}
//定义每个UICollectionView 的间距（返回UIEdgeInsets：上、左、下、右）
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10,10,10,10);
    
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}



//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
        MasterSectionViewController * master = [[MasterSectionViewController alloc]init];
        
        masterModel * model = self.recMasterArr[indexPath.row];
        
        master.master = model;
        
        master.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = barButtonItem;
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"masterid": model.masterid};
        NSString *url = [NSString stringWithFormat:@"%@/views",Master_API];
        
        [manager POST:url parameters:parameters
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  
                  //                  NSLog(@"成功,%@",responseObject);
                  [self loadData];
                  
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  
                  NSLog(@"请求失败,%@",error);
              }];
        
        
        
        [self.navigationController pushViewController:master animated:YES];
        
    
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
