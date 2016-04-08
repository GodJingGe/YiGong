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

@interface HJGCMAssessViewController ()<UITableViewDataSource,UITableViewDelegate>
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
/** 列表*/
@property(nonatomic, strong) UITableView *tableV;
/** 当前编辑的cell*/
@property(nonatomic, strong) HJAssessTableViewCell *currentCell;

@end

@implementation HJGCMAssessViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self createValue];
    [self createUI];
}

- (void)createValue{
    NSArray * arr = @[@"进水能力",@"大小便自理能力",@"进食自理能力",@"大小便自理能力"];
    _dataSource = [NSMutableArray array];
    [_dataSource addObjectsFromArray:arr];
}

- (void)createUI{
    
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49 - 44);
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableV addGestureRecognizer:gestureRecognizer];
    
    //ps:加上这句不会影响你 tableview 上的 action (button,cell selected...)
    gestureRecognizer.cancelsTouchesInView = NO;
    
}

- (void)loadData{
    
}

#pragma mark --------------UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * reuseID = @"HJHealthCareTableViewCell";
    HJAssessTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (!cell) {
        cell = [[HJAssessTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.titleLabel.text = _dataSource[indexPath.row];
        [cell setCompleteEditingBlock:^(HJAssessTableViewCell *cell) {
            _currentCell = cell;
        }];
    }
    
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HJDetailHeaderView * superView = [[HJDetailHeaderView alloc]init];
    superView.titleLabel.text = @"日常生活活动能力";
    superView.backgroundColor = [UIColor clearColor];
    return superView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 60;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}


#pragma mark --------------UITapGestureRecognizer
- (void) hideKeyboard {
    [_currentCell.textF resignFirstResponder];
}
@end
