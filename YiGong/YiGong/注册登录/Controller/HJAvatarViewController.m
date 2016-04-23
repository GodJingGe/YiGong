//
//  HJAvatarViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/13.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJAvatarViewController.h"
#define REGISTER_URL @"uadd"

@interface HJAvatarViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/** 头像*/
@property(nonatomic, strong) UIImageView *avatarImageView;
/** 提示*/
@property(nonatomic, strong) UIButton *alertBtn;
/** 完成注册*/
@property(nonatomic, strong) UIButton *completeBtn;
@end

@implementation HJAvatarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
- (void)createUI{
    _avatarImageView = [[UIImageView alloc]init];
    _avatarImageView.frame = CGRectMake((SCREEN_WIDTH - 110)/2, 140, 110, 110);
    _avatarImageView.image = [UIImage imageNamed:@"headp-80x80_01"];
    _avatarImageView.layer.cornerRadius = 55;
    _avatarImageView.clipsToBounds = YES;
    _avatarImageView.userInteractionEnabled = YES;
    [self.view addSubview:_avatarImageView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseImageFromImagePickerController)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.avatarImageView addGestureRecognizer:tap];
    
    _alertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _alertBtn.frame = CGRectMake((SCREEN_WIDTH - 110)/2, 280, 110, 25);
    _alertBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [_alertBtn setTitleColor:HJRGBA(204, 204, 204, 1.0) forState:UIControlStateNormal];
    [_alertBtn addTarget:self action:@selector(chooseImageFromImagePickerController) forControlEvents:UIControlEventTouchUpInside];
    [_alertBtn setTitle:@"请上传头像" forState:UIControlStateNormal];
    [self.view addSubview:_alertBtn];
    
    _completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _completeBtn.frame = CGRectMake(15,SCREEN_HEIGHT - 89 -64, SCREEN_WIDTH - 30, 40);
    [_completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_completeBtn setBackgroundImage:[UIImage imageWithColor:THEME_COLOR] forState:UIControlStateNormal];
    [_completeBtn addTarget:self action:@selector(completeAction) forControlEvents:UIControlEventTouchUpInside];
    _completeBtn.layer.cornerRadius = 5;
    _completeBtn.clipsToBounds = YES;
    [_completeBtn setTitle:@"完成注册" forState:UIControlStateNormal];
    [self.view addSubview:_completeBtn];
}

#pragma mark --------------ClickAction

- (void)completeAction{
    
    HJRequestTool * tool = [[HJRequestTool alloc]init];
    NSString * url = [NSString stringWithFormat:COMMON_URL,REGISTER_URL];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:self.model.nickName forKey:@"username"];
    [dic setObject:self.model.phoneNum forKey:@"tel"];
    [dic setObject:self.model.password forKey:@"pwd"];
    if (self.model.avatar) {
        NSData * data = UIImageJPEGRepresentation(self.model.avatar, 0.1);
        [dic setObject:data forKey:@"file0"];
    }
   
    [tool postFileWithUrl:url file:[NSMutableArray arrayWithObject:self.model.avatar] parameters:dic success:^(id responseObject) {
        NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([jsonData[@"result"] isEqualToString:@"01"]) {
            [self showHudWithText:@"注册成功"];
            [[NSUserDefaults standardUserDefaults] setObject:jsonData[@"pd"][@"userid"] forKey:@"userid"];
            NSInteger count = self.navigationController.childViewControllers.count - 5;
            [self.navigationController popToViewController:self.navigationController.childViewControllers[count] animated:NO];
        }else{
            [self showHudWithText:jsonData[@"info"]];
        }
        
        HJLog(@"%@",jsonData);
    } fail:^(NSError *error) {
        
    }];
    
    HJLog(@"完成注册");
}

//设置头像
- (void)chooseImageFromImagePickerController{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    
    UIAlertAction * chooseAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:nil];
    }];
    
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
        
    }];
    
    [alertVC addAction:cancelAction];
    [alertVC addAction:chooseAction];
    [alertVC addAction:cameraAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    self.avatarImageView.image = image;
    self.model.avatar = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
