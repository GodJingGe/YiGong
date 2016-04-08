//
//  HJServiceDetailViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/7.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJServiceDetailViewController.h"
#import "HJServiceDetailTableViewCell.h"
#import "HJGcmModel.h"
#import "HJDetailHeaderView.h"
@interface HJServiceDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 标签栏*/
@property(nonatomic, strong) UITabBar *tabbar;
/** UITableView*/
@property(nonatomic, strong) UITableView *tableV;
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
/** 评论 */
@property(nonatomic, strong) UIButton *commentBtn;
/** 顶部视图*/
@property(nonatomic, strong) UIImageView *topicImageView;
/** 模型*/
@property(nonatomic, strong) HJGcmModel *model;
/** 分组头视图*/
@property(nonatomic, strong) HJDetailHeaderView *superView;

@end

@implementation HJServiceDetailViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self createUI];
}
- (void)createUI{
    
    CGRect rect = CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT - 49);
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
    
    _topicImageView = [[UIImageView alloc]init];
    UIImage * image = [UIImage imageNamed:@"old01"];
    _topicImageView.frame = CGRectMake(0, -image.size.height, SCREEN_WIDTH, SCREEN_WIDTH * image.size.height/image.size.width);
    _topicImageView.image = image;
    [self.tableV addSubview:_topicImageView];
    self.tableV.contentInset=UIEdgeInsetsMake(_topicImageView.frame.size.height,0,0,0);
    
    [self createTabbar];
    
}
- (void)loadData{
    
}

#pragma mark --------------UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJServiceDetailTableViewCell";
    HJServiceDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[HJServiceDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        _model = [[HJGcmModel alloc]init];
        cell.indexPath = indexPath;
        cell.model = _model;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0)  return 0.0001f;
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * detailCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return detailCell.frame.size.height;
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HJDetailHeaderView * superView = [[HJDetailHeaderView alloc]init];
    switch (section) {
        case 1:
           
            superView.titleLabel.text = @"机构简介";
            
            break;
        case 2:
            
            superView.titleLabel.text = @"服务及收费";
            
            break;
        case 3:
            
            superView.titleLabel.text = @"医疗服务";
           
            break;
        case 4:
            
            superView.titleLabel.text = @"康娱设施";
            
            break;
        case 5:
            
            superView.titleLabel.text = @"精彩评论";
            
            break;
    }
    
    if (section) return superView;
    return [[UIView alloc]init];
}


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
        UIColor * color = HJRGBA(248, 97, 111, 1.0);
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.translucent = NO;
        
    }else{
        UIColor * color = [UIColor clearColor];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.translucent = YES;
    }
    
}

- (void)createTabbar{
    
    _tabbar = [[UITabBar alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 64 - 49, SCREEN_WIDTH, 49)];
    [_tabbar setShadowImage:[UIImage new]];
    
    [self.view addSubview:_tabbar];
    
    _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 49);
    _commentBtn.backgroundColor = HJRGBA(248, 97, 111, 1.0);
    [_commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    _commentBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [_commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_tabbar addSubview:_commentBtn];

}

// 设置导航栏透明
- (void)setNavigationBarStyleClear{
    
    UIColor * color = [UIColor clearColor];
    UIButton * praise = [UIButton buttonWithType:UIButtonTypeCustom];
    praise.frame = CGRectMake(15, SCREEN_HEIGHT - 184, 50, 50);
    [praise setBackgroundImage:[UIImage imageNamed:@"laud01"] forState:UIControlStateNormal];
    [praise setBackgroundImage:[UIImage imageNamed:@"laud02"] forState:UIControlStateSelected];
    [praise addTarget:self action:@selector(praiseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:praise];
    
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:praise];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    self.navigationController.navigationBar.translucent = YES;
    
}

// 设置导航栏正常
- (void)setNavigationBarStyleNormal{
    
    UIColor * color = HJRGBA(248, 97, 111, 1.0);
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    
}

#pragma mark --------------ClickAction
- (void)praiseAction:(UIButton *)button{
    
    HJLog(@"点赞");
    if (button.selected) return;
    button.selected = YES;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBarStyleClear];
    [self scrollViewDidScroll:self.tableV];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setNavigationBarStyleNormal];
}


@end
