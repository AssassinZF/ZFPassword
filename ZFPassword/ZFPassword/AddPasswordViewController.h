//
//  AddPasswordViewController.h
//  ZFPassword
//
//  Created by LZF on 2017/3/10.
//  Copyright © 2017年 zf.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicViewController.h"
@class PasswordModel;
@interface AddPasswordViewController : BasicViewController
@property (nonatomic , copy) void(^saveSuccess)(void);
@property (nonatomic , strong) PasswordModel *model;
@end
