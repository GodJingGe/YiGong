//
//  HJDonationDetailViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/7.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJDonationDetailViewController.h"
#import "HJPersonalModel.h"
#define IMAGE_SIZE 260
#define USERINFO_URL @"uinfo"
@interface HJDonationDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 标签栏*/
@property(nonatomic, strong) UITabBar *tabbar;
/** 个人信息*/
@property(nonatomic, strong) HJPersonalModel * userInfo;
@end

@implementation HJDonationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self createUI];
}
- (void)createUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGRect rect = CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    
    [self.view addSubview:self.tableV];
    
    _topicImageView = [[UIImageView alloc]init];

    _topicImageView.frame = CGRectMake(0, -IMAGE_SIZE, SCREEN_WIDTH, IMAGE_SIZE);
    [self.tableV addSubview:_topicImageView];
    if (self.model.images.count) {
        // 图片路径
        NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:COMMON_IMAGE_URL,self.model.images[0].imageUrl]];
        [self.topicImageView sd_setImageWithURL:url];
    }
    self.tableV.contentInset = UIEdgeInsetsMake(_topicImageView.frame.size.height,0,0,0);
    
    _tabbar = [[UITabBar alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64-49, SCREEN_WIDTH, 49)];
    [_tabbar setShadowImage:[UIImage new]];
    [self.view addSubview:_tabbar];
    
    UIButton * contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    contactBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 49);
    [contactBtn setBackgroundColor:THEME_COLOR];
    [contactBtn setTitle:@"联系他" forState:UIControlStateNormal];
    [contactBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [contactBtn addTarget:self action:@selector(contactAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabbar addSubview:contactBtn];

}

- (void)loadData{
    HJRequestTool * tool = [[HJRequestTool alloc]init];
    NSString * url = [NSString stringWithFormat:COMMON_URL,USERINFO_URL];
    NSDictionary * dic = [NSDictionary dictionaryWithObject:self.model.donorId forKey:@"userid"];
    [tool postJSONWithUrl:url parameters:dic success:^(id responseObject) {
        NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        self.userInfo = [HJPersonalModel mj_objectWithKeyValues:jsonData[@"pd"]];
        
    } fail:^(NSError *error) {
        [self loadData];
    }];
}

#pragma mark --------------UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJDonationTableViewCell";
    _cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!_cell) {
        _cell = [[HJDonationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        _cell.indexPath = indexPath;
        _cell.isAvatar = YES;
        _cell.model = _model;
    }
    return _cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * detailCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return detailCell.frame.size.height;
    
}
#pragma mark --------------ClickAction
- (void)contactAction:(UIButton *)button{
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",self.userInfo.phoneNum]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
    HJLog(@"联系他");
}

//- (void)praiseAction:(UIButton *)button{
//    HJLog(@"点赞");
//    if (button.selected) return;
//    button.selected = YES;
//}

#pragma mark --------------UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView*)scrollView{
    /**
     *  关键处理：通过滚动视图获取到滚动偏移量从而去改变图片的变化
     */
    //获取滚动视图y值的偏移量
    CGFloat yOffset  = scrollView.contentOffset.y;
    HJLog(@"yOffset===%f",yOffset);
    
    if(yOffset < -226) {
        
        CGRect f =self.topicImageView.frame;
        f.origin.y= yOffset ;
        f.size.height=  -yOffset;
        self.topicImageView.frame= f;
        
    }
    
    if (yOffset >= -64) {
        [self setNavigationBarStyleNormal];
        
    }else{
        [self setNavigationBarStyleClear];
    }
    
}

// 设置导航栏透明
- (void)setNavigationBarStyleClear{
    
//    UIColor * color = HJRGBA(34, 34, 34, 0.2);
//    UIImage * clearImage = [UIImage imageWithColor:color];
    UIImage * image = [UIImage imageNamed:@"Mask"];
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    self.navigationController.navigationBar.translucent = YES;
    
}

// 设置导航栏正常
- (void)setNavigationBarStyleNormal{
    
    UIColor * color = HJRGBA(248, 97, 111, 1.0);
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    
}

#pragma mark --------------SystemDelegate
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBarStyleClear];
}
- (void)viewDidAppear:(BOOL)animated{
    
}
@end
