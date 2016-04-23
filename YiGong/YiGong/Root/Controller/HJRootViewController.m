//
//  HJRootViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/3/25.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJRootViewController.h"
#import "HJLoginViewController.h"

@interface HJRootViewController ()
/** 上一张截图*/
@property(nonatomic, strong) UIImage *lastImage;
@end

@implementation HJRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgView];
    [self viewConfig];
    [self createNavigationAbount];
}
- (HJBackgroundView *)bgView{
    if (!_bgView) {
        _bgView = [[HJBackgroundView alloc]init];
    }
    return _bgView;
}
- (void)viewConfig{
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置状态栏颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)createNavigationAbount{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //    self.navigationController.navigationBar.barTintColor = HJRGBA(248,97,111,1.0);
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:HJRGBA(248,97,111,1.0)] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:20],NSFontAttributeName,nil]];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title =@"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

// 纯文本提示框
- (void)showHudWithText:(NSString *)text{
    MBProgressHUD * hud = [[MBProgressHUD alloc]init];
    hud.labelText = text;
    hud.mode = MBProgressHUDModeText;
    [self.view addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:1];
}

- (void)showLoadingHudWithTitle:(NSString *)text OnView:(UIView *)view{
    self.hud = [[MBProgressHUD alloc]init];
    self.hud.labelText = text;
    [view addSubview:self.hud];
    [self.hud show:YES];
}

- (void)showHudWithText:(NSString *)text Time:(NSInteger)time OnView:(UIView *)view{
    self.hud = [[MBProgressHUD alloc]init];
    self.hud.mode = MBProgressHUDModeText;
    self.hud.labelText = text;
    [view addSubview:self.hud];
    [self.hud hide:YES afterDelay:time];
}

#pragma mark -=====自定义截屏位置大小的逻辑代码=====-

-(UIImage *)ScreenShot{
    //这里因为我需要全屏接图所以直接改了，宏定义iPadWithd为1024，iPadHeight为768，
    //    UIGraphicsBeginImageContextWithOptions(CGSizeMake(640, 960), YES, 0);     //设置截屏大小
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT), YES, 0);     //设置截屏大小
    [[self.navigationController.view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef imageRef = viewImage.CGImage;
    CGRect rect;
    if (SCREEN_WIDTH > 375) {
        rect = CGRectMake(0, 0, SCREEN_WIDTH * 3, SCREEN_HEIGHT * 3);
    }else{
        rect = CGRectMake(0, 0, SCREEN_WIDTH*2, SCREEN_HEIGHT*2);//这里可以设置想要截图的区域
    }
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    if (!_lastImage) {
        _lastImage = sendImage;
    }
    return sendImage;
    
    
    //    UIImageWriteToSavedPhotosAlbum(sendImage, nil, nil, nil);//保存图片到照片库
    //    NSData *imageViewData = UIImagePNGRepresentation(sendImage);
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *documentsDirectory = [paths objectAtIndex:0];
    //    NSString *pictureName= [NSString stringWithFormat:@"screenShow_%d.png",ScreenshotIndex];
    //    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:pictureName];
    //    NSLog(@"截屏路径打印: %@", savedImagePath);
    //这里我将路径设置为一个全局String，这里做的不好，我自己是为了用而已，希望大家别这么写
    //    [self SetPickPath:savedImagePath];
    
    //    [imageViewData writeToFile:savedImagePath atomically:YES];//保存照片到沙盒目录
    //    CGImageRelease(imageRefRect);
    //    ScreenshotIndex++;
}

// 设置导航栏透明
- (void)setNavigationBarStyleClear{
    
    UIColor * color = [UIColor clearColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    self.navigationController.navigationBar.translucent = YES;
    
}

// 设置导航栏正常
- (void)setNavigationBarStyleNormal{
    
    UIColor * color = HJRGBA(248, 97, 111, 1.0);
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    
}

- (BOOL)isLogin{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"userid"]) {
        return YES;
    }
    [self createAlertControllerWithTitle:@"您还没有登录，是否立即前往？"];
    return NO;
}

- (void)createAlertControllerWithTitle:(NSString *)title{
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"立刻前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        HJLoginViewController * loginVC = [[HJLoginViewController alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"稍后再说" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:cancel];
    [alertVC addAction:ok];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:NO];
//    [self ScreenShot];
//    self.bgView.bgImageView.image = _lastImage;
//    [self setNavigationBarStyleClear];
//}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.bgView.bgImageView.image = [UIImage new];
//}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:NO];
    self.bgView.bgImageView.image = self.lastImage;
    [self setNavigationBarStyleNormal];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:NO];
    [self ScreenShot];
    self.bgView.bgImageView.image = _lastImage;
    [self setNavigationBarStyleClear];
    
}
@end
