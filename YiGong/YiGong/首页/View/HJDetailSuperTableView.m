//
//  HJDetailSuperTableView.m
//  YiGong
//
//  Created by 黄靖 on 16/3/31.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJDetailSuperTableView.h"
#import "HJDetailHeaderView.h"
#import "HJPartakeViewController.h"
#import "HJPickerImageViewController.h"
@implementation HJDetailSuperTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    
    CGRect rect = CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.frame = rect;
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49);
    self.tableV.delegate = self;
    self.tableV.dataSource = self;

    [self addSubview:self.tableV];
    
    _topicImageView = [[UIImageView alloc]init];
    UIImage * image = [UIImage imageNamed:@"banner"];
    _topicImageView.frame = CGRectMake(0, -image.size.height, SCREEN_WIDTH, SCREEN_WIDTH * image.size.height/image.size.width);
    _topicImageView.image = image;
    [self.tableV addSubview:_topicImageView];
    self.tableV.contentInset=UIEdgeInsetsMake(_topicImageView.frame.size.height,0,0,0);
    
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
    static NSString * reuseID = @"HJMainTableViewCell";
    _cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!_cell) {
        _cell = [[HJDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        _model = [[HJMainModel alloc]init];
        _cell.indexPath = indexPath;
        _cell.mainModel = _model;
    }
    return _cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0)  return 0.0001f;
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) return 304;
    UITableViewCell * detailCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return detailCell.frame.size.height;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        HJPartakeViewController * partakeVC = [[HJPartakeViewController alloc]init];
        partakeVC.title = @"养老机构公益书画展";
        [[self getCurrentViewController].navigationController pushViewController:partakeVC animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HJDetailHeaderView * superView = [[HJDetailHeaderView alloc]init];
    switch (section) {
        case 1:
            superView.titleLabel.text = @"主办方：工人文化馆";
            break;
        case 2:
            superView.titleLabel.text = @"活动介绍";
            break;
        case 3:
        {
            superView.titleLabel.text = @"活动行程";
            NSDateFormatter * dfm = [[NSDateFormatter alloc]init];
            [dfm setDateFormat:@"yyyy-MM-dd"];
            NSString * timeStr = [dfm stringFromDate:[NSDate date]];
            superView.timeDateLabel.text = timeStr;
        }
            break;
        case 4:
        {
            superView.titleLabel.text = @"活动回顾";
            HJPickerImageViewController * pickerVC = [[HJPickerImageViewController alloc]init];
            pickerVC.imageTitle = _model.activityTitle;
            superView.pushToPickerViewBlock = ^{
                [[self getCurrentViewController].navigationController pushViewController:pickerVC animated:YES];
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
    HJLog(@"yOffset===%f",yOffset);
    
    if(yOffset < -226) {

        CGRect f =self.topicImageView.frame;
        f.origin.y= yOffset ;
        f.size.height=  -yOffset;
        self.topicImageView.frame= f;
        
    }
    
    if (yOffset >= -64) {
        UIColor * color = HJRGBA(248, 97, 111, 1.0);
        [[self getCurrentViewController].navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
        [self getCurrentViewController].navigationController.navigationBar.translucent = NO;
        
    }else{
        UIColor * color = [UIColor clearColor];
        [[self getCurrentViewController].navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
        [self getCurrentViewController].navigationController.navigationBar.translucent = YES;
    }

}

@end
