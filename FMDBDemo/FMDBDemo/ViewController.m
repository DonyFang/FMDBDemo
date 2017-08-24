//
//  ViewController.m
//  FMDBDemo
//
//  Created by 方冬冬 on 2017/7/24.
//  Copyright © 2017年 方冬冬. All rights reserved.
//推荐一个框架   对应模型存取
//https://github.com/gitkong/FLFMDBManager

//https://github.com/Haley-Wong/JKDBModel

#import "ViewController.h"
#import "BasicViewController.h"
#import "SubpackageViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *mainTable;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Fmdb 基本使用方法";
    self.mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.mainTable];
    self.mainTable.delegate = self;
    
    self.mainTable.dataSource = self;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"常用方法";
        
    }else if(indexPath.row == 1){
        cell.textLabel.text = @"封装FMdb";
        
    }
    
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        BasicViewController *simpleOne = [[BasicViewController alloc] init];
        [self.navigationController pushViewController:simpleOne animated:YES];
    }else if (indexPath.row == 1){
        SubpackageViewController *simpleOne = [[SubpackageViewController alloc] init];
        [self.navigationController pushViewController:simpleOne animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
    
}

@end
