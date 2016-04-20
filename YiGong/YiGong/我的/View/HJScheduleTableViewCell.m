//
//  HJScheduleTableViewCell.m
//  YiGong
//
//  Created by 黄靖 on 16/4/19.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJScheduleTableViewCell.h"

@implementation HJScheduleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.dateBtn];
        [self addSubview:self.textF];
    }
    return self;
}

- (UIButton *)dateBtn{
    if (!_dateBtn) {
        _dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _dateBtn.frame = CGRectMake(15, 0, SCREEN_WIDTH/3 - 15, 60);
        _dateBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_dateBtn setTitle:@"日程时间" forState:UIControlStateNormal];
        _dateBtn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
        [_dateBtn setTitleColor:HJRGBA(70, 70, 70, 1.0) forState:UIControlStateNormal];
        [_dateBtn addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dateBtn;
}
- (UITextField *)textF{
    if (!_textF) {
        _textF = [[UITextField alloc]init];
        _textF.frame = CGRectMake(130, 15, SCREEN_WIDTH - 145, 30);
        _textF.placeholder = @"请输入日程内容";
        _textF.textColor = HJRGBA(205, 205, 205, 1.0);
        _textF.delegate = self;
        [_textF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        _textF.textAlignment = NSTextAlignmentRight;
        [self addSubview:_textF];
    }
    return _textF;
}

- (void)setModel:(HJScheduleModel *)model{
    _model = model;
}
#pragma mark --------------UITextFieldDelegate
- (void)chooseDate:(UIButton *)button {
    self.pickerDateBlock();
}

#pragma mark --------------ClickAction
-(void)textFieldDidChanged:(UITextField *)textField{
    _model.content = textField.text;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.getCurrentCell(self);
    return YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
