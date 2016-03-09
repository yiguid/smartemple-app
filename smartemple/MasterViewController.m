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
#import "MJExtension.h"
#import "masterModel.h"
#import "UIImageView+WebCache.h"
@interface MasterViewController (){

    UISearchBar * mysearch;
    UILabel * label;

}

@property(nonatomic, strong)NSMutableArray * allMasterArr;
@property(nonatomic, strong)NSMutableArray * recMasterArr;
@property(nonatomic, strong)NSMutableArray * hotMasterArr;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, wScreen, hScreen) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[MasterCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.view.backgroundColor = [UIColor whiteColor];
  
    self.navigationItem.title = @"法师";
    
    UIColor * color = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
   
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]
//                                   initWithTitle:@"左按钮"
//                                   style:UIBarButtonItemStylePlain
//                                   target:self
//                                   action:@selector(left)];
//    [self.navigationItem setLeftBarButtonItem:leftButton];
//    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"🔍"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                    action:@selector(right:)];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    self.navigationController.navigationBar.tintColor =[UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];    
    self.allMasterArr = [[NSMutableArray alloc]init];
    self.recMasterArr = [[NSMutableArray alloc]init];
    self.hotMasterArr = [[NSMutableArray alloc]init];
    
//    UIApplication * app = [UIApplication sharedApplication];
//    [app setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    mysearch = [[UISearchBar alloc]initWithFrame:CGRectMake(0,64,wScreen, 40)];

    mysearch.delegate = self;

    mysearch.placeholder = @"搜索法师";
     [self.view addSubview:mysearch];
    mysearch.hidden = YES;
    
    
    
    [self loadData];
    
   
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"GradientCell"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    //代码控制header和footer的显示
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    collectionViewLayout.headerReferenceSize = CGSizeMake(375, 50);
    

    label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)right:(id)sender{
    if (mysearch.hidden==YES) {
        mysearch.hidden=NO;
        self.collectionView.frame = CGRectMake(0,40, wScreen, hScreen-40);
    }else{
        mysearch.hidden=YES;
        self.collectionView.frame = CGRectMake(0,0, wScreen, hScreen);
    }


}

//- (UICollectionViewFlowLayout *) flowLayout{
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.headerReferenceSize = CGSizeMake(300.0f, 50.0f);  //设置head大小
//    flowLayout.footerReferenceSize = CGSizeMake(300.0f, 50.0f);
//    return flowLayout;
//}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{

    NSLog(@"shouldBeginEditing");
    return YES;

}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"didBeginEditing");

}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    NSLog(@"shouldEndEding");
    return YES;
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"didEndEditing");
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"searchButtonClicked");

}





-(void)loadData{
    
  
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
   
    [manager GET:Master_recommend_API parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        self.recMasterArr = [masterModel mj_objectArrayWithKeyValuesArray:responseObject[@"master"]];
        
        [self.collectionView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
       
        
    }];
    
    [manager GET:Master_hot_API parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        self.hotMasterArr = [masterModel mj_objectArrayWithKeyValuesArray:responseObject[@"master"]];
        
        [self.collectionView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];
    
    [manager GET:Master_all_API parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        self.allMasterArr = [masterModel mj_objectArrayWithKeyValuesArray:responseObject[@"master"]];
        
        [self.collectionView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];

}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section==0) {
    return self.recMasterArr.count;
    
    }else if (section==1){
    return self.hotMasterArr.count;
     
    
    }else{
    return self.allMasterArr.count;
       
    }
   
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={wScreen,wScreen/8};
    return size;
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        reusableview = headerView;
       
    }
    
//
//    reusableview.backgroundColor=[UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    label.frame =  CGRectMake(0,10, wScreen, 30);
    label.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    [reusableview addSubview:label];
   
    if (indexPath.section==0){
        label.text = @"推荐法师";
    }else if (indexPath.section==1){
        label.text = @"热门法师";
    }else if(indexPath.section==2){
        label.text = @"全部法师";
    }
 
    
       
    return reusableview;
}



//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MasterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell sizeToFit];
    
//    cell.layer.borderColor=[UIColor grayColor].CGColor;
//    cell.layer.borderWidth=0.3;
    
    if (indexPath.section==0) {
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
            cell.guanzhulabel.text = model.likes;
        }

    }else  if (indexPath.section==1) {
        masterModel * model = self.hotMasterArr[indexPath.row];
        
        
        
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
            cell.guanzhulabel.text = model.likes;
        }

    }else{
        masterModel * model = self.allMasterArr[indexPath.row];
        
        
        
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
            cell.guanzhulabel.text = model.likes;
        }
        
        
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
    
    
    if (indexPath.section==0) {
        
        
        MasterSectionViewController * master = [[MasterSectionViewController alloc]init];
        
        masterModel * model = self.recMasterArr[indexPath.row];
        
        master.master = model;
        
        master.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = barButtonItem;
        
        [self.navigationController pushViewController:master animated:YES];
        
    }else if (indexPath.section==1) {
        
        
        MasterSectionViewController * master = [[MasterSectionViewController alloc]init];
        
        masterModel * model = self.hotMasterArr[indexPath.row];
        
        master.master = model;
        
        master.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = barButtonItem;
        
        [self.navigationController pushViewController:master animated:YES];
        
    }else{
        
        
        MasterSectionViewController * master = [[MasterSectionViewController alloc]init];
        
        masterModel * model = self.allMasterArr[indexPath.row];
        
        master.master = model;
        
        master.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = barButtonItem;
        
        [self.navigationController pushViewController:master animated:YES];
        
    }
    
    
    
  
    
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
