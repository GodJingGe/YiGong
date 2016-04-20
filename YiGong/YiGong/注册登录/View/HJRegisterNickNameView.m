//
//  HJRegisterNickNameView.m
//  YiGong
//
//  Created by 黄靖 on 16/4/13.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJRegisterNickNameView.h"

@implementation HJRegisterNickNameView

- (instancetype)initWithNextAction:(void(^)(NSString *nickName))next{
    self = [super init];
    if (self) {
        self.backgroundColor = BG_COLOR;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        [self createUI];
        self.nextBlock = next;
    }
    return self;
}
- (void)createUI{
    _userView = [[UIView alloc]init];
    _userView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    _userView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_userView];
    
    
    // 设置占位文字的颜色
    //    [_usernameTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    //设置左视图
    _nickNameTF = [[UITextField alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH-30, 30)];
    _nickNameTF.placeholder = @"请输入昵称，14个字符，7个字";
    [_userView addSubview:_nickNameTF];
    
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(15, SCREEN_HEIGHT - 89 - 64, SCREEN_WIDTH - 30, 40);
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn setBackgroundImage:[UIImage imageWithColor:THEME_COLOR] forState:UIControlStateNormal];
    [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    _nextBtn.layer.cornerRadius = 5;
    _nextBtn.clipsToBounds = YES;
    [self addSubview:_nextBtn];
}

- (void)nextAction:(UIButton *)button{
    
    if (self.nextBlock) {
        self.nextBlock(_nickNameTF.text);
    }
    
}
@end
