//
//  HJInputToolBar.m
//  YiGong
//
//  Created by 黄靖 on 16/4/16.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJInputToolBar.h"

@implementation HJInputToolBar
{
    CGRect keyboardRect;
    CGRect newTextViewFrame;
}
- (instancetype)initWithCommitAction:(void(^)(NSString *content))commit
{
    self = [super init];
    if (self) {
        self.commitCommentBlock = commit;
        self.frame = CGRectMake(0, SCREEN_HEIGHT- 64, SCREEN_WIDTH, 49);
        [self addSubview:self.textView];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.frame = CGRectMake(10, 7, SCREEN_WIDTH - 20, 35);
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.layer.cornerRadius = 5;
        _textView.clipsToBounds = YES;
        _textView.delegate = self;
        [_textView addSubview:self.placeholderLabel];

        [self addSubview:_textView];
    }
    return _textView;
}

- (UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc]init];
        _placeholderLabel.frame = CGRectMake(10, 5, SCREEN_WIDTH, 22);
        _placeholderLabel.text = @"回复";
        _placeholderLabel.textColor = HJRGBA(204, 204, 204, 1.0);
        _placeholderLabel.font = [UIFont systemFontOfSize:14];
       
    }
    return _placeholderLabel;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    [self resetTextViewFrame];
    
    if (textView.text.length) {
        self.placeholderLabel.hidden = YES;
    }else{
        self.placeholderLabel.hidden = NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView endEditing:YES];
        self.commitCommentBlock(textView.text);
        return YES;
    }
    [self resetTextViewFrame];
    return YES;
}

- (void)resetTextViewFrame{
    self.textView.frame = CGRectMake(10, 10, SCREEN_WIDTH - 20, self.textView.contentSize.height);
    HJLog(@"%f",self.textView.contentSize.height);
    CGRect rect = self.frame;
    rect.size.height = self.textView.frame.size.height + 20;
    self.frame = rect;
    // 根据老的 frame 设定新的 frame
    newTextViewFrame = self.frame; // by michael
    newTextViewFrame.origin.y = keyboardRect.origin.y - self.frame.size.height;
    self.frame = newTextViewFrame;
}
- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.superview convertRect:keyboardRect fromView:nil];
    
    // 根据老的 frame 设定新的 frame
    newTextViewFrame = self.frame; // by michael
    newTextViewFrame.origin.y = keyboardRect.origin.y - self.frame.size.height;
    
    // 键盘的动画时间，设定与其完全保持一致
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // 键盘的动画是变速的，设定与其完全保持一致
    NSValue *animationCurveObject = [userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSUInteger animationCurve;
    [animationCurveObject getValue:&animationCurve];
    
    // 开始及执行动画
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    self.frame = newTextViewFrame;
    [UIView commitAnimations];
}
//键盘消失时的处理，文本输入框回到页面底部。
- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    
    // 键盘的动画时间，设定与其完全保持一致
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // 键盘的动画是变速的，设定与其完全保持一致
    NSValue *animationCurveObject =[userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSUInteger animationCurve;
    [animationCurveObject getValue:&animationCurve];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    newTextViewFrame = self.frame;
    newTextViewFrame.origin.y = SCREEN_HEIGHT - self.frame.size.height;
    self.frame = newTextViewFrame;
    [UIView commitAnimations];
}
@end
