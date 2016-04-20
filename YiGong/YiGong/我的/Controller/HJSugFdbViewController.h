//
//  HJSugFdbViewController.h
//  AINursing
//
//  Created by 黄靖 on 16/3/9.
//  Copyright © 2016年 黄靖. All rights reserved.
//

#import "HJRootViewController.h"

@interface HJSugFdbViewController : HJRootViewController<UITextViewDelegate>
/** 提交地址*/
@property(nonatomic,copy)NSString *commitUrl;
/** 提示信息*/
@property(nonatomic,copy)NSString *placeHolderText;
/** 文本框信息*/
@property(nonatomic,copy)NSString *textViewText;
@end
