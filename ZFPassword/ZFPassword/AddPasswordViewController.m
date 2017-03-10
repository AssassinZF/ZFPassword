//
//  AddPasswordViewController.m
//  ZFPassword
//
//  Created by LZF on 2017/3/10.
//  Copyright © 2017年 zf.com. All rights reserved.
//

#import "AddPasswordViewController.h"
#import <MBProgressHUD.h>
#import "PasswordModel.h"

@interface AddPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *accountTextFidld;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *remarkTextField;

@end

@implementation AddPasswordViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.titleLabel becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加密码";
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)savePassword:(id)sender {
    
    BOOL isPass = self.titleLabel.text.length > 0 && self.accountTextFidld.text.length > 0 && self.passwordTextField.text.length > 0;
    if (isPass) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"保存中...";
        
        PasswordModel *model = [[PasswordModel alloc] init];
        model.titleLabel = self.titleLabel.text;
        model.userName = self.accountTextFidld.text;
        model.password = self.passwordTextField.text;
        if (self.remarkTextField.text.length) {
            model.remark = self.remarkTextField.text;
        }
       BOOL isSuc = [model save];
        
        if (isSuc) {
            [hud hideAnimated:YES afterDelay:1];
            self.saveSuccess();
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else{
            hud.label.text = @"保存中成功";
            [hud hideAnimated:YES afterDelay:1.f];
        }
        
    }
    
}

@end
