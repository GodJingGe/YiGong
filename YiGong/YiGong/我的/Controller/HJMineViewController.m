//
//  HJMineViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/3/25.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJMineViewController.h"
#import "HJPersonalCenterView.h"
#import "HJMineTableViewCell.h"
#import "HJTeamCertificationViewController.h"
#import "HJSugFdbViewController.h"
#import "HJPersonalInfoViewController.h"
#import "HJPersonalModel.h"
#import "HJPubActivityViewController.h"
#import "HJLoginViewController.h"
#define USERINFO_URL @"uinfo"

@interface HJMineViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 图片*/
@property(nonatomic, strong) HJPersonalCenterView *centerView;
/** UITableView*/
@property(nonatomic, strong) UITableView *tableV;
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
/** 缓存cell*/
@property(nonatomic, strong) HJMineTableViewCell *currentCell;
/** 个人信息*/
@property(nonatomic, strong) HJPersonalModel *userInfo;
@end

@implementation HJMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createValue];
    [self createUI];
}

- (void)createValue{
    _dataSource = [NSMutableArray array];
    NSArray * titles = @[@"认证公益团队",@"意见反馈",@"清除缓存"];
    [_dataSource addObjectsFromArray:titles];
    [self loadData];
}

- (void)createUI{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Sign_out"] style:UIBarButtonItemStyleDone target:self action:@selector(quitAction)];
    
    __weak typeof(self) weakSelf = self;
    
    CGRect rect = CGRectMake(0, 206, SCREEN_WIDTH, SCREEN_HEIGHT-270);
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.rowHeight = 60;
    [self.view addSubview:self.tableV];
    
    _centerView = [[HJPersonalCenterView alloc]init];
    _centerView.frame = CGRectMake(0, -64, SCREEN_WIDTH, _centerView.frame.size.height);
    
    // 跳转block回调
    
    [_centerView setPushToPersonalInfoVCBlock:^{
        HJPersonalInfoViewController * personalVC = [[HJPersonalInfoViewController alloc]init];
        personalVC.title = @"修改个人资料";
        personalVC.model = weakSelf.userInfo;
        [weakSelf.navigationController pushViewController:personalVC animated:YES];
    }];
    
    [_centerView setPushToNextVCBlock:^(NSInteger tag) {
        switch (tag) {
            case 10:
                HJLog(@"跳到活动");
                break;
            case 11:
                HJLog(@"跳到捐赠");
                break;
            case 12:
                HJLog(@"跳到组织");
                break;
        }
    }];
    [self reloadCenterView];
#warning TODO //赋值
    [self.view addSubview:_centerView];
    
}
- (void)reloadCenterView{
    
    _centerView.followView.detailLabel.text = self.userInfo.activity;
    _centerView.releatedTopicView.detailLabel.text = self.userInfo.donation;
    _centerView.registerView.detailLabel.text = self.userInfo.attend;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:COMMON_IMAGE_URL,self.userInfo.avatar]];
    [_centerView.logoView.teamIconImageV sd_setImageWithURL:url];
}

- (void)loadData{
    HJRequestTool * tool = [[HJRequestTool alloc]init];
    NSString * url = [NSString stringWithFormat:COMMON_URL,USERINFO_URL];
    NSDictionary * dic = [NSDictionary dictionaryWithObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"userid"];
    [tool postJSONWithUrl:url parameters:dic success:^(id responseObject) {
        NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        self.userInfo = [HJPersonalModel mj_objectWithKeyValues:jsonData[@"pd"]];
        [self reloadCenterView];
    } fail:^(NSError *error) {
        [self loadData];
    }];
}

#pragma mark --------------UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJMineTableViewCell";
    HJMineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[HJMineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    
    cell.titleLabel.text = _dataSource[indexPath.row];
    if (indexPath.row == 2) {
        //            cell.detailLabel.text = [NSString stringWithFormat:@"%.2fM",[self folderSizeAtPath:NSHomeDirectory()]];
        cell.detailLabel.text = [NSString stringWithFormat:@"%.2fM",[self filePath]];
        _currentCell = cell;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0)  return 0.0001f;
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            HJTeamCertificationViewController * cerVC = [[HJTeamCertificationViewController alloc]init];
            HJPubActivityViewController * pubActVC = [[HJPubActivityViewController alloc]init];
            pubActVC.title = @"发布公益活动";
            cerVC.title = @"认证公益团体";
            [self.navigationController pushViewController:pubActVC animated:YES];
        }
            
            break;

        case 1:{
            HJSugFdbViewController * sugFdbVC = [[HJSugFdbViewController alloc]init];
            sugFdbVC.title = @"意见反馈";
            [self.navigationController pushViewController:sugFdbVC animated:YES];
        }
            
            break;
            
        case 2:
        {
            [self clearFile];
            HJLog(@"清除缓存");
        }
            break;
    }
}

#pragma mark --------------clearCaches
//1:首先我们计算一下 单个文件的大小

- ( long long ) fileSizeAtPath:( NSString *) filePath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if ([manager fileExistsAtPath :filePath]){
        
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
        
    }
    
    return 0 ;
    
}

//2: 遍历文件夹获得文件夹大小，返回多少 M（提示：你可以在工程界设置（)m）

- ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    
    NSString * fileName;
    
    long long folderSize = 0 ;
    
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
        
    }
    
    return folderSize/( 1024.0 * 1024.0 );
    
}

// 显示缓存大小

- ( float )filePath

{
    
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    return [ self folderSizeAtPath :cachPath];
}

// 清理缓存

- ( void )clearFile

{
    
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    
    NSLog ( @"cachpath = %@" , cachPath);
    
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
            
        }
        
    }
    
    [ self performSelectorOnMainThread : @selector (clearCachSuccess) withObject :nil waitUntilDone : YES ];
    
}

- ( void )clearCachSuccess

{
    
    NSLog ( @" 清理成功 " );
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"清除缓存成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:okAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
    [ _tableV reloadData ];//清理完之后重新导入数据
    
}

#pragma mark --------------ClickAction
- (void)quitAction{
    HJLoginViewController * loginVC = [[HJLoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableV reloadData];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self setNavigationBarStyleClear];
}

@end
