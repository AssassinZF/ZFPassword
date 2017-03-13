//
//  PasswordCheckController.m
//  ZFPassword
//
//  Created by LZF on 2017/3/13.
//  Copyright © 2017年 zf.com. All rights reserved.
//

#import "PasswordCheckController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "BasicNavigationController.h"
#import "ViewController.h"
#import "AppDelegate.h"
@interface PasswordCheckController ()

@property (nonatomic , strong) LAContext *context;

@end

@implementation PasswordCheckController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self checkTouchIDPassword];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _context =[LAContext new];
    _context.localizedCancelTitle = @"取消";
    
}

-(void)checkTouchIDPassword{
    NSError *error = nil;
    if ([_context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                             error:&error]) {
        NSLog(@"支持指纹识别");
        [_context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:@"指纹解锁" reply:^(BOOL success, NSError * _Nullable error) {
                    if (success) {
                        NSLog(@"验证成功 刷新主界面");
                        dispatch_async(dispatch_get_main_queue(), ^{
                            AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                            BasicNavigationController *nav = [[BasicNavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
                            UIViewController *oldVC = appDelegate.window.rootViewController;
                            [oldVC removeFromParentViewController];
                            appDelegate.window.rootViewController = nav;
                            
                        });
                        
                    }else{
                        NSLog(@"%@",error.localizedDescription);
                        switch (error.code) {
                            case LAErrorSystemCancel:
                            {
                                NSLog(@"系统取消授权，如其他APP切入");
                                break;
                            }
                            case LAErrorUserCancel:
                            {
                                NSLog(@"用户取消验证Touch ID");
                                break;
                            }
                            case LAErrorAuthenticationFailed:
                            {
                                NSLog(@"授权失败");
                                break;
                            }
                            case LAErrorPasscodeNotSet:
                            {
                                NSLog(@"系统未设置密码");
                                break;
                            }
                            case LAErrorTouchIDNotAvailable:
                            {
                                NSLog(@"设备Touch ID不可用，例如未打开");
                                break;
                            }
                            case LAErrorTouchIDNotEnrolled:
                            {
                                NSLog(@"设备Touch ID不可用，用户未录入");
                                break;
                            }
                            case LAErrorUserFallback:
                            {
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                    NSLog(@"用户选择输入密码，切换主线程处理");
                                }];
                                break;
                            }
                            default:
                            {
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                    NSLog(@"其他情况，切换主线程处理");
                                }];
                                break;
                            }
                        }
                    }
                }];
    }else{
        NSLog(@"不支持指纹识别");
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
        
        NSLog(@"%@",error.localizedDescription);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
