//
//  PasswordModel.h
//  ZFPassword
//
//  Created by LZF on 2017/3/10.
//  Copyright © 2017年 zf.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKDBModel.h"

typedef NS_ENUM(NSInteger,AccountType) {
    /*
     * 邮箱注册
     * 电话号码注册
     * 昵称注册
     * 第三方登录
     */
    AccountTypeE_mail,
    AccountTypePhone,
    AccountTypeuNickName,
    AccountTypeThridParty,
};

@interface PasswordModel : JKDBModel
@property (nonatomic , assign) AccountType accountType;
@property (nonatomic , copy) NSString *titleLabel;
@property (nonatomic , copy) NSString *nickName;
@property (nonatomic , copy) NSString *phoneNumber;
@property (nonatomic , copy) NSString *e_mail;
@property (nonatomic , copy) NSString *userName;
@property (nonatomic , copy) NSString *password;
@property (nonatomic , copy) NSString *remark;//备注
@end
