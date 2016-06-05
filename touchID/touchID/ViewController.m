//
//  ViewController.m
//  touchID
//
//  Created by daozhang on 16/6/4.
//  Copyright © 2016年 ksfc. All rights reserved.
//

#import "ViewController.h"
#import "DZTouchID/DZTouchID.h"

@interface ViewController ()<DZTouchIDDelegate>

@property (strong, nonatomic) IBOutlet UILabel *Notice;
@property (nonatomic,strong)DZTouchID *touchID;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.touchID  = [[DZTouchID alloc]init];
    
}



- (IBAction)startDZTouchID {
    
    [self.touchID startDZTouchIDWithMessage:DZNotice(@"自定义信息", @"The Custom Message") fallBackTitle:DZNotice(@"按钮标题", @"Fallback Title") delegate:self];
}

- (void)DZTouchIDAuthorizeSuccess
{
    self.Notice.text = DZNotice(@"TouchID 验证成功", @"Authorize Success");
}

- (void)DZTouchIDAuthorizeFailure
{
    self.Notice.text = DZNotice(@"TouchID 验证失败", @"Authorize Failure");
}

- (void)DZTouchIDAuthorizeErrorUserCancel
{
    self.Notice.text = DZNotice(@"TouchID 验证(用户点击了取消)", @"Authorize Error user canel");
}

- (void)DZTouchIDAuthorizeErrorUserFallback
{
    self.Notice.text = DZNotice(@"Touch 对话框按钮中点击输入密码按钮", @"Authorize Error user FallBack");
}

- (void)DZTouchIDAuthorizeErrorSystemCanncel
{
    self.Notice.text = DZNotice(@"在验证TouchID的过程中被系统取消", @"Authorize Error System Cancel");
}

- (void)DZTouchIDAuthorizeErrorPasscodeNotSet
{
    self.Notice.text = DZNotice(@"无法取用touchID,设备没有设置密码", @"Authorize Error passCode Not set ");

}

- (void)DZTouchIDAuthorizeErrorTouchIDNotEnrolled
{
    self.Notice.text = DZNotice(@"设备没有录入TouchID,无法取用touchID", @"Athorize Error TouchID Not Enrolled");
}

- (void)DZTouchIDAuthorizeErrorTouchIDNotAvailable
{
    self.Notice.text = DZNotice(@"设备的TouchID无效", @"Anthorize Error TouchID Not Available");
}

- (void)DZTouchIDAuthorizeErrorTouchIDLockOut
{
    self.Notice.text = DZNotice(@"多次连续的TouchID失败，touch密码解锁", @"Authorize LAError TouchID Lockout");
}

- (void)DZTouchIDAuthorizeErrorTouchIDAPPCancel
{
    self.Notice.text = DZNotice(@"当前软件取消了授权", @"Authorize LAError AppCandel");
}


- (void)DZTouchIDAuthorizeErrorInvalidContext
{
    self.Notice.text = DZNotice(@"当前软件被挂起,取消了授权", @"Authorize LAError Invalid context");
}


- (void)DZTouchIDIsNotSupport
{
    self.Notice.text = DZNotice(@"当前设备不支持指纹识别", @"The Current Device Does Not  Support");
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
