//
//  TempleSecondViewController.m
//  smartemple
//
//  Created by wang on 16/3/3.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "TempleSecondViewController.h"
#import "smartemple.pch"
#import "TempleModel.h"
#import "TempleTableViewCell.h"
#import "TempleSecondViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "Timelinemodel.h"
#import "TimelineTableViewCell.h"
#import "Questionmodel.h"
#import "QuestionTableViewCell.h"
#import "Wishmodel.h"
#import "WishTableViewCell.h"
#import "masterModel.h"
#import "NewsTableViewCell.h"
#import "NewsModel.h"
#import "ActiviTableViewCell.h"
#import "ActiviModel.h"
#import "DonationModel.h"
#import "DonationTableViewCell.h"
#import "ActivitySecondViewController.h"
#import "WishViewController.h"
#import "WishAllViewController.h"
#import "ActivityAllViewController.h"
#import "NewsAllViewController.h"
#import "NewsViewController.h"
#import "DonationAllViewController.h"
@interface TempleSecondViewController (){
    
    masterModel * mastermodel;

   
}
@property(nonatomic,strong)UIView * activityView;

@property(nonatomic, strong)NSMutableArray * NewsArr;;
@property(nonatomic, strong)NSMutableArray * ActivityArr;
@property(nonatomic, strong)NSMutableArray * WishArr;
@property(nonatomic, strong)NSMutableArray * GoodArr;
@property(nonatomic, strong)NSMutableArray * DonationArr;
@end

@implementation TempleSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.NewsArr = [[NSMutableArray alloc]init];
    self.ActivityArr = [[NSMutableArray alloc]init];
    self.WishArr = [[NSMutableArray alloc]init];
    self.DonationArr = [[NSMutableArray alloc]init];
    self.GoodArr = [[NSMutableArray alloc]init];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, wScreen, hScreen-50) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    
    self.navigationItem.title = self.temple.name;
    
    UIColor * color = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    
    [self loadMaster];
    
    [self setFootView];
    [self setHeaderView];
 
    [self loadNews];
    [self loadActivity];
    [self loadWish];
    [self loadDonation];
    [self loadGood];
}

-(void)loadMaster{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"token"];
    NSDictionary *parameters = @{@"masterid":self.temple.masterid,@"access_token":token};
    [manager GET:Master_ID_API parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        mastermodel = [masterModel mj_objectWithKeyValues:responseObject[0]];
        
        
        [self.tableView reloadData];
        
        NSLog(@"请求成功");
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];
    
    
    
}

