//
//  SettingViewController.m
//  ZFPassword
//
//  Created by LZF on 2017/3/10.
//  Copyright © 2017年 zf.com. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *sectionTextArray;
}
@property (nonatomic , strong) UITableView *myTableView;
@property (nonatomic , strong) NSMutableArray *dataSource;


@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self.view addSubview:self.myTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
        NSArray *array = @[@[@"开启指纹密码",@"开始数字密码"],@[@"关于我们",@"隐私政策"]];
        [_dataSource addObjectsFromArray:array];
        
        sectionTextArray = @[@"安全",@"关于"];
    }
    return _dataSource;
}
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.rowHeight = 50;
        [_myTableView registerClass:[SettingTableViewCell class] forCellReuseIdentifier:@"cellid"];
    }
    return _myTableView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.dataSource[section];
    return array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    
    NSString *string = self.dataSource[indexPath.section][indexPath.row];
    
    cell.textLabel.text = string;
    cell.textLabel.textColor = [UIColor textColor];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
    label.text = sectionTextArray[section];
    label.textColor = [UIColor textColor];
    label.font = [UIFont systemFontOfSize:12];
    return label;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}




@end
