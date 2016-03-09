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
@interface TempleSecondViewController (){
    
    UISegmentedControl *segmentedControl;
    masterModel * ma;

   
}
@property(nonatomic,strong)UIView * activityView;

@end

@implementation TempleSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, wScreen, hScreen) style:UITableViewStylePlain];
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
 
}

-(void)loadMaster{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"masterid":self.temple.masterid,@"access_token":@"40ece0e10c42d2dff48e4c1500c81ba1faa713c1"};
    [manager GET:Master_ID_API parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        ma = [masterModel mj_objectWithKeyValues:responseObject[0]];
        
        
        [self.tableView reloadData];
        
        NSLog(@"成功");
        
        
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
    
    UIButton * activityButton = [[UIButton alloc]initWithFrame:CGRectMake(wScreen/2+10, 10, wScreen/2-20, 30)];
    activityButton.backgroundColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    [activityButton setTitle:@"我想活动" forState:UIControlStateNormal];
    
    [self.activityView addSubview:activityButton];
}

/**
 * 设置tabview顶部视图
 */
- (void)setHeaderView{
    
    [self loadMaster];
    
    UIView *headView = [[UIView alloc]init];
   
    //    headView.backgroundColor = [UIColor colorWithRed:210/255.0 green:212/255.0 blue:225/255.0 alpha:1.0];
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
    
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(wScreen/5+20,15,100, 20)];
    title.textAlignment = NSTextAlignmentLeft;
    title.font = NameFont;
    title.text = ma.realname;
    [headView addSubview:title];
    
    UILabel * renqilabel = [[UILabel alloc]initWithFrame:CGRectMake(wScreen/5+70,35,50,30)];
    renqilabel.font = TextFont;
    renqilabel.text = ma.views;
    renqilabel.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    [headView addSubview:renqilabel];
    UILabel * guanzhulabel = [[UILabel alloc]initWithFrame:CGRectMake(wScreen/5+20,35,50,30)];
    guanzhulabel.textAlignment = NSTextAlignmentLeft;
    guanzhulabel.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    guanzhulabel.font = TextFont;
    guanzhulabel.text = ma.likes;
    [headView addSubview:guanzhulabel];
   
    UILabel * templename = [[UILabel alloc]initWithFrame:CGRectMake(10, wScreen/2+30+wScreen/5, wScreen-20, 20)];
    templename.textColor = [UIColor blackColor];
    templename.font = NameFont;
    templename.text = [NSString stringWithFormat:@"%@(%@ %@)",self.temple.name,self.temple.province,self.temple.city];

    [headView addSubview:templename];
    
    
    UIImageView * guanzhuimage = [[UIImageView alloc]initWithFrame:CGRectMake(wScreen-45, wScreen/2+35+wScreen/5, 10, 10)];
    guanzhuimage.image  =[UIImage imageNamed:@"xin.png"];
    [headView addSubview:guanzhuimage];
    UILabel * followabel = [[UILabel alloc]initWithFrame:CGRectMake(wScreen-30, wScreen/2+30+wScreen/5, 30, 20)];
    followabel.textAlignment = NSTextAlignmentLeft;
    followabel.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    followabel.font = [UIFont systemFontOfSize:10];
    followabel.text = self.temple.views;
    
    [headView addSubview:followabel];
    
    CGSize textSize = [self sizeWithText:self.temple.website font:TextFont maxSize:CGSizeMake(wScreen - 20, MAXFLOAT)];
    
     headView.frame = CGRectMake(0, 0, wScreen,textSize.height + wScreen/2+65+wScreen/5);


    
    
    
    UILabel * websitelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, wScreen/2+60+wScreen/5, wScreen-20,textSize.height)];
    websitelabel.textAlignment = NSTextAlignmentLeft;
    websitelabel.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    websitelabel.font = TextFont;
    websitelabel.numberOfLines = 0;
    websitelabel.text = self.temple.website;
    [headView addSubview:websitelabel];
    
}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}




//-(void)Segment:(UISegmentedControl *)Seg
//{
//    
//    //    NSInteger Index = Seg.selectedSegmentIndex;
//    
//    if (Seg.selectedSegmentIndex == 0) {
//        
//        CATransition *animation = [CATransition animation];
//        animation.type = kCATransitionFade;
//        animation.duration = 1;
//        
//        [self loadTimeline];
//       
//        
//        
//    }
//    else if (Seg.selectedSegmentIndex == 1){
//        
//        CATransition *animation = [CATransition animation];
//        animation.type = kCATransitionFade;
//        animation.duration = 1;
//        
//        
//        [self loadQuestion];
//       
//        
//        
//    } else if (Seg.selectedSegmentIndex == 2){
//        
//        CATransition *animation = [CATransition animation];
//        animation.type = kCATransitionFade;
//        animation.duration = 1;
//        
//        [self loadWish];
//      
//        
//    }
//    
//    
//    
//}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
//    if (segmentedControl.selectedSegmentIndex==0) {
        NSString *ID = [NSString stringWithFormat:@"TimeCell"];
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
    return cell;
//
//
//        cell.selectionStyle =UITableViewCellSelectionStyleNone;
//        
//        [cell setup:self.TimeArr[indexPath.row]];
//        
//        return cell;
//    }else if (segmentedControl.selectedSegmentIndex==1){
//        
//        NSString *ID = [NSString stringWithFormat:@"QuestionCell"];
//        QuestionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
//        
//        if (cell == nil) {
//            cell = [[QuestionTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//        }
//        
//        
//        cell.selectionStyle =UITableViewCellSelectionStyleNone;
//        
//        [cell setup:self.QuestionArr[indexPath.row]];
//        
//        return cell;
//        
//        
//    }else if (segmentedControl.selectedSegmentIndex==2){
//        
//        NSString *ID = [NSString stringWithFormat:@"WishCell"];
//        WishTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
//        
//        if (cell == nil) {
//            cell = [[WishTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//        }
//        
//        
//        cell.selectionStyle =UITableViewCellSelectionStyleNone;
//        
//        [cell setup:self.WishArr[indexPath.row]];
//        
//        return cell;
//        
//        
//    }
//    
    
//    return nil;

    
}



- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if (segmentedControl.selectedSegmentIndex==0) {
//        
//        Timelinemodel *model = [self.TimeArr objectAtIndex:indexPath.row];
//        return [model getCellHeight];
//        
//    }else if (segmentedControl.selectedSegmentIndex==1){
//        
//        Questionmodel *model = [self.QuestionArr objectAtIndex:indexPath.row];
//        return [model getCellHeight];
//        
//        
//    }else{
//        
//        Wishmodel *model = [self.WishArr objectAtIndex:indexPath.row];
//        return [model getCellHeight];
//    }
//
    return 200;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
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
