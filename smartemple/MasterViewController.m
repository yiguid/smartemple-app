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
    
    UIColor * color = [UIColor colorWithRed:190/255.0 green:160/255.0 blue:110/255.0 alpha:1.0];
    
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
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:190/255.0 green:160/255.0 blue:110/255.0 alpha:1.0];
    
    self.allMasterArr = [[NSMutableArray alloc]init];
    self.recMasterArr = [[NSMutableArray alloc]init];
    self.hotMasterArr = [[NSMutableArray alloc]init];
    
//    UIApplication * app = [UIApplication sharedApplication];
//    [app setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    mysearch = [[UISearchBar alloc]initWithFrame:CGRectMake(0,64,wScreen, 40)];

    mysearch.delegate = self;
//    UIView * segment = [mysearch.subviews objectAtIndex:0];
//    [segment removeFromSuperview];
//    mysearch.backgroundColor = [UIColor colorWithRed:190/255.0 green:160/255.0 blue:110/255.0 alpha:1.0];
    
//    UITextField * searchField = [[mysearch subviews] lastObject];
//    [searchField setReturnKeyType:UIReturnKeyDone];
//    
//    mysearch.barStyle = UIBarStyleBlackTranslucent;
//    mysearch.keyboardType = UIKeyboardTypeDefault;
    mysearch.placeholder = @"搜索法师";
    mysearch.barTintColor = [UIColor colorWithRed:190/255.0 green:160/255.0 blue:110/255.0 alpha:1.0];

    
    [self.view addSubview:mysearch];
    mysearch.hidden = YES;
    
    
    
    [self loadData];
    
    

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
    return 3;
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
        cell.guanzhulabel.text = model.views;
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
        cell.guanzhulabel.text = model.views;
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
        cell.guanzhulabel.text = model.views;
    }
   
    return cell;
}

//定义每个UICollectionView 的大小（返回CGSize：宽度和高度）
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((wScreen-80)/3,100);
    
}
//定义每个UICollectionView 的间距（返回UIEdgeInsets：上、左、下、右）
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(20,20,20,20);
    
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

///*设置标题头的宽度*/
//-(CGFloat)tableview:(UICollectionView *)collectionView heightForHeaderInSection:(NSInteger)section
//{
//    
//    if (section==0) {
//        
//        return 30;
//    }else if(section == 1){
//        
//        return 30;
//    }else{
//        
//        
//        return 30;
//    }
//    
//    
//}
//
//-(UIView *)tableview:(UICollectionView *)collectionView viewForHeaderInSection:(NSInteger)section
//{
//    if (section == 0)
//    {
//        
//        UIView * view = [[UIView alloc]init];
//        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
//        label.text = @"推荐寺院";
//        label.textColor = [UIColor colorWithRed:190/255.0 green:160/255.0 blue:110/255.0 alpha:1.0];
//        [view addSubview:label];
//        
//        
//        return view;
//        
//        
//    }
//    else if(section == 1)
//    {
//        
//        UIView * view = [[UIView alloc]init];
//        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
//        label.text = @"热门寺院";
//        label.textColor =[UIColor colorWithRed:190/255.0 green:160/255.0 blue:110/255.0 alpha:1.0];
//        [view addSubview:label];
//        
//        
//        return view;
//        
//    }else{
//        
//        UIView * view = [[UIView alloc]init];
//        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
//        label.text = @"全部寺院";
//        label.textColor = [UIColor colorWithRed:190/255.0 green:160/255.0 blue:110/255.0 alpha:1.0];
//        [view addSubview:label];
//        
//        
//        
//        return view;
//        
//    }
//    
//    return nil;
//}
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView == self.collectionView)
//    {
//        //为最高的那个headerView的高度
//        CGFloat sectionHeaderHeight = 30;
//        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//        }
//        
//        
//    }
//    
//    
//}


//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//
//{
//    
////    
//    
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
