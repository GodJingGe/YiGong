//
//  HJTopicDetailViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/7.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJTopicDetailViewController.h"
#import "HJTopicDetailTableViewCell.h"
#import "HJDetailHeaderView.h"
#import "HJTopicCommentModel.h"
#import "HJInputToolBar.h"
#define TOPIC_COMMENT_URL @"vtnlist"
#define REPLY_URL @"vtnadd"

@interface HJTopicDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isReply;
    HJTopicCommentModel * currentModel;
}
/** 标签栏*/
@property(nonatomic, strong) UITabBar *tabbar;
/** UITableView*/
@property(nonatomic, strong) UITableView *tableV;
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
/** 输入工具栏*/
@property(nonatomic, strong) HJInputToolBar *inputToolBar;
@end

@implementation HJTopicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createValue];
    [self createUI];
}

- (void)createValue{
    _dataSource = [NSMutableArray array];
//    for (int i = 0; i < 3; i ++) {
//        HJTopicModel * model = [[HJTopicModel alloc]init];
//        [_dataSource addObject:model];
//    }
     [self loadData];
}

- (void)loadData{
    HJRequestTool * tool = [[HJRequestTool alloc]init];
    NSDictionary * dic = [NSDictionary dictionaryWithObject:self.topicModel.topicId forKey:@"vttid"];
    NSString * url = [NSString stringWithFormat:COMMON_URL,TOPIC_COMMENT_URL];
    
    [tool postJSONWithUrl:url parameters:dic success:^(id responseObject) {
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary * data = dataDic[@"pd"];
        [_dataSource removeAllObjects];
        for (NSDictionary * dict in data[@"first"]) {
            HJTopicCommentModel *model = [HJTopicCommentModel mj_objectWithKeyValues:dict];
            model.type = @"1";
            HJLog(@"%@",model.nickName);
            [_dataSource addObject:model];
        }
        for (NSDictionary * dict in data[@"second"]) {
            HJTopicCommentModel *model = [HJTopicCommentModel mj_objectWithKeyValues:dict];
            model.type = @"2";
            [_dataSource addObject:model];
        }
        [_tableV reloadData];
    } fail:^(NSError *error) {
        
    }];
}


- (void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49);
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
    
    _tabbar = [[UITabBar alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64-49, SCREEN_WIDTH, 49)];
    [_tabbar setShadowImage:[UIImage new]];
    [self.view addSubview:_tabbar];
    
    UIButton * replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    replyBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 49);
    [replyBtn setBackgroundColor:HJRGBA(248, 97, 111, 1.0)];
    [replyBtn setTitle:@"回复他" forState:UIControlStateNormal];
    [replyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [replyBtn addTarget:self action:@selector(replyTopic:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabbar addSubview:replyBtn];
}

#pragma mark --------------ClickAction
- (void)replyTopic:(UIButton *)button{
    // 评论事件
    isReply = NO;
    [self commentAction];
}

#pragma mark --------------UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section) return _dataSource.count;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * detailCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return detailCell.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJTopicDetailTableViewCell";
    HJTopicDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[HJTopicDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
        cell.indexPath = indexPath;
         __weak typeof(self) weakSelf = self;
        if (indexPath.section) {
            cell.model = _dataSource[indexPath.row];
            [cell.commentView setReplyBlock:^{
                currentModel = _dataSource[indexPath.row];
                isReply = YES;
                [weakSelf commentAction];
            }];
        }else{
            [cell.commentView setReplyBlock:^{
                isReply = NO;
                [weakSelf commentAction];
            }];

            cell.topicModel = self.topicModel;
        }
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HJDetailHeaderView * header = [[HJDetailHeaderView alloc]init];
    header.titleLabel.text = @"精彩评论";
    if (section) return header;
    return [[UIView alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (!section) return 0.0001f;
    return 50;
}

// 提交评论
- (void)commitAction:(NSString *)content{
    
    NSString * url = [NSString stringWithFormat:COMMON_URL,REPLY_URL];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"userid"];
    [dic setValue:self.topicModel.topicId forKey:@"vttid"];
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

- (void) hideKeyboard{
    [self.inputToolBar.textView resignFirstResponder];
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

// tabbar点击事件
- (void)commentAction{
    [self.inputToolBar.textView becomeFirstResponder];
    
}

@end
