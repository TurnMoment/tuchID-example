//
//  DZTouchID.h
//  touchID
//
//  Created by daozhang on 16/6/4.
//  Copyright © 2016年 ksfc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

//模拟器
#if TARGET_IPHONE_SIMULATOR

#define DZNotice(Chinese,English)  [[[[NSUserDefaults standardUserDefaults]objectForKey:@"AppleLanguages"] objectAtIndex:0] isEqualToString:@"zh-Hans-CN"]?Chinese : English

#elif TARGET_OS_IPHONE

#define DZNotice(Chinese,English)  [[[[NSUserDefaults standardUserDefaults]objectForKey:@"AppleLanguages"] objectAtIndex:0] isEqualToString:@"zh-Hans-CN"]?Chinese : English


#endif

@class DZTouchID;

@protocol DZTouchIDDelegate <NSObject>

@required

/**
* TouchID验证成功
* (English Comments)Authentication Success
*/
- (void)DZTouchIDAuthorizeSuccess;

/**
*< Touch ID 验证失败
* (Enlish Comments)Authentication Failure
*/
- (void)DZTouchIDAuthorizeFailure;

@optional

/**
* 取消TouchID验证(用户点击了取消)
* (Enlish Comments)Authentication was canceled by user(e.g touch cancel Button).
*/
- (void)DZTouchIDAuthorizeErrorUserCancel;

/**
* 在TouchID中点击输入密码按钮
* (English Comments) User tapped the fallbackbutton
*/
- (void)DZTouchIDAuthorizeErrorUserFallback;

/**
* 在验证touchID的过程中被系统取消 例如突然来电话,按了Home键、锁屏....
* (English Comments) Authentication was canceled by system (e.g another application went go foregroung)
*/
- (void)DZTouchIDAuthorizeErrorSystemCanncel;

/**
* 无法启用TouchID,设备没有设置密码
* (English Comments) Authentication could not start,because is not set on device;
*/
- (void)DZTouchIDAuthorizeErrorPasscodeNotSet;

/**
* 设备没有设置指纹密码
* (Enlish Comments) Authentication could not start,because touchID has no enrolled fingers
*/
- (void)DZTouchIDAuthorizeErrorTouchIDNotEnrolled;

/**
* 该设备的TouchID无效
* (English Comments) Authentication could not start,because touchID has no available on the device
*/
- (void)DZTouchIDAuthorizeErrorTouchIDNotAvailable;

/**
* 多次使用TouchID失败，Touch ID 被锁,需要用户输入密码解锁
* (Enlish Comments)Authentication Was not successful,because there were too many failed TouchID attempt and TouchID now locked,passcode Is required to unlock TouchID,e.g.evaluating LAPolicyDeviceOwerAuthenticationWithBiometrics will ask for passcode was a prerequisite
*/
- (void)DZTouchIDAuthorizeErrorTouchIDLockOut;

/**
 * 当前应用被挂起取消了授权(如突然来电话，应用进入后台)
 * (Enlish Comments)Authentication was cancel by application(e.g invalidate was called while authentication was inprogress)
 */
- (void)DZTouchIDAuthorizeErrorTouchIDAPPCancel;

/**
* 当前软件被取消了授权(授权过程中,LACOntext 被取消)
* (Elish Comments)LAContext passed to this call has been previously invalidated
*/
- (void)DZTouchIDAuthorizeErrorInvalidContext;

/**
* 当前设备不支持指纹识别
* (Elish Comments)The current device does not support fingerprint identification
*/
- (void)DZTouchIDIsNotSupport;


@end

@interface DZTouchID : LAContext

@property (nonatomic,weak)id<DZTouchIDDelegate>delegate;

/*
*< 发起TouchID 验证(Initate TouchID validation) 
* @param message 提示框要显示的信息 默认为:输入秘密(Fallback Button title,defaults is "Enter passWord")
*/
- (void)startDZTouchIDWithMessage:(NSString *)message fallBackTitle:(NSString*)fallBackTitle delegate:(id<DZTouchIDDelegate>)delegate;



@end
