//
//  HJHealthCareTableViewCell.m
//  YiGong
//
//  Created by 黄靖 on 16/4/8.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJHealthCareTableViewCell.h"

@implementation HJHealthCareTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.frame = CGRectMake(15, 20, 100, 20);
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = HJRGBA(100, 100, 100, 1.0);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
        
    }
    return _titleLabel;
}

- (UITextField *)textF{
    if (!_textF) {
        _textF = [[UITextField alloc]init];
        _textF.frame = CGRectMake(115, 15, SCREEN_WIDTH - 145, 30);
        _textF.placeholder = @"添加新纪录";
        _textF.delegate = self;
        _textF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [_textF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        _textF.textAlignment = NSTextAlignmentRight;
        [self addSubview:_textF];
    }
    return _textF;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidChanged:(UITextField *)textField{
    self.getCurrentValueBlock(self);
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.getCurrentCellBlock(self);
}
@end
