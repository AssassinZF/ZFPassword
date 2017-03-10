//
//  ViewController.m
//  ZFPassword
//
//  Created by LZF on 2017/3/9.
//  Copyright © 2017年 zf.com. All rights reserved.
//

#import "ViewController.h"
#import "SettingViewController.h"
#import "AddPasswordViewController.h"
#import "PasswordModel.h"
#import "CustomTableViewCell.h"
const CGFloat button_w = 50;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UIButton *addButton;
@property (nonatomic , strong) UITableView *myTableView;
@property (nonatomic , strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"密码薄";
    [self addNavRightItem];
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.addButton];
    [self reloadData];
    
}

-(void)addNavRightItem{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStylePlain target:self action:@selector(clickSetting)];
    self.navigationItem.rightBarButtonItem = item;
    
    
}

-(void)clickAdd{
    
//    CATransition *tran = [CATransition animation];
//    tran.duration =.5;
//    tran.type =@"moveIn";
//    tran.subtype =kCATransitionFromRight;
//    [self.navigationController.view.layer addAnimation:tran forKey:nil];
    
    __weak typeof(self)weakSelf = self;
    AddPasswordViewController *vc = [[AddPasswordViewController alloc] initWithNibName:NSStringFromClass([AddPasswordViewController class]) bundle:nil];
    vc.saveSuccess = ^(void){
        [weakSelf reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

-(UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton addTarget:self action:@selector(clickAdd) forControlEvents:UIControlEventTouchUpInside];
        _addButton.backgroundColor = BASIC_COLOR;
        _addButton.layer.shadowColor = [UIColor whiteColor].CGColor;
        [_addButton setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        _addButton.layer.cornerRadius = button_w/2;
        _addButton.bounds = CGRectMake(0, 0, button_w, button_w);
        CGSize size = self.view.frame.size;
        _addButton.center = CGPointMake(size.width/2, size.height - button_w);
        
    }
    return _addButton;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

-(void)reloadData{
    [self.dataSource removeAllObjects];
    NSArray *array = [PasswordModel findAll];
    for (PasswordModel *model in array) {
        [self.dataSource addObject:model];
    }
    [self.myTableView reloadData];
}

-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.tableFooterView = [UIView new];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.rowHeight = 60;
        [_myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cellid"];
    }
    return _myTableView;
}

-(void)clickSetting{
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    
    PasswordModel *model = self.dataSource[indexPath.row];
    
    cell.titleLabel.text = model.titleLabel;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PasswordModel *model = self.dataSource[indexPath.row];
    AddPasswordViewController *vc = [[AddPasswordViewController alloc] initWithNibName:NSStringFromClass([AddPasswordViewController class]) bundle:nil];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
//进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PasswordModel *model = self.dataSource[indexPath.row];
        [model deleteObject];
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [self.myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除密码";
}


@end
