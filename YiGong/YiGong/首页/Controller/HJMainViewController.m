//
//  HJMainViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/3/25.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJMainViewController.h"
#import "HJCMWDetailViewController.h"
#import "HJLocationLabel.h"
#import "HJAreaPickerView.h"
#import "HJMainModel.h"
#import "HJMainTableViewCell.h"

#define MAIN_URL @"valist"

@interface HJMainViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 当前位置*/
@property(nonatomic, strong) HJLocationLabel *locationLabel;
/** 选择当前位置*/
@property(nonatomic, strong) HJAreaPickerView *areaPicker;
/** 当前窗口*/
@property(nonatomic, strong) UIWindow *window;
/** UITableView*/
@property(nonatomic, strong) UITableView *tableV;
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
/** 是否正在刷新*/
@property(nonatomic, assign) Boolean isRefreshing;
/** 是否正在加载*/
@property(nonatomic, assign) Boolean isLoading;
/** UITableViewCell*/
@property(nonatomic, strong) HJMainTableViewCell *cell;
@end

@implementation HJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createValue];
     [self createUI];
}

#pragma mark --------------CreateByMyself
- (void)createValue{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _window = [UIApplication sharedApplication].keyWindow;
    
    self.view.backgroundColor = [UIColor greenColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"location"] style:UIBarButtonItemStyleDone target:self action:@selector(changeSite)];
    
    _dataSource = [NSMutableArray array];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"text"]) {
        NSLog(@"Height is changed! new=%@", [change valueForKey:NSKeyValueChangeNewKey]);
        [self loadData];
        [_locationLabel removeObserver:self forKeyPath:@"text"];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)createUI{
    
    _locationLabel = [[HJLocationLabel alloc]init];
    
    [_locationLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.navigationController.navigationBar addSubview:_locationLabel];
    
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49);
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    
    // 添加下拉刷新和上拉加载视图
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if(_isRefreshing) return;
        
        _isRefreshing = YES;
        [self loadData];
        _isRefreshing = NO;
        [_tableV.mj_header endRefreshing];
    }];
    
    self.tableV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if(_isLoading) return;
        
        _isLoading = YES;
        [self loadData];
        _isLoading = NO;
        [_tableV.mj_footer endRefreshing];
    }];
    [self.view addSubview:self.tableV];
    
}
- (void)loadData{
    
    HJRequestTool * request = [[HJRequestTool alloc]init];
    NSString * url= [NSString stringWithFormat:COMMON_URL,MAIN_URL];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:_locationLabel.text forKey:@"city"];
    [request postJSONWithUrl:url parameters:dic success:^(id responseObject) {
        [_dataSource removeAllObjects];
//        HJLog(@"%@",responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray * arr = dic[@"pd"];
        for (NSDictionary * dict in arr) {
            HJMainModel *model = [HJMainModel mj_objectWithKeyValues:dict];
            [_dataSource addObject:model];
            HJLog(@"%@",model.activityTime);
        }
        [_tableV reloadData];
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark --------------UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJMainTableViewCell";
    _cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!_cell) {
        _cell = [[HJMainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    if (_dataSource[indexPath.section])
        _cell.model = _dataSource[indexPath.section];
    return _cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 304;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HJCMWDetailViewController * cmwDVC = [[HJCMWDetailViewController alloc]init];
    cmwDVC.title = @"公益";
    if (_dataSource[indexPath.section]) {
        cmwDVC.mainModel = _dataSource[indexPath.section];
        [self.navigationController pushViewController:cmwDVC animated:YES];
    }
}


#pragma mark --------------ClickAction
- (void)changeSite{
    
    __weak typeof(self) weakSelf = self;
    _areaPicker = [[HJAreaPickerView alloc]initWithArea:^(NSString *province, NSString *city) {
        weakSelf.locationLabel.text = city;
    }];
}

#pragma mark --------------SystemDelegate
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar addSubview:self.locationLabel];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.locationLabel removeFromSuperview];
}
@end
