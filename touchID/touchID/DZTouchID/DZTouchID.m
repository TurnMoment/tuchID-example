//
//  DZTouchID.m
//  touchID
//
//  Created by daozhang on 16/6/4.
//  Copyright © 2016年 ksfc. All rights reserved.
//

#import "DZTouchID.h"


@implementation DZTouchID

- (void)startDZTouchIDWithMessage:(NSString *)message fallBackTitle:(NSString*)fallBackTitle delegate:(id<DZTouchIDDelegate>)delegate
{

    LAContext *context = [[LAContext alloc]init];
    context.localizedFallbackTitle = fallBackTitle;
    
    NSError *error = nil;
    self.delegate = delegate;
    
    NSAssert(self.delegate != nil, DZNotice(@"TouchIDDelegate 不能为空", @"TouchIDDelegate must be non-nil"));
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:message == nil?DZNotice(@"默认提示信息", @"The Default Message"):message reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success)
            {
                if ([self.delegate respondsToSelector:@selector(DZTouchIDAuthorizeSuccess)]) {
                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                        [self.delegate DZTouchIDAuthorizeSuccess];
                    }];
                }
            }else if (error)
            {
            
                switch (error.code) {
                    case LAErrorAuthenticationFailed:
                        if ([self.delegate respondsToSelector:@selector(DZTouchIDAuthorizeFailure)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate DZTouchIDAuthorizeFailure];
                            }];
                        }
                        break;
                        case LAErrorUserCancel:
                        if ([self.delegate respondsToSelector:@selector(DZTouchIDAuthorizeErrorUserCancel)]) {
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate DZTouchIDAuthorizeErrorUserCancel];
                            }];
                        }
                        break;
                        case LAErrorUserFallback:
                        if ([self.delegate respondsToSelector:@selector(DZTouchIDAuthorizeErrorUserFallback)]) {
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate DZTouchIDAuthorizeErrorUserFallback];
                            }];
                        }
                        break;
                        case LAErrorSystemCancel:
                        if ([self.delegate respondsToSelector:@selector(DZTouchIDAuthorizeErrorSystemCanncel)]) {
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate DZTouchIDAuthorizeErrorSystemCanncel];
                            }];
                        }
                        break;
                        case LAErrorTouchIDNotEnrolled:
                        if ([self.delegate respondsToSelector:@selector(DZTouchIDAuthorizeErrorTouchIDNotEnrolled)]) {
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate DZTouchIDAuthorizeErrorTouchIDNotEnrolled];
                            }];
                        }
                        break;
                        case LAErrorPasscodeNotSet:
                        if ([self.delegate respondsToSelector:@selector(DZTouchIDAuthorizeErrorPasscodeNotSet)]) {
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate DZTouchIDAuthorizeErrorPasscodeNotSet];
                            }];
                        }
                        break;
                        case LAErrorTouchIDNotAvailable:
                        if ([self.delegate respondsToSelector:@selector(DZTouchIDAuthorizeErrorTouchIDNotAvailable)]) {
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate DZTouchIDAuthorizeErrorTouchIDNotAvailable];
                            }];
                        }
                        break;
                        case LAErrorTouchIDLockout:
                        if ([self.delegate respondsToSelector:@selector(DZTouchIDAuthorizeErrorTouchIDLockOut)]) {
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate DZTouchIDAuthorizeErrorTouchIDLockOut];
                            }];
                        }
                        break;
                        case LAErrorAppCancel:
                        if ([self.delegate respondsToSelector:@selector(DZTouchIDAuthorizeErrorTouchIDAPPCancel)]) {
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate DZTouchIDAuthorizeErrorTouchIDAPPCancel];
                            }];
                        }
                        break;
                        case LAErrorInvalidContext:
                        if ([self.delegate respondsToSelector:@selector(DZTouchIDAuthorizeErrorInvalidContext)]) {
                            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                                [self.delegate DZTouchIDAuthorizeErrorInvalidContext];
                            }];
                        }
                    default:
                        break;
                }
                
            }
            
        }];
        
    }else
    {
        if ([self.delegate respondsToSelector:@selector(DZTouchIDIsNotSupport)]) {
            [self.delegate DZTouchIDIsNotSupport];
        }
    }
    
}


@end