//设置底部视图
-(void)setFootView{
    
    self.activityView = [[UIView alloc]initWithFrame:CGRectMake(0,hScreen-50, wScreen,50)];
    self.activityView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.activityView];
    
    UIView * fengexian = [[UIView alloc]initWithFrame:CGRectMake(0,0, wScreen,0.5)];
    fengexian.backgroundColor = [UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0];
    [self.activityView addSubview:fengexian];
    
    UIButton * WishButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, wScreen/2-20, 30)];
    WishButton.backgroundColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    [WishButton setTitle:@"我想祈福" forState:UIControlStateNormal];
    [self.activityView addSubview:WishButton];
     [WishButton addTarget:self action:@selector(WishBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * activityButton = [[UIButton alloc]initWithFrame:CGRectMake(wScreen/2+10, 10, wScreen/2-20, 30)];
    activityButton.backgroundColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    [activityButton setTitle:@"查看新闻" forState:UIControlStateNormal];
    
    [self.activityView addSubview:activityButton];
    
    [activityButton addTarget:self action:@selector(activityBtn) forControlEvents:UIControlEventTouchUpInside];
}

/**
 * 设置tabview顶部视图
 */
- (void)setHeaderView{
    
    UIView * headView = [[UIView alloc]init];
    
    
    CGSize textSize = [self sizeWithText:self.temple.website font:TextFont maxSize:CGSizeMake(wScreen - 20, MAXFLOAT)];
    
    
//    CGSize renqitextSize = [self sizeWithText:self.temple.views font:TextFont maxSize:CGSizeMake(MAXFLOAT,10)];
    CGSize guanzhutextSize = [self sizeWithText:self.temple.views font:TextFont maxSize:CGSizeMake(MAXFLOAT,10)];
    
    
    
    headView.frame = CGRectMake(0, 0,wScreen,textSize.height + wScreen/2+65+wScreen/5);
    
    self.tableView.tableHeaderView = headView;
    
    UIImageView *  templeimage = [[UIImageView alloc]initWithFrame:CGRectMake(10,20+wScreen/5, wScreen-20,wScreen/2)];
    
    [templeimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://smartemple.com/%@",self.temple.homeimg]] placeholderImage:[UIImage imageNamed:@"myBackImg@2x.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [templeimage setImage:templeimage.image];

    }];
    
    [headView addSubview:templeimage];
    
    UIImageView * masterimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10,wScreen/5, wScreen/5)];
    
    [masterimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://smartemple.com/%@",self.temple.avatar]] placeholderImage:[UIImage imageNamed:@"avatar@2x.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [masterimage setImage:masterimage.image];
        //头像圆形
        masterimage.layer.masksToBounds = YES;
        masterimage.layer.cornerRadius = masterimage.frame.size.width/2;
        
    }];
    
    [headView addSubview:masterimage];
    
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(wScreen/5+20,15,wScreen-wScreen/5-40, 20)];
    title.textAlignment = NSTextAlignmentLeft;
    title.font = NameFont;
    title.text = [NSString stringWithFormat:@"%@(%@主持)",self.temple.master,self.temple.name];
    [headView addSubview:title];
    
    UILabel * renqilabel = [[UILabel alloc]initWithFrame:CGRectMake(wScreen/5+60+guanzhutextSize.width,45,60,30)];
    renqilabel.font = TextFont;
    renqilabel.text = [NSString stringWithFormat:@"人气 %@",@"46"];
    renqilabel.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    [headView addSubview:renqilabel];
    
    UILabel * guanzhulabel = [[UILabel alloc]initWithFrame:CGRectMake(wScreen/5+20,45,guanzhutextSize.width+40,30)];
    guanzhulabel.textAlignment = NSTextAlignmentLeft;
    guanzhulabel.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    guanzhulabel.font = TextFont;
    guanzhulabel.text =  [NSString stringWithFormat:@"关注 %@",self.temple.views];
    [headView addSubview:guanzhulabel];
   
    UILabel * templename = [[UILabel alloc]initWithFrame:CGRectMake(10, wScreen/2+30+wScreen/5, wScreen-20, 20)];
    templename.textColor = [UIColor blackColor];
    templename.font = NameFont;
    templename.text = [NSString stringWithFormat:@"%@(%@ %@)",self.temple.name,self.temple.province,self.temple.city];

    [headView addSubview:templename];
    
    
     CGSize guanzhuSize = [self sizeWithText:self.temple.views font:TextFont maxSize:CGSizeMake(MAXFLOAT,10)];
    
    
    UIImageView * guanzhuimage = [[UIImageView alloc]initWithFrame:CGRectMake(wScreen-25-guanzhuSize.width,wScreen/2+35+wScreen/5, 10, 10)];
    guanzhuimage.image  =[UIImage imageNamed:@"xin.png"];
    [headView addSubview:guanzhuimage];
    UILabel * followabel = [[UILabel alloc]initWithFrame:CGRectMake(wScreen-guanzhuSize.width-10, wScreen/2+30+wScreen/5,guanzhuSize.width, 20)];
    followabel.textAlignment = NSTextAlignmentLeft;
    followabel.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    followabel.font = [UIFont systemFontOfSize:10];
    followabel.text = self.temple.views;
    
    [headView addSubview:followabel];
  
    
    UILabel * websitelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, wScreen/2+60+wScreen/5, wScreen-20,textSize.height)];
    websitelabel.textAlignment = NSTextAlignmentLeft;
    websitelabel.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    websitelabel.font = TextFont;
    websitelabel.numberOfLines = 0;
    websitelabel.text = self.temple.website;
    [headView addSubview:websitelabel];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0,textSize.height + wScreen/2+65+wScreen/5,wScreen,0.5)];
    view.backgroundColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
    [headView addSubview:view];
    
    
    
}

-(void)activityBtn{
    
    NewsAllViewController * news = [[NewsAllViewController alloc]init];
    news.temple = self.temple;
    [self.navigationController pushViewController:news animated:YES];

}
-(void)WishBtn{

    WishAllViewController * wish = [[WishAllViewController alloc]init];
    wish.temple = self.temple;
    [self.navigationController pushViewController:wish animated:YES];
}


-(void)loadGood{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"token"];
    NSDictionary *parameters = @{@"templeid":self.temple.templeid,@"access_token":token};
    NSString *url = [NSString stringWithFormat:@"%@/news",Temple_API];
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
//        self.GoodArr = [NewsModel mj_objectArrayWithKeyValuesArray:responseObject[@"temple"]];
//        
        
        [self.tableView reloadData];
        
        NSLog(@"请求成功");
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];


}



