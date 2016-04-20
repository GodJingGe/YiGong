//
//  HJGCMAssessViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/7.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJGCMAssessViewController.h"
#import "HJAssessTableViewCell.h"
#import "HJDetailHeaderView.h"
#import "HJAssessModel.h"
#import "HJFooterView.h"
#define ASSESS_URL @"gmailist"
#define UPLOAD_URL @"gmaradd"

@interface HJGCMAssessViewController ()<UITableViewDataSource,UITableViewDelegate>
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
/** 列表*/
@property(nonatomic, strong) UITableView *tableV;
/** 当前编辑的cell*/
@property(nonatomic, strong) HJAssessTableViewCell *currentCell;
/** 文本框标识*/
@property(nonatomic,assign) NSInteger textTag;
/** 当前位置*/
@property(nonatomic,assign)CGPoint currentOffset;
/**评测得分数据源*/
@property(nonatomic,strong)NSMutableArray *scoreDataSource;
/** 请求数据工具类*/
@property(nonatomic,strong)HJRequestTool *request;
/** 请求地址*/
@property(nonatomic,strong)NSString *requestPath;
/** 是否正在刷新*/
@property(nonatomic, assign) Boolean isRefreshing;

@end

@implementation HJGCMAssessViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self createValue];
    [self createUI];
}

- (void)createValue{
    _dataSource = [NSMutableArray array];
    _request = [[HJRequestTool alloc]init];
//    NSArray * arr = @[@"进水能力",@"大小便自理能力",@"进食自理能力",@"大小便自理能力"];
//    [_dataSource addObjectsFromArray:arr];
    [self loadData];
}

- (void)createUI{
    
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49 - 44);
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
    
    // 添加下拉刷新和上拉加载视图
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if(_isRefreshing) return;
        
        _isRefreshing = YES;
        [self loadData];
        _isRefreshing = NO;
        [_tableV.mj_header endRefreshing];
    }];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableV addGestureRecognizer:gestureRecognizer];
    
    //ps:加上这句不会影响你 tableview 上的 action (button,cell selected...)
    gestureRecognizer.cancelsTouchesInView = NO;
    
}

- (void)loadData{
    NSMutableDictionary * para = [[NSMutableDictionary alloc]init];
    
    _requestPath = [NSString stringWithFormat:COMMON_URL,ASSESS_URL];
    [self.request postJSONWithUrl:_requestPath parameters:para success:^(id responseObject) {
        HJLog(@"请求成功！");
        [_dataSource removeAllObjects];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray * arr = dic[@"pd"];
        for (NSDictionary * dic in arr) {
            HJAssessModel * model = [HJAssessModel mj_objectWithKeyValues:dic];
            [_dataSource addObject:model];
        }
        [_tableV reloadData];
            
        } fail:^(NSError * error){
        HJLog(@"%@",error);
        [self showHudWithText:@"加载失败"];
    }];
}

#pragma mark -----------UITableViewDataSource
// 返回分组cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

// 返回Cell行高
-  (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [self tableView: tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
// 分组尾部高
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 90;
}
// 返回分组头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
// 返回分组尾部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    HJFooterView * footer = [[HJFooterView alloc]initWithAction:^{
        [self commitAction];
    }];
    [footer.footerBtn setTitle:@"提交" forState:UIControlStateNormal];
    return footer;
}
#pragma mark -----------UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _currentCell = [self.tableV cellForRowAtIndexPath:indexPath];
    [_currentCell.scoreTF resignFirstResponder];
}

// 初始化cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJAssessTableViewCellID";
    HJAssessTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
    if (cell == nil) {
        
        cell = [[HJAssessTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.model = _dataSource[indexPath.row];
        [cell setHiddenKeyBoardBlock:^(HJAssessTableViewCell *currentCell) {
            _currentCell = currentCell;
        }];
    }
    
    return cell;
}

#pragma mark ----ClickAction
// 提交
- (void)commitAction{
    NSMutableArray * arr = [NSMutableArray array];
    for (HJAssessModel * model in _dataSource) {
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObject:model.questionId forKey:@"gmai_id"];
        [dic setObject:model.currentScore forKey:@"gmar_score"];
        [arr addObject:dic];
    }
    
    NSString * jsonString = [arr mj_JSONString];
    HJRequestTool * tool = [[HJRequestTool alloc]init];
    NSString * url = [NSString stringWithFormat:COMMON_URL,UPLOAD_URL];
    NSMutableDictionary * para = [NSMutableDictionary dictionaryWithObject:jsonString forKey:@"json"];
    [para setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"]forKey:@"userid"];
    [tool postJSONWithUrl:url parameters:para success:^(id responseObject) {
        NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([jsonData[@"result"] isEqualToString:@"01"]) {
            [self showHudWithText:@"提交成功！"];
        }
    } fail:^(NSError *error) {
        
    }];

}

- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}


// 创建选择提示框
- (void)createUIAlertAcionAlertWithActions:(NSArray *)actions Title:(NSString *)title{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i < actions.count; i ++) {
        UIAlertAction * titleAction = [UIAlertAction actionWithTitle:actions[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertVC addAction:titleAction];
    }
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark --------------UITapGestureRecognizer
// 隐藏键盘
- (void) hideKeyboard {
    [_currentCell.scoreTF resignFirstResponder];
}
@end
