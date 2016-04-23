//
//  HJInputToolBar.h
//  YiGong
//
//  Created by 黄靖 on 16/4/16.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJInputToolBar : UIToolbar<UITextViewDelegate>
/** 输入框*/
@property(nonatomic, strong) UITextView *textView;
/** 展位文本*/
@property(nonatomic, strong) UILabel *placeholderLabel;
/** 占位文字*/
@property(nonatomic, copy) NSString *placeText;
/** 提交评论*/
@property (nonatomic, copy) void (^commitCommentBlock)(NSString *);

- (instancetype)initWithCommitAction:(void(^)(NSString *content))commit;
@end
