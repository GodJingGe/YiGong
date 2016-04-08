//
//  HJPartakeViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/1.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJPartakeViewController.h"
#import "HJPartakeTableViewCell.h"

@interface HJPartakeViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableVIew*/
@property(nonatomic, strong) UITableView *tableV;
@end

@implementation HJPartakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewConfig];
}

- (void)viewConfig{
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
}

#pragma mark --------------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJPartakeTableViewCell";
    HJPartakeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[HJPartakeTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
        cell.iconImageView.image = [UIImage imageNamed:@"headp-80x80_01"];
        cell.titleLabel.text = @"沐沐沐雅";
        cell.detailLabel.text = @"刚刚 参加了报名";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 76;
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
