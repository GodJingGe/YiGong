//
//  HJCMWDetailViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/3/31.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJCMWDetailViewController.h"
#import "HJDetailSuperTableView.h"
#import "HJDetailHeaderView.h"
#import "HJPartakeViewController.h"
#import "HJPickerImageViewController.h"
#import "HJTakePartInViewController.h"
#import "HJImageBrowserViewController.h"
#import "HJLoginViewController.h"
#import "HJMainImageModel.h"
#import "HJPartakeModel.h"
#import "HJCommentModel.h"
#import "HJInputToolBar.h"
#import "HJDetailTabbar.h"
#define PARTAKE_URL @"vaelist"                  // 报名详情
#define REVIEW_URL  @"vailist"                  // 活动回顾
#define COMMENT_URL @"vanlist"                  // 评论列表
#define PRAISE_URL  @"vapadd"                   // 活动点赞
#define REPLY_URL   @"vanadd"                   // 活动回复
#define JOIN_URL    @"vae"                      // 活动报名

@interface HJCMWDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isReply;
   
}
/** 标签栏*/
@property(nonatomic, strong) HJDetailTabbar *tabbar;
/** 评论 */
@property(nonatomic, strong) UIButton *commentBtn;
/** 报名*/
@property(nonatomic, strong) UIButton *partakeBtn;
/** 图片*/
@property(nonatomic, strong) UIImageView *topicImageView;
/** UITableView*/
@property(nonatomic, strong) UITableView *tableV;
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
/** 已报名头像预览*/
@property(nonatomic, strong) NSMutableArray *partakeImages;
/** 活动回顾图片*/
@property(nonatomic, strong) NSMutableArray *reviewImages;
/** 评论数据源*/
@property(nonatomic, strong) NSMutableArray *commentDatas;
/** UITableViewCell*/
@property(nonatomic, strong) HJDetailTableViewCell *cell;
/** 输入工具栏*/
@property(nonatomic, strong) HJInputToolBar *inputToolBar;
/** 请求体字段*/
@property(nonatomic, strong) NSMutableDictionary * dic;
/** 当前模型*/
@property(nonatomic, strong)  HJCommentModel * currentModel;
@end

@implementation HJCMWDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self createUI];
}

// 初始化界面
- (void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];

    [self createTabbar];
    
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
    
    // 主题图片
    _topicImageView = [[UIImageView alloc]init];
    UIImage * image = [UIImage imageNamed:@"banner"];
    if (_mainModel.images.count){
        HJMainImageModel * imageModel = _mainModel.images[0];
        NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:COMMON_IMAGE_URL,imageModel.imageUrl]];
        [_topicImageView sd_setImageWithURL:url placeholderImage:image];
    }
    _topicImageView.frame = CGRectMake(0, -226, SCREEN_WIDTH, 226);
    [self.tableV addSubview:_topicImageView];
    self.tableV.contentInset=UIEdgeInsetsMake(_topicImageView.frame.size.height,0,0,0);
}
// 加载数据
- (void)loadData{
    // 初始化数据源
    _dataSource = [NSMutableArray array];
    _reviewImages = [NSMutableArray array];
    _commentDatas = [NSMutableArray array];
    // 创建请求对象
    HJRequestTool * request = [[HJRequestTool alloc]init];
    // 创建请求体
    NSDictionary * dic = [NSDictionary dictionaryWithObject:_mainModel.activityId forKey:@"vaid"];
    // 创建请求地址
    NSString * url = [NSString stringWithFormat:COMMON_URL,PARTAKE_URL];
    // 开始数据请求
    
    [request showLoadingHudWithTitle:@"Loading..." OnView:self.view];
    // 报名情况
    [request postJSONWithUrl:url parameters:dic success:^(id responseObject) {
//        HJLog(@"%@",responseObject);
        [request.hud hide:YES];
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray * arr = dataDic[@"pd"];
        for (NSDictionary * dict in arr) {
            HJPartakeModel *model = [HJPartakeModel mj_objectWithKeyValues:dict];
            [_dataSource addObject:model];
        }
        [_tableV reloadData];

    } fail:^(NSError *error) {
        [request.hud hide:YES];
        HJLog(@"%@",error);
    }];
    
    // 请求活动回顾
    [self requestReviewImages];
    
    // 请求评论列表
    [self requestCommentList];
    
}

