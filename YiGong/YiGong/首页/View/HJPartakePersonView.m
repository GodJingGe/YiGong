//
//  HJPartakePersonView.m
//  YiGong
//
//  Created by 黄靖 on 16/3/31.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJPartakePersonView.h"

#define IMAGE_SIZE 30
@implementation HJPartakePersonView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

/** 活动人数*/
- (UILabel *)personsLabel{
    if (!_personsLabel) {
    
        _personsLabel = [[UILabel alloc]init];
        _personsLabel.frame = CGRectMake(SCREEN_WIDTH *2/3 - 30 , 15, SCREEN_WIDTH/3, 30);
        _personsLabel.textColor = HJRGBA(248, 97, 111, 1.0);
        _personsLabel.font = [UIFont systemFontOfSize:14];
        _personsLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_personsLabel];
    }
    return _personsLabel;
}

// 传入模型
- (void)setModel:(HJMainModel *)model{
    _model = model;
    self.personsLabel.text = [NSString stringWithFormat:@"已有%@/%@人报名",model.activityPersons,model.totalPersons];
}

// 传入数据源
- (void)setPartakePersons:(NSMutableArray *)partakePersons{
    _partakePersons = [NSMutableArray array];
    [_partakePersons addObjectsFromArray:partakePersons];
    
    for (int i = 0; i < partakePersons.count; i ++) {
        UIImageView * imageV = [[UIImageView alloc]init];
        imageV.layer.cornerRadius = IMAGE_SIZE/2;
        imageV.clipsToBounds = YES;
        imageV.frame = CGRectMake(15 + (IMAGE_SIZE + 10) * i, 15, IMAGE_SIZE, IMAGE_SIZE);
        NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:COMMON_IMAGE_URL,partakePersons[i]]];
        // 请求图片
        [imageV sd_setImageWithURL:url];

        [self addSubview:imageV];
    }
}
@end
