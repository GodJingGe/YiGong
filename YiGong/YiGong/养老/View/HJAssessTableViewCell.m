//
//  HJAssessTableViewCell.m
//  YiGong
//
//  Created by 黄靖 on 16/4/8.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJAssessTableViewCell.h"

@implementation HJAssessTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.contentTextView];
        [self addSubview:self.scoreTF];
    }
    return self;
    
}
- (UITextField *)scoreTF{
    if (!_scoreTF) {
        
        CGFloat y = self.contentTextView.frame.size.height + self.contentTextView.frame.origin.y;
        
        _scoreTF = [[UITextField alloc] initWithFrame:CGRectMake(15, y, SCREEN_WIDTH-30 , 40)];
        _scoreTF.placeholder = @"请输入成绩";
        _scoreTF.font = [UIFont systemFontOfSize:17];
        _scoreTF.textColor = [UIColor cyanColor];
        _scoreTF.layer.cornerRadius = 5;
        _scoreTF.textAlignment = NSTextAlignmentCenter;
        _scoreTF.keyboardType = UIKeyboardTypeNumberPad;
        [_scoreTF addTarget:self action:@selector(textFielddidChanged:) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:_scoreTF];
    }
    return _scoreTF;
}

- (UITextView *)contentTextView{
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc]init];
        [_contentTextView setEditable:YES];
        _contentTextView.delegate = self;
        _contentTextView.textColor = HJRGBA(70, 70, 70, 1.0);
        _contentTextView.textAlignment = NSTextAlignmentCenter;
        _contentTextView.frame = CGRectMake(10, 0, SCREEN_WIDTH - 20, 30);
        _contentTextView.font = [UIFont systemFontOfSize:20];
    }
    return _contentTextView;
}

- (void)setModel:(HJAssessModel *)model{
    _model = model;
    self.contentTextView.text = model.content;
    self.contentTextView.editable = NO;
    CGRect rect = self.contentTextView.frame;
    rect.size.height = self.contentTextView.contentSize.height + 10;
    self.contentTextView.frame = rect;
    
    CGRect scoreRect = self.scoreTF.frame ;
    scoreRect.origin.y = rect.origin.y + rect.size.height + 10;
    self.scoreTF.frame = scoreRect;
    self.scoreTF.placeholder = [NSString stringWithFormat:@"最高成绩%@分,请不要超出",model.score];
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, scoreRect.origin.y + scoreRect.size.height);
}

#pragma mark --------------UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}

#pragma mark --------------UITextFieldDelegate
- (void)textFielddidChanged:(UITextField *)textField{
    NSString * score = textField.text;
    self.model.currentScore = @([score intValue]);
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (self.hiddenKeyBoardBlock) self.hiddenKeyBoardBlock(self);
   
    return YES;
}
@end
