//
//  HJAddScheduleViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/19.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJAddScheduleViewController.h"
#import "HJScheduleTableViewCell.h"
#import "HJFooterView.h"
#import "HJScheduleModel.h"
#import "HJDatePickerView.h"

@interface HJAddScheduleViewController ()<UITableViewDelegate,UITableViewDataSource>
/** Table*/
@property(nonatomic, strong) UITableView *tableV;
/** 数据源*/
@property(nonatomic, strong) NSMutableArray <HJScheduleModel *>*dataSource;
/** 当前cell*/
@property(nonatomic, strong) HJScheduleTableViewCell *currentCell;
/** 时间选择器*/
@property(nonatomic, strong) HJDatePickerView  *dateView;
@end

@implementation HJAddScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createValue];
    [self createUI];
}
- (void)createUI{
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.rowHeight = 60;
    [self.view addSubview:self.tableV];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableV addGestureRecognizer:gestureRecognizer];
    
    //ps:加上这句不会影响你 tableview 上的 action (button,cell selected...)
    gestureRecognizer.cancelsTouchesInView = NO;
}
- (void)createValue{
    _dataSource = [NSMutableArray array];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(completeAddAction)];
}
- (void)completeAddAction{
    self.completeAdd(_dataSource);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --------------UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJPubActivityTableViewCell";
    HJScheduleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[HJScheduleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.indexPath = indexPath;
        cell.model = _dataSource[indexPath.row];
        // 选择时间
        [cell setPickerDateBlock:^{
          _dateView = [[HJDatePickerView alloc]initAndGetTime:^(NSString *timeDate) {
              _dataSource[indexPath.row].dateTime = [[timeDate componentsSeparatedByString:@" "] lastObject];
              [cell.dateBtn setTitle:_dataSource[indexPath.row].dateTime forState:UIControlStateNormal];
              
          }];
        }];
        
        // 获得当前编辑的cell
        [cell setGetCurrentCell:^(HJScheduleTableViewCell *currentCell) {
            _currentCell = currentCell;
        }];
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0)  return 0.0001f;
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    HJFooterView * footer = [[HJFooterView alloc]initWithAction:^{
        HJScheduleModel * model = [[HJScheduleModel alloc]init];
        [_dataSource addObject:model];
        [_tableV reloadData];
    }];
    
    [footer.footerBtn setTitle:@"新增" forState:UIControlStateNormal];
    
    return footer;
}


/**
 *  键盘隐藏
 */
- (void)hideKeyboard{
    [_currentCell.textF resignFirstResponder];
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