// 活动回顾
- (void)requestReviewImages{
    NSDictionary * dic = [NSDictionary dictionaryWithObject:_mainModel.activityId forKey:@"vaid"];
    HJRequestTool * imageRequest = [[HJRequestTool alloc]init];
    NSString * imageUrl = [NSString stringWithFormat:COMMON_URL,REVIEW_URL];
    [imageRequest showLoadingHudWithTitle:@"Loading..." OnView:self.view];
    [imageRequest postJSONWithUrl:imageUrl parameters:dic success:^(id responseObject) {
        
        [imageRequest.hud hide:YES];
        
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray * arr = dataDic[@"pd"];
        
        // GCD 
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_group_t group = dispatch_group_create();
        
        for (NSDictionary * dict in arr) {
            NSString * iurl = dict[@"VAI_SRC"];
            dispatch_group_async(group, queue, ^{
             UIImage * image = [self getImageFromURL:[NSString stringWithFormat:COMMON_IMAGE_URL,iurl]];
            if (image) {
                    [_reviewImages addObject:image];
                }
            });
            
        }
        
        [_tableV reloadData];
    } fail:^(NSError *error) {
         [imageRequest.hud hide:YES];
    }];
}
- (void)requestCommentList{
    
    // 评论列表请求
     NSDictionary * dic = [NSDictionary dictionaryWithObject:_mainModel.activityId forKey:@"vaid"];
    HJRequestTool * commentRequest = [[HJRequestTool alloc]init];
    NSString * commentUrl = [NSString stringWithFormat:COMMON_URL,COMMENT_URL];
    
    // 显示菊花
    [commentRequest showLoadingHudWithTitle:@"Loading..." OnView:self.view];
    
    [commentRequest postJSONWithUrl:commentUrl parameters:dic success:^(id responseObject) {
        
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary * data = dataDic[@"pd"];
        [_commentDatas removeAllObjects];
        for (NSDictionary * dict in data[@"first"]) {
            HJCommentModel *model = [HJCommentModel mj_objectWithKeyValues:dict];
            model.type = @"1";
            [_commentDatas addObject:model];
        }
        for (NSDictionary * dict in data[@"second"]) {
            HJCommentModel *model = [HJCommentModel mj_objectWithKeyValues:dict];
            model.type = @"2";
            [_commentDatas addObject:model];
        }
        // 隐藏菊花
        [commentRequest.hud hide:YES];
        // 刷新列表
        [_tableV reloadData];
        
    } fail:^(NSError *error) {
        // 隐藏菊花
        [commentRequest.hud hide:YES];
    }];
}

