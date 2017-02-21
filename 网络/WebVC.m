//
//  WebVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/20.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "WebVC.h"
#import "WebVCDataSource.h"
#import "SDAutoLayout.h"

#import "JSONVC.h"
#import "ImageWebVC.h"
#import "AudioWebVC.h"
#import "VideoWebVC.h"

#define UIColorFromHex(s,alp)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alp]

@interface WebVC ()<UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *titles;
@property(nonatomic,strong) WebVCDataSource *dataSource;

@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _titles = @[@"json",@"图片",@"音频",@"视频",@"加密文件"];
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    _dataSource = [[WebVCDataSource alloc]init];
    _dataSource.titles = _titles;
    _dataSource.cellIdentifier = @"tableViewCell";
    self.tableView.dataSource = _dataSource;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
    [self.view addSubview:_tableView];
    _tableView.sd_layout
    .topSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if(row == 0){
        JSONVC *vc = [[JSONVC alloc] init];
        vc.title = [_titles objectAtIndex:row];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(row == 1){
        ImageWebVC *vc = [[ImageWebVC alloc]init];
        vc.title = [_titles objectAtIndex:row];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(row == 2){
        AudioWebVC *vc = [[AudioWebVC alloc]init];
        vc.title = [_titles objectAtIndex:row];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(row == 3){
        VideoWebVC *vc = [[VideoWebVC alloc]init];
        vc.title = [_titles objectAtIndex:row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
