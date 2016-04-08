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

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.reduceBtn];
        [self addSubview:self.textF];
        [self addSubview:self.addBtn];
    }
    return self;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.frame = CGRectMake(15, 20, SCREEN_WIDTH/2, 20);
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = HJRGBA(170, 170, 170, 1.0);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
        
    }
    return _titleLabel;
}
- (UIButton *)reduceBtn{
    if (!_reduceBtn) {
        _reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _reduceBtn.frame = CGRectMake(SCREEN_WIDTH - 180, 0, 60, 60);
        [_reduceBtn setBackgroundImage:[UIImage imageNamed:@"subScore"] forState:UIControlStateNormal];
    }
    return _reduceBtn;
}

- (UITextField *)textF{
    if (!_textF) {
        
        _textF = [[UITextField alloc]init];
        _textF.frame = CGRectMake(SCREEN_WIDTH - 120, 15, 60, 30);
        _textF.keyboardType = UIKeyboardTypeNumberPad;
        _textF.textAlignment = NSTextAlignmentRight;
        _textF.delegate = self;
        
    }
    return _textF;
}

- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 0, 60, 60);
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"addScore"] forState:UIControlStateNormal];
    }
    return _addBtn;
}

#pragma mark --------------UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (self.completeEditingBlock) self.completeEditingBlock(self);
   
    return YES;
}
@end
