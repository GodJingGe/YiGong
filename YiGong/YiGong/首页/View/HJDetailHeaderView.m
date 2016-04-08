//
//  HJDetailHeaderView.m
//  YiGong
//
//  Created by 黄靖 on 16/3/31.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJDetailHeaderView.h"

@implementation HJDetailHeaderView
- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.frame = CGRectMake(15, 0, SCREEN_WIDTH - 15, 50);
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = HJRGBA(100, 100, 100, 1.0);
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)timeDateLabel{
    if (!_timeDateLabel) {
        _timeDateLabel = [[UILabel alloc]init];
        _timeDateLabel.frame = CGRectMake(SCREEN_WIDTH *2/3 , 15, SCREEN_WIDTH/3 - 15, 20);
        _timeDateLabel.textColor = HJRGBA(60, 206, 132, 1.0);
        _timeDateLabel.font = [UIFont systemFontOfSize:16];
        _timeDateLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_timeDateLabel];
    }
    return _timeDateLabel;
}

-(UIButton *)addPicBtn{
    if (!_addPicBtn) {
        _addPicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addPicBtn.frame = CGRectMake(SCREEN_WIDTH - 35, 15, 20, 20);
        [_addPicBtn setImage:[UIImage imageNamed:@"addTo"] forState:UIControlStateNormal];
        [_addPicBtn addTarget:self action:@selector(addPicAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addPicBtn];
    }
    return _addPicBtn;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark --------------ClickAction
- (void)addPicAction:(UIButton *)button{
    self.pushToPickerViewBlock();
}
@end
