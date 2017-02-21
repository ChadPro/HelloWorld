//
//  ImageWebVc.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/21.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "ImageWebVC.h"
#import "SDAutoLayout.h"

#define UIColorFromHex(s,alp)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alp]

@interface ImageWebVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *titles;
@property(nonatomic,strong) NSString *cellIdentifier;

@end

@implementation ImageWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = @[@"下载图片",@"上传图片",@"缓存图片"];
    self.cellIdentifier = @"tableViewCell";
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);
    
    self.tableView = [[UITableView alloc]init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:self.cellIdentifier];
    [self.view addSubview:self.tableView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
