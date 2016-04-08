//
//  HJTakePartInTableViewCell.m
//  YiGong
//
//  Created by 黄靖 on 16/4/5.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJTakePartInTableViewCell.h"

@implementation HJTakePartInTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.indexPath.row != 4) {
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    }
    return self;
}

- (void)createIdentifyCode{
    _phoneNumTF = [[UITextField alloc]init];
    _phoneNumTF.frame = CGRectMake(self.titleLabel.frame.size.width + 30, 15, SCREEN_WIDTH/2, 30);
    _phoneNumTF.textColor = HJRGBA(170, 170, 170, 1.0);
    _phoneNumTF.delegate = self;
    [_phoneNumTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    _phoneNumTF.font = [UIFont systemFontOfSize:14];
    [self addSubview:_phoneNumTF];
    
    _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _getCodeBtn.frame = CGRectMake(SCREEN_WIDTH - 110, 18, 95, 26);
    [_getCodeBtn setBackgroundColor:HJRGBA(248, 97, 111, 1.0)];
    [_getCodeBtn setTitleColor:HJRGBA(170, 170, 170, 1.0) forState:UIControlStateSelected];
    [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getCodeBtn setTitle:@"已发送" forState:UIControlStateSelected];
    _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_getCodeBtn addTarget:self action:@selector(getCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    _getCodeBtn.layer.cornerRadius = _getCodeBtn.frame.size.height/2;
    [self addSubview:_getCodeBtn];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.frame = CGRectMake(15, 20, SCREEN_WIDTH / 3, 20);
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = HJRGBA(100, 100, 100, 1.0);
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.frame = CGRectMake(SCREEN_WIDTH / 3, 20, SCREEN_WIDTH * 2 / 3 - 30 , 20);
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textColor = HJRGBA(170, 170, 170, 1.0);
        _detailLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_detailLabel];
    }
    return _detailLabel;
}

- (void)setModel:(HJTakePartInModel *)model{
    _model = model;
    
    self.titleLabel.text = model.title;
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(15, 20, self.titleLabel.frame.size.width, 20);
    
    if (self.indexPath.row != 4) {
        self.detailLabel.text = model.detail;
    }else{
        [self createIdentifyCode];
    }
    
}

#pragma mark --------------ClickAction
- (void)getCodeAction:(UIButton *)button{
    [_getCodeBtn setBackgroundColor:HJRGBA(233, 233, 233, 1.0)];
    [_getCodeBtn setSelected:YES];
    HJLog(@"获取验证码");
}

#pragma mark --------------UITextFieldDelegate
- (void)textFieldDidChanged:(id)sender{
    UITextField * textField = sender;
    HJLog(@"%@",textField.text);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_phoneNumTF resignFirstResponder];
    return YES;
}

@end
