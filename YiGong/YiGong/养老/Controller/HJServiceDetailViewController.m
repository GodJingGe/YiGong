//
//  HJServiceDetailViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/7.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJServiceDetailViewController.h"
#import "HJServiceDetailTableViewCell.h"
#import "HJDetailHeaderView.h"
#import "HJInputToolBar.h"
#import "HJGcmCommentModel.h"
#define IMAGE_SIZE 260
#define GCM_COMMENT_URL @"gmnlist"
#define REPLY_URL @"gmnadd"
#define PRAISE_URL @"gmpadd"

@interface HJServiceDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isReply;
    HJGcmCommentModel * currentModel;
}
/** 输入工具栏*/
@property(nonatomic, strong) HJInputToolBar *inputToolBar;
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
/** 分组头视图*/
@property(nonatomic, strong) HJDetailHeaderView *superView;

@end

@implementation HJServiceDetailViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self createValue];
    [self createUI];
}

#pragma mark --------------CreateByMyself

- (void)createValue{
    _dataSource = [NSMutableArray array];
    [self loadData];
}

- (void)createUI{
    
    CGRect rect = CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT - 49);
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableV addGestureRecognizer:gestureRecognizer];
    
    //ps:加上这句不会影响你 tableview 上的 action (button,cell selected...)
    gestureRecognizer.cancelsTouchesInView = NO;
    
    self.inputToolBar = [[HJInputToolBar alloc]initWithCommitAction:^(NSString *content) {
        [self commitAction:content];
    }];
    self.inputToolBar.textView.returnKeyType = UIReturnKeySend;
    [self.view addSubview:self.inputToolBar];

    
    _topicImageView = [[UIImageView alloc]init];
    _topicImageView.frame = CGRectMake(0, -IMAGE_SIZE, SCREEN_WIDTH, IMAGE_SIZE);
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:COMMON_IMAGE_URL,self.model.gcmAvatar]];
    [_topicImageView sd_setImageWithURL:url];
    [self.tableV addSubview:_topicImageView];
    self.tableV.contentInset=UIEdgeInsetsMake(_topicImageView.frame.size.height,0,0,0);
    
    [self createTabbar];
    
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
    [_commentBtn addTarget:self action:@selector(commentToGcm:) forControlEvents:UIControlEventTouchUpInside];
    [_commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_tabbar addSubview:_commentBtn];
    
}

- (void)loadData{
    
    HJRequestTool * tool = [[HJRequestTool alloc]init];
    NSString * url = [NSString stringWithFormat:COMMON_URL,GCM_COMMENT_URL];
    NSDictionary * dic = [NSDictionary dictionaryWithObject:self.model.gcmId forKey:@"gmid"];
    [tool postJSONWithUrl:url parameters:dic success:^(id responseObject) {
        [_dataSource removeAllObjects];
        
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary * data = dataDic[@"pd"];
        [_dataSource removeAllObjects];
        for (NSDictionary * dict in data[@"first"]) {
            HJGcmCommentModel *model = [HJGcmCommentModel mj_objectWithKeyValues:dict];
            model.type = @"1";
            [_dataSource addObject:model];
        }
        for (NSDictionary * dict in data[@"second"]) {
            HJGcmCommentModel *model = [HJGcmCommentModel mj_objectWithKeyValues:dict];
            model.type = @"2";
            [_dataSource addObject:model];
        }
        [_tableV reloadData];
    } fail:^(NSError *error) {
        
    }];
    
}

#pragma mark --------------ClickAction

- (void)commentToGcm:(UIButton *)button{
    isReply = NO;
    [self commentAction];
}

- (void)praiseAction:(UIButton *)button{
    
    HJRequestTool * tool = [[HJRequestTool alloc]init];
    NSString * url = [NSString stringWithFormat:COMMON_URL,PRAISE_URL];
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObject:self.model.gcmId forKey:@"gmid"];
    [dic setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"userid" ] forKey:@"userid"];
    
    [tool postJSONWithUrl:url parameters:dic success:^(id responseObject) {
        NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        HJLog(@"%@",jsonData);
        [self showHudWithText:jsonData[@"info"]];
        button.selected = YES;
    } fail:^(NSError *error) {
        
    }];
    
    HJLog(@"点赞");
    if (button.selected) return;
    button.selected = YES;
    
}

// tabbar点击事件
- (void)commentAction{
    
    [self.inputToolBar.textView becomeFirstResponder];
    
}

// 隐藏键盘
- (void) hideKeyboard{
    [self.inputToolBar.textView resignFirstResponder];
}


// 提交评论
- (void)commitAction:(NSString *)content{
    
    NSString * url = [NSString stringWithFormat:COMMON_URL,REPLY_URL];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:self.model.gcmId forKey:@"gmid"];
    [dic setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"userid"];
    if (isReply) {
        [dic setValue:currentModel.messageId forKey:@"newid"];
    }
    [dic setValue:content forKey:@"content"];
    HJRequestTool * tool = [[HJRequestTool alloc]init];
    [tool postJSONWithUrl:url parameters:dic success:^(id responseObject) {
        
        NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString * result;
        if ([jsonData[@"result"] isEqualToString:@"01"]) {
            result = @"评论成功！";
        }
        [self showHudWithText:result];
        [self loadData];
        self.tableV.contentOffset = CGPointMake(0, self.tableV.contentSize.height - SCREEN_HEIGHT);
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark --------------UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 5)
        return _dataSource.count;
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJServiceDetailTableViewCell";
    HJServiceDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[HJServiceDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.indexPath = indexPath;
        [cell setCallToGcmBlock:^(NSString *number) {
            NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number]; 
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
        }];
        
        
        if (indexPath.section == 5) {
            if (_dataSource[indexPath.row]) {
                cell.commentModel = _dataSource[indexPath.row];
            }
            HJLog(@"%ld",(long)indexPath.row);
            [cell.commentView setReplyBlock:^{
                currentModel = _dataSource[indexPath.row];
                isReply = YES;
                [self commentAction];
            }];
            
        }else{
            cell.model = _model;
        }
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



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationBarStyleClear];
    [self scrollViewDidScroll:self.tableV];
}
- (void)viewDidAppear:(BOOL)animated{
    
}

@end
