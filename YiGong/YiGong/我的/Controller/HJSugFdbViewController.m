//
//  HJSugFdbViewController.m
//  AINursing
//
//  Created by 黄靖 on 16/3/9.
//  Copyright © 2016年 黄靖. All rights reserved.
//

#import "HJSugFdbViewController.h"
#import "HJSuggestionView.h"
#define FEDBACK_URL @"vfadd"
@interface HJSugFdbViewController ()
/** 输入框*/
@property(nonatomic,strong)HJSuggestionView *inputView;

@end

@implementation HJSugFdbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = HJRGBA(240, 239, 245, 1.0);
    
    _inputView = [[HJSuggestionView alloc]init];
    _inputView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
    _inputView.placeholerLabel.text = self.placeHolderText;
    _inputView.textV.text = _textViewText;
    _inputView.textV.delegate = self;
    [_inputView.textV becomeFirstResponder];
    [self textViewDidChange:_inputView.textV];
    [self.view addSubview:_inputView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(popToLastView)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(commitAction)];
}

#pragma mark --------------NavigationItemClickAction
- (void)popToLastView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)commitAction{
    
    HJRequestTool * tool = [[HJRequestTool alloc]init];
    NSString * url = [NSString stringWithFormat:COMMON_URL,FEDBACK_URL];
    NSMutableDictionary * para = [NSMutableDictionary dictionaryWithObject:self.inputView.textV.text forKey:@"content"];
    [para setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"userid"];
    [tool postJSONWithUrl:url parameters:para success:^(id responseObject) {
        NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (jsonData[@"result"]) {
            [self showHudWithText:@"提交成功！"];
            [self.inputView.textV resignFirstResponder];
            self.inputView.textV.text = @"";
        }
    } fail:^(NSError *error) {
        
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

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_inputView.textV resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_inputView.textV endEditing:YES];
}


@end
