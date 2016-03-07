//
//  MasterSectionViewController.m
//  smartemple
//
//  Created by wang on 16/3/3.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "MasterSectionViewController.h"
#import "smartemple.pch"
#import "TempleModel.h"
#import "TempleTableViewCell.h"
#import "TempleSecondViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "Timelinemodel.h"
#import "TimelineTableViewCell.h"
@interface MasterSectionViewController (){

    UISegmentedControl *segmentedControl;
}

@property(nonatomic, strong)NSMutableArray * TimeArr;
@property(nonatomic, strong)NSMutableArray * QuestionArr;
@property(nonatomic, strong)NSMutableArray * WishArr;

@end

@implementation MasterSectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, wScreen, hScreen) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    self.TimeArr = [[NSMutableArray alloc]init];
    self.QuestionArr = [[NSMutableArray alloc]init];
    self.WishArr = [[NSMutableArray alloc]init];
    
    
    self.navigationItem.title = @"法师详情";
    
    UIColor * color = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
       
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];

    [self setHeaderView];
    
    
    [self loadTimeline];
    

}

/**
 * 设置tabview顶部视图
 */
- (void)setHeaderView{


    UIView *headView = [[UIView alloc]init];
    headView.frame = CGRectMake(0, 0, wScreen,wScreen/3+190);
//    headView.backgroundColor = [UIColor colorWithRed:210/255.0 green:212/255.0 blue:225/255.0 alpha:1.0];
    self.tableView.tableHeaderView = headView;
    
    UILabel * mastername = [[UILabel alloc]initWithFrame:CGRectMake(5, 10,100, 20)];
    mastername.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    mastername.textAlignment = NSTextAlignmentCenter;
    mastername.text = self.master.realname;
    mastername.font = [UIFont systemFontOfSize:20];
    [headView addSubview:mastername];
    UIView * fengexian = [[UIView alloc]initWithFrame:CGRectMake(5, 40, wScreen-10, 1)];
    fengexian.backgroundColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];

    [headView addSubview:fengexian];
    UIImageView *  masterimage = [[UIImageView alloc]initWithFrame:CGRectMake(wScreen/3,60, wScreen/3, wScreen/3)];
    
    [masterimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://smartemple.com/%@",self.master.avatar]] placeholderImage:[UIImage imageNamed:@"avatar@2x.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [masterimage setImage:masterimage.image];
        //头像圆形
        masterimage.layer.masksToBounds = YES;
        masterimage.layer.cornerRadius = masterimage.frame.size.width/2;
        
                //头像边框
        masterimage.layer.borderColor = [UIColor colorWithRed:200/255.0 green:180/255.0 blue:125/255.0 alpha:1.0].CGColor;
        masterimage.layer.borderWidth = 3.0;
    }];
    
    [headView addSubview:masterimage];
    UIButton * guanzhu = [[UIButton alloc]initWithFrame:CGRectMake(wScreen-45,50,10,10)];
    [guanzhu setImage:[UIImage imageNamed:@"xin.png"] forState:UIControlStateNormal];
//    [guanzhu addTarget:self action:@selector(followTag) forControlEvents:UIControlEventTouchUpInside];
     [headView addSubview:guanzhu];
    UILabel * likes = [[UILabel alloc]initWithFrame:CGRectMake(wScreen-32,50,30,10)];
    likes.text = self.master.likes;
    likes.textColor = [UIColor blackColor];
    likes.font = TextFont;
    [headView addSubview:likes];
    
    UILabel * views = [[UILabel alloc]initWithFrame:CGRectMake(wScreen-100,50,60,10)];
    views.text =[NSString stringWithFormat:@"人气 %@",self.master.views];
    views.textColor = [UIColor blackColor];
    views.font = TextFont;
    [headView addSubview:views];
   
    UILabel * templename = [[UILabel alloc]initWithFrame:CGRectMake(0,wScreen/3+70, wScreen, 20)];
    templename.textColor = [UIColor blackColor];
    templename.textAlignment = NSTextAlignmentCenter;
    templename.text = self.master.name;
    
    [headView addSubview:templename];
    
    UIButton * temple = [[UIButton alloc]initWithFrame:CGRectMake(10,wScreen/3+95, wScreen-20,15)];
    [temple setTitle:@"访问寺院主页" forState:UIControlStateNormal];
     [temple setTitleColor:[UIColor colorWithRed:73/255.0 green:73/255.0 blue:73/255.0 alpha:1.0] forState: UIControlStateNormal];
    temple.titleLabel.font = TextFont;
    [headView addSubview:temple];
    
    
    UIButton * speech = [[UIButton alloc]initWithFrame:CGRectMake(10,wScreen/3+120, wScreen-20, 30)];
    [speech setTitle:@"查看今日语音开示" forState:UIControlStateNormal];
    speech.backgroundColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    [headView addSubview:speech];
    
    NSArray *segmentedData = [[NSArray alloc]initWithObjects:@"时光轴",@"问答",@"祈福",nil];
    segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedData];
    segmentedControl.frame = CGRectMake(10.0,wScreen/3+160,wScreen-20, 30.0);
    segmentedControl.tintColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    segmentedControl.selectedSegmentIndex =0;//默认选中的按钮索引
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,[UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0], NSForegroundColorAttributeName,nil];
    
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    [segmentedControl addTarget:self action:@selector(Segment:)forControlEvents:UIControlEventValueChanged];
    
    [headView addSubview:segmentedControl];
    
}



-(void)Segment:(UISegmentedControl *)Seg
{
    
//    NSInteger Index = Seg.selectedSegmentIndex;
    
    if (Seg.selectedSegmentIndex == 2) {
        
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionFade;
        animation.duration = 1;
        
       

        
           }
    else if (Seg.selectedSegmentIndex == 1){
        
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionFade;
        animation.duration = 1;
        
        

  
        
    } else if (Seg.selectedSegmentIndex == 0){
        
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionFade;
        animation.duration = 1;
  
       
    
    }

    
    
  }


-(void)loadTimeline{

    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSString * url = [NSString stringWithFormat:@"%@",Timeline_API];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        self.TimeArr = [Timelinemodel mj_objectArrayWithKeyValuesArray:responseObject[@"master"]];
        
        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];

    
}








- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.TimeArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (segmentedControl.selectedSegmentIndex==0) {
        NSString *ID = [NSString stringWithFormat:@"TimeCell"];
        TimelineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[TimelineTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        
              
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        [cell setup:self.TimeArr[indexPath.row]];
        
        return cell;
    }
    
   
    
    return nil;
    
}



- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //return 290;
    Timelinemodel *model = [self.TimeArr objectAtIndex:indexPath.row];
    return 80;
  
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
