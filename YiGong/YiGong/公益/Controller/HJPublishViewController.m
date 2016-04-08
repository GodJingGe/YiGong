//
//  HJPublishViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/6.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJPublishViewController.h"
#import "HJPublishView.h"
@interface HJPublishViewController ()<UITextViewDelegate>
/** 输入视图*/
@property(nonatomic, strong) HJPublishView *inputView;
@end

@implementation HJPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HJRGBA(240, 239, 245, 1.0);
    _inputView = [[HJPublishView alloc]init];
    [_inputView addSubview:_inputView.textBgView];
    _inputView.titleTF.placeholder = @"标题内容：";
    _inputView.textV.delegate = self;
    _inputView.placeholerLabel.text = @"话题内容：";
    [self.view addSubview:_inputView];
}

#pragma mark --------------UItextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length) {
        [_inputView.placeholerLabel removeFromSuperview];
    }else{
        [textView addSubview:_inputView.placeholerLabel];
    }
    
    _inputView.lengthLabel.text = [NSString stringWithFormat:@"%d",140 - (int)textView.text.length];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_inputView.titleTF resignFirstResponder];
    [_inputView.textV resignFirstResponder];
}
@end
