//
//  HJPublishViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/6.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJPublishViewController.h"
#import "HJPublishView.h"

#define TOPICPUB_URL @"vttadd"

@interface HJPublishViewController ()<UITextViewDelegate>
/** 输入视图*/
@property(nonatomic, strong) HJPublishView *inputView;
@end

@implementation HJPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(publishTopic)];
    self.view.backgroundColor = HJRGBA(240, 239, 245, 1.0);
    _inputView = [[HJPublishView alloc]init];
    [_inputView addSubview:_inputView.textBgView];
    _inputView.titleTF.placeholder = @"标题内容：";
    _inputView.textV.delegate = self;
    _inputView.placeholerLabel.text = @"话题内容：";
    [self.view addSubview:_inputView];
}

- (void)publishTopic{
    NSString * url = [NSString stringWithFormat:COMMON_URL,TOPICPUB_URL];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    if ([self isLogin]) 
        [dic setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"userid"];
    else
        return;
    
    [dic setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"vtid"] forKey:@"vtid"];
    
    [dic setValue:self.inputView.titleTF.text forKey:@"title"];
    [dic setValue:self.inputView.textV.text forKey:@"content"];
    HJRequestTool * tool = [[HJRequestTool alloc]init];
    [tool postJSONWithUrl:url parameters:dic success:^(id responseObject) {
        
        NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString * result;
        if ([jsonData[@"result"] isEqualToString:@"01"]) {
            result = @"发布成功！";
        }
        [self showHudWithText:result];
    } fail:^(NSError *error) {
        [self showHudWithText:@"发布失败！"];
    }];
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