-(void)loadNews{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"token"];
    NSDictionary *parameters = @{@"templeid":self.temple.templeid,@"page":@"1",@"limit":@"3",@"access_token":token};
    NSString *url = [NSString stringWithFormat:@"%@/news",Temple_API];
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        self.NewsArr = [NewsModel mj_objectArrayWithKeyValuesArray:responseObject[@"temple"]];
        
        
        [self.tableView reloadData];
        
        NSLog(@"请求成功");
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];


}
-(void)loadActivity{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"token"];
    NSDictionary *parameters = @{@"templeid":self.temple.templeid,@"page":@"1",@"limit":@"3",@"access_token":token};
    NSString *url = [NSString stringWithFormat:@"%@/activity",Temple_API];
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        self.ActivityArr = [ActiviModel mj_objectArrayWithKeyValuesArray:responseObject];
        
        
        [self.tableView reloadData];
        
        NSLog(@"请求成功");
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];


}

-(void)loadWish{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"token"];
    NSDictionary *parameters = @{@"templeid":self.temple.templeid,@"page":@"1",@"limit":@"3",@"access_token":token};
    NSString *url = [NSString stringWithFormat:@"%@/wish",Temple_API];
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        self.WishArr = [Wishmodel mj_objectArrayWithKeyValuesArray:responseObject[@"temple"]];
        
        
        [self.tableView reloadData];
        
        NSLog(@"请求成功");
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];

}

-(void)loadDonation{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"token"];
    NSDictionary *parameters = @{@"templeid":self.temple.templeid,@"page":@"1",@"limit":@"3",@"access_token":token};
    [manager GET:Temple_zhongchou_API parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        self.DonationArr = [DonationModel mj_objectArrayWithKeyValuesArray:responseObject[@"temple"]];
        
        [self.tableView reloadData];
        
        NSLog(@"请求成功");
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        return self.NewsArr.count;
    }else if (section==1){
        return 1;
    }
//    else if (section==2){
//        return self.ActivityArr.count;
//    }
//    else if (section==3){
//        return 1;
//    }
//    else if (section==4){
//        return self.DonationArr.count;
//    }else if (section==5){
//        return 1;
//    }
    else if (section==2){
        return self.WishArr.count;
    }else{
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section==0) {
        NSString *ID = [NSString stringWithFormat:@"NewsCell"];
        NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        
        
        [cell setup:self.NewsArr[indexPath.row]];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.section==1){
        
        static NSString * CellIndentifier = @"manyNews";
        
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
            if (cell == nil) {
        
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
                
            }
        if (self.NewsArr.count>=3) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = CGRectMake(5,5,80,20);
            //            NSString * str = [NSString stringWithFormat:@"%ld",self.NewsArr.count];
            
            [button setTitle:[NSString stringWithFormat:@"阅读更多>>"] forState:UIControlStateNormal];
            
            
            [button setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
            button.titleLabel.font = TextFont;
          
            [button addTarget:self action:@selector(NewsBtn) forControlEvents:UIControlEventTouchUpInside];
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0,30,wScreen,1)];
            view.backgroundColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
            [cell.contentView addSubview:view];
            
            [cell.contentView addSubview:button];
            
        }

        
        return cell;
        
    }
//    else if (indexPath.section==2){
//        
//        
//        NSString *ID = [NSString stringWithFormat:@"ActivityCell"];
//        ActiviTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
//        
//        if (cell == nil) {
//            cell = [[ActiviTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//        }
//        
//        
//        [cell setup:self.ActivityArr[indexPath.row]];
//        cell.selectionStyle =UITableViewCellSelectionStyleNone;
//        return cell;
//        
//        
//        
//        
//    }else if (indexPath.section==3){
//        
//        static NSString * CellIndentifier = @"manyActivity";
//        
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        
//        if (cell == nil) {
//            
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
//            
//        }
//        
//        if (self.ActivityArr.count>=3) {
//            
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//            button.frame = CGRectMake(5,5,70, 30);
//            //            NSString * str = [NSString stringWithFormat:@"%ld",self.NewsArr.count];
//            
//            [button setTitle:[NSString stringWithFormat:@"阅读更多>>"] forState:UIControlStateNormal];
//            
//            
//            [button setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
//            button.titleLabel.font = TextFont;
//           
//            [button addTarget:self action:@selector(ActivityBtn) forControlEvents:UIControlEventTouchUpInside];
//            
//            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0,30,wScreen,1)];
//            view.backgroundColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
//            [cell.contentView addSubview:view];
//            
//            [cell.contentView addSubview:button];
//            
//            
//        }
//        
//        
//        return cell;
//    
//    
//    }else if (indexPath.section==4){
//        
//        NSString *ID = [NSString stringWithFormat:@"DonationCell"];
//        DonationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
//        
//        if (cell == nil) {
//            cell = [[DonationTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//        }
//        
//        
//        cell.selectionStyle =UITableViewCellSelectionStyleNone;
//        
//        [cell setup:self.DonationArr[indexPath.row]];
//        
//        return cell;
//        
//        
//    }else if (indexPath.section==5){
//        
//        static NSString * CellIndentifier = @"manyDonation";
//        
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        
//        if (cell == nil) {
//            
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
//            
//        }
//        
//        if (self.DonationArr.count>=3) {
//            
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//            button.frame = CGRectMake(5,5,70, 30);
//            //            NSString * str = [NSString stringWithFormat:@"%ld",self.NewsArr.count];
//            
//            [button setTitle:[NSString stringWithFormat:@"阅读更多>>"] forState:UIControlStateNormal];
//            
//            
//            [button setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
//            button.titleLabel.font = TextFont;
//            
//            [button addTarget:self action:@selector(DonationBtn) forControlEvents:UIControlEventTouchUpInside];
//            
//            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0,30,wScreen,1)];
//            view.backgroundColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
//            [cell.contentView addSubview:view];
//            
//            [cell.contentView addSubview:button];
//            
//            
//        }
//    
//        return cell;
//    }
else if (indexPath.section==2){
        
        NSString *ID = [NSString stringWithFormat:@"WishCell"];
        WishTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[WishTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        
        
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        [cell setup:self.WishArr[indexPath.row]];
        
        return cell;

    
    }else{
        
        static NSString * CellIndentifier = @"manyWish";
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
            
        }
        
        if (self.WishArr.count>=3) {
            
            
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = CGRectMake(5,5,80, 30);
            //            NSString * str = [NSString stringWithFormat:@"%ld",self.NewsArr.count];
            
            [button setTitle:[NSString stringWithFormat:@"阅读更多>>"] forState:UIControlStateNormal];
            
            
            [button setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
            button.titleLabel.font = TextFont;

            [button addTarget:self action:@selector(WishButtn) forControlEvents:UIControlEventTouchUpInside];
            
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0,30,wScreen,1)];
            view.backgroundColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
            [cell.contentView addSubview:view];
            
            [cell.contentView addSubview:button];
            
        }
        
        return cell;
    }
    
    
    return nil;

    
}



- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        NewsModel *model = [self.NewsArr objectAtIndex:indexPath.row];
        return [model getCellHeight];
        
    }else if (indexPath.section==1){
        
        
        if (self.NewsArr.count>=3) {
            return 30;
        }else{
            return 0;
        }
    
    }
//    else if (indexPath.section==2){
//        
//        ActiviModel *model = [self.ActivityArr objectAtIndex:indexPath.row];
//        return [model getCellHeight];
//     
//    }else if (indexPath.section==3){
//        
//        if (self.ActivityArr.count>=3) {
//            return 30;
//        }else{
//            return 0;
//        }
//      
//    }else if (indexPath.section==4){
//        
////        DonationModel *model = [self.DonationArr objectAtIndex:indexPath.row];
//        return wScreen/3;
//        
//    }else if (indexPath.section==5){
//        
//        if (self.DonationArr.count>=3) {
//            return 30;
//        }else{
//            return 0;
//        }
//        
//    }
else if (indexPath.section==2){
        Wishmodel *model = [self.WishArr objectAtIndex:indexPath.row];
        return [model getCellHeight];
    }else{
        
        if (self.WishArr.count>=3) {
            return 30;
        }else{
            return 0;
        }
        
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.section==2) {
//        
//        ActivitySecondViewController * activity = [[ActivitySecondViewController alloc]init];
//        ActiviModel *model = [self.ActivityArr objectAtIndex:indexPath.row];
//        activity.activityID = model.activityID;
//        activity.templeID = self.temple.templeid;
//        activity.type = model.type;
//        activity.activityString = @"temple";
//        [self.navigationController pushViewController:activity animated:YES];
//        
//        }
    if (indexPath.section==0) {
        NewsViewController * news = [[NewsViewController alloc]init];
        NewsModel * model = [self.NewsArr objectAtIndex:indexPath.row];
        news.newsID = model.newsID;
        news.templeID = self.temple.templeid;
        [self.navigationController pushViewController:news animated:YES];
    }
    
    
}
-(void)NewsBtn{
    NewsAllViewController * news = [[NewsAllViewController alloc]init];
    news.temple = self.temple;
    [self.navigationController pushViewController:news animated:YES];

}
//-(void)ActivityBtn{
//    ActivityAllViewController * activity = [[ActivityAllViewController alloc]init];
//    activity.temple = self.temple;
//    [self.navigationController pushViewController:activity animated:YES];
//
//}
//
//-(void)DonationBtn{
//    DonationAllViewController * donation = [[DonationAllViewController alloc]init];
//    donation.temple = self.temple;
//    [self.navigationController pushViewController:donation animated:YES];
//
//}

-(void)WishButtn{
    WishAllViewController * wish = [[WishAllViewController alloc]init];
    wish.temple = self.temple;
    [self.navigationController pushViewController:wish animated:YES];


}









-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
