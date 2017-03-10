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
{
    BOOL isEdit;
}
@property (weak, nonatomic) IBOutlet UITextField *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *accountTextFidld;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *remarkTextField;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;

@end

@implementation AddPasswordViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    if (!self.model) {
        [self.titleLabel becomeFirstResponder];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加密码";
    
    if (self.model) {
        [self.bottomButton setTitle:@"保存修改" forState:UIControlStateNormal];
        self.bottomButton.hidden = YES;
        self.titleLabel.text = self.model.titleLabel;
        self.accountTextFidld.text = self.model.userName;
        self.passwordTextField.text = self.model.password;
        if (self.model.remark.length) {
            self.remarkTextField.text = self.model.remark;
        }
    }
}

-(void)setModel:(PasswordModel *)model{
    _model = model;
    
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