#pragma mark --------------UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 5) return _commentDatas.count;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJMainTableViewCell";
    _cell = [tableView dequeueReusableCellWithIdentifier:@"reuseID"];
    if (!_cell) {
        _cell = [[HJDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        _cell.indexPath = indexPath;
    }
    switch (indexPath.section) {
        case 0:
            _cell.mainModel = _mainModel;
            break;
        case 1:
            [_cell setPartakeDatas:_dataSource andModel:_mainModel];
            break;
        case 2:
            _cell.content = _mainModel.activityContent;
            break;
        case 3:
            _cell.schedule = _mainModel.activitySchedule;
            break;
        case 4:{
            __weak typeof(self) weakSelf = self;
            _cell.reviewImages = self.reviewImages;
            [_cell setBrowserPicBlock:^(NSMutableArray *images) {
                HJImageBrowserViewController * browserVC = [[HJImageBrowserViewController alloc]init];
                browserVC.images = images;
                browserVC.currentOffset = 1;
                [weakSelf.navigationController pushViewController:browserVC animated:YES];
            }];
        }
            break;
        case 5:
            _cell.commentModel = _commentDatas[indexPath.row];
            
            __weak typeof(self) weakSelf = self;
            [_cell.commentView setReplyBlock:^{
                weakSelf.currentModel = weakSelf.commentDatas[indexPath.row];
                NSString *string = [NSString stringWithFormat:@"回复@%@:",weakSelf.currentModel.nickName];
                isReply = YES;
                
                [weakSelf commentAction:string];
            }];
            break;
    }
    
    return _cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0)  return 0.0001f;
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * detailCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    HJLog(@"%f",detailCell.frame.size.height);
    return detailCell.frame.size.height;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        HJPartakeViewController * partakeVC = [[HJPartakeViewController alloc]init];
        partakeVC.dataSource = _dataSource;
        partakeVC.title = @"养老机构公益书画展";
        [self.navigationController pushViewController:partakeVC animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HJDetailHeaderView * superView = [[HJDetailHeaderView alloc]init];
    switch (section) {
        case 1:
            superView.titleLabel.text = [NSString stringWithFormat:@"主办方：%@",_mainModel.teamName];
            break;
        case 2:
            superView.titleLabel.text = @"活动介绍";
            break;
        case 3:
        {
            superView.titleLabel.text = @"活动行程";
            NSArray * array = [_mainModel.activityTime componentsSeparatedByString:@" "];
//            NSString * timeStr = [dfm stringFromDate:[NSDate date]];
            superView.timeDateLabel.text = [array objectAtIndex:0];
        }
            break;
        case 4:
        {
            superView.titleLabel.text = @"活动回顾";
            HJPickerImageViewController * pickerVC = [[HJPickerImageViewController alloc]init];
            pickerVC.activityId = _mainModel.activityId;
            pickerVC.imageTitle = _mainModel.activityTitle;
            pickerVC.isTeamCer = NO;
            superView.pushToPickerViewBlock = ^{
                [self.navigationController pushViewController:pickerVC animated:YES];
            };
            [superView addSubview:superView.addPicBtn];
        }
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
//    HJLog(@"yOffset===%f",yOffset);
    
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

#pragma mark --------------CreateByMyself

// 下载图片
-(UIImage *) getImageFromURL:(NSString *)fileURL {
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}

// 创建标签栏
- (void)createTabbar{
    _tabbar = [[HJDetailTabbar alloc]initWithCommentAction:^{
        // 评论事件
        isReply = NO;
        [self commentAction:@"回复"];
    } andTakePartInAction:^{
        // 跳转到报名详情
        [self partakeActivityAction];
    }];
    _tabbar.frame = CGRectMake(0, SCREEN_HEIGHT-64-49, SCREEN_WIDTH, 49);
    [_tabbar setShadowImage:[UIImage new]];
    [self.view addSubview:_tabbar];
    
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
// 纯文本提示框
- (void)showHudWithText:(NSString *)text{
    MBProgressHUD * hud = [[MBProgressHUD alloc]init];
    hud.labelText = text;
    hud.mode = MBProgressHUDModeText;
    [self.view addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:1];
}

#pragma mark --------------ClickAction

- (void) hideKeyboard{
    [self.inputToolBar.textView resignFirstResponder];
}

- (void)praiseAction:(UIButton *)button{
    HJLog(@"点赞");
    HJRequestTool * tool = [[HJRequestTool alloc]init];
    NSString * url =[NSString stringWithFormat:COMMON_URL,PRAISE_URL];
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObject:_mainModel.activityId forKey:@"vaid"];
    NSString * userid = [[NSUserDefaults standardUserDefaults] valueForKey:@"userid"];
    if ([self isLogin]) {
        [dic setValue:userid forKey:@"userid"];
    }else{
        return;
    }
    
    [tool showLoadingHudWithTitle:@"" OnView:self.view];
    [tool postJSONWithUrl:url parameters:dic success:^(id responseObject) {
        NSDictionary * jsondata = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        HJLog(@"%@",jsondata);
        [tool.hud hide:YES];
        [self showHudWithText:jsondata[@"info"]];
    } fail:^(NSError *error) {
        [tool.hud hide:YES];
    }];
    button.selected = YES;
    
}
- (void)createAlertControllerWithTitle:(NSString *)title{
   
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        HJLoginViewController * loginVC = [[HJLoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:ok];
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];

}
// tabbar点击事件
- (void)commentAction:(NSString *)replyNickName{
    self.inputToolBar.placeholderLabel.text = replyNickName;
    [self.inputToolBar.textView becomeFirstResponder];
    
}

- (void)partakeActivityAction{
    
    NSString * url = [NSString stringWithFormat:COMMON_URL,JOIN_URL];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    if ([self isLogin]) {
        [dic setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"userid"];
    }else{
        return;
    }
    
    [dic setValue:_mainModel.activityId forKey:@"vaid"];
    HJRequestTool * tool = [[HJRequestTool alloc]init];
    [tool postJSONWithUrl:url parameters:dic success:^(id responseObject) {
        
        NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        HJLog(@"%@",jsonData);
        if ([jsonData[@"result"] isEqualToString:@"01"]) {
            [self showHudWithText:@"报名成功"];
        }else{
            [self showHudWithText:jsonData[@"info"]];
        }
        self.tableV.contentOffset = CGPointMake(0, self.tableV.contentSize.height - SCREEN_HEIGHT + 64);
    } fail:^(NSError *error) {
        [self showHudWithText:@"报名失败"];
    }];
//    HJTakePartInViewController * takePartInVC = [[HJTakePartInViewController alloc]init];
//    [self.navigationController pushViewController:takePartInVC animated:YES];
    
}



// 提交评论
- (void)commitAction:(NSString *)content{
    
    NSString * url = [NSString stringWithFormat:COMMON_URL,REPLY_URL];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    if ([self isLogin]) {
        [dic setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"userid"];
    }else{
        return ;
    }
    
    [dic setValue:_mainModel.activityId forKey:@"vaid"];
    if (isReply) {
        [dic setValue:_currentModel.messageId forKey:@"newid"];
    }
    
    if (content.length) {
        [dic setValue:content forKey:@"content"];
    }else{
        [self showHudWithText:@"评论内容不能为空"];
        return;
    }
    
    HJRequestTool * tool = [[HJRequestTool alloc]init];
    [tool postJSONWithUrl:url parameters:dic success:^(id responseObject) {
        
        NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString * result;
        if ([jsonData[@"result"] isEqualToString:@"01"]) {
            result = @"评论成功！";
        }
        [self showHudWithText:result];
        [self requestCommentList];
        self.tableV.contentOffset = CGPointMake(0, self.tableV.contentSize.height - SCREEN_HEIGHT);
    } fail:^(NSError *error) {
        
    }];
}


#pragma mark --------------SystemDelegate

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationBarStyleClear];
    [self scrollViewDidScroll:self.tableV];
}

- (void)viewDidAppear:(BOOL)animated{
    
}

@end
