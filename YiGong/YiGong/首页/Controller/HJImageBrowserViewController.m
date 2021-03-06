//
//  HJImageBrowserViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/15.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJImageBrowserViewController.h"
#import "HJImageScrollView.h"
#import "Macro.h"
#define IMAGE_HEIHT SCREEN_WIDTH * image.size.height/image.size.width

@interface HJImageBrowserViewController ()<UIScrollViewDelegate>
/** scrollView*/
@property(nonatomic,strong)HJImageScrollView * scrollView;

@end

@implementation HJImageBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self createNavigationItem];
}

- (void)createUI{
    self.title = [NSString stringWithFormat:@"%d/%d",_currentOffset ,(int)_images.count ];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor blackColor];
    
    _scrollView = [[HJImageScrollView alloc]init];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake((SCREEN_WIDTH + 20) * _images.count, SCREEN_HEIGHT - 64);
    _scrollView.contentOffset = CGPointMake((_currentOffset - 1) * (SCREEN_WIDTH + 20), 0);
    [self.view addSubview:_scrollView];
    
    [self createImageForScrollView];
}

// 创建导航栏条目
- (void)createNavigationItem{
    
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(popToLastView)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteImageDataSource)];
    
}
// 返回上一页
- (void)popToLastView{
    [self.navigationController popViewControllerAnimated:YES];
}
// 删除图片
- (void)deleteImageDataSource{
    
    [_images removeObjectAtIndex:MAX(0, --_currentOffset)];
    
    if (_currentOffset == 0) _currentOffset ++;
    
    [self createUI];
    
    if (_images.count == 1) [self popToLastView];
}
// 为SCrollView添加图片
- (void)createImageForScrollView{
    
    for (int i = 0; i < _images.count; i ++) {
        UIImageView * imageView = [[UIImageView alloc]init];
        UIImage * image = _images[i];
        imageView.frame = CGRectMake((SCREEN_WIDTH + 20) * i, (_scrollView.frame.size.height - IMAGE_HEIHT)/2, SCREEN_WIDTH, IMAGE_HEIHT);
        imageView.image = image;
        [self.scrollView addSubview:imageView];
    }
}

#pragma mark --------------UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _currentOffset = scrollView.contentOffset.x/SCREEN_WIDTH + 1;
    self.title = [NSString stringWithFormat:@"%d/%d",_currentOffset ,(int)_images.count];
}

#pragma mark --------------ViewLifeCycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidAppear:(BOOL)animated{
    
}
@end
