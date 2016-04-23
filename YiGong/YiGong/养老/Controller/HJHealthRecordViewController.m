//
//  HJHealthRecordViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/8.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJHealthRecordViewController.h"
#import "HJChartView.h"
#import "HJHealthRecordTableViewCell.h"
#import "HJHealthRecordModel.h"
#import "HJDetailHeaderView.h"
#import "HJAddNewRecordViewController.h"

#define HEALTH_URL @"gmhlist"

@interface HJHealthRecordViewController ()<UITableViewDataSource,UITableViewDelegate>
/** 数据源*/
@property(nonatomic,strong)NSMutableArray *dataSource;
/** 列表*/
@property(nonatomic,weak)UITableView *tableV;
/** 图标 */
@property (weak,nonatomic)HJChartView *chartView;
@end

@implementation HJHealthRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createValue];
    [self createUI];
}

#pragma mark --------------ClickAction
- (void)addNewHealthRecord{
    HJAddNewRecordViewController * addVC = [[HJAddNewRecordViewController alloc]init];
    addVC.title = @"新增记录";
    [self.navigationController pushViewController:addVC animated:YES];
}
- (void)loadData{
    
    HJRequestTool * tool = [[HJRequestTool alloc]init];
    NSString * url = [NSString stringWithFormat:COMMON_URL,HEALTH_URL];
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"userid"];
    [dic setValue:self.type forKey:@"type"];
    
    [tool postJSONWithUrl:url parameters:dic success:^(id responseObject) {
        [_dataSource removeAllObjects];
        NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray * arr = jsonData[@"pd"];
        for (NSDictionary * dic in arr) {
            HJHealthRecordModel * model = [HJHealthRecordModel mj_objectWithKeyValues:dic];
            [_dataSource addObject:model];
        }
        
        // 刷新数据
        self.chartView.dataSource = self.dataSource;
        [self.chartView showLine];
        [_tableV reloadData];
    } fail:^(NSError *error) {
        
    }];
}
#pragma mark --------------createByMyself
- (void)createValue{
    _dataSource = [NSMutableArray array];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStyleDone target:self action:@selector(addNewHealthRecord)];
    
//    NSDateFormatter * dfm = [[NSDateFormatter alloc]init];
//    [dfm setDateFormat:@"yyyy-MM-dd hh:mm"];
//    NSArray * values = @[@"110",@"120",@"90",@"97",@"105",@"130",@"145"];
//    for (int i = 0; i < values.count; i ++) {
//        HJHealthRecordModel * model = [[HJHealthRecordModel alloc]init];
//       
//        model.timeDate = [dfm stringFromDate:[NSDate date]];
//        model.value = values[i];
//        [_dataSource addObject:model];
//    }
    [self loadData];

}

- (void)createUI{
    HJChartView *chartView = [[HJChartView alloc]init];
    self.chartView = chartView;
    self.chartView.type = self.type;
    chartView.backgroundColor = HJRGBA(248, 97, 111, 1.0);
    chartView.frame = CGRectMake(0, 0, Mainsize.width, 200);
    [self.view addSubview:chartView];
    
    //tableview
    CGRect rect = CGRectMake(0, CGRectGetHeight(chartView.frame), Mainsize.width, Mainsize.height-CGRectGetHeight(chartView.frame)-64);
    UITableView *tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc]init];
    
    [self.view addSubview:tableView];
    
    // 划线
    self.chartView.dataSource = self.dataSource;
    [self.chartView showLine];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

#pragma mark----------UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJHealthRecordTableViewCell";
    HJHealthRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[HJHealthRecordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    cell.model = self.dataSource[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HJDetailHeaderView * superView = [[HJDetailHeaderView alloc]init];
    superView.titleLabel.text = self.title;
    return superView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}


@end
