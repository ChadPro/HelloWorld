//
//  HWDataVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/23.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "HWDataVC.h"
#import "SDAutoLayout.h"

#import "HWCreatePlistDataVC.h"
#import "HWArchiverVC.h"
#import "HWSqliteVC.h"
#import "HWSelectGoodVC.h"

@interface HWDataVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *titles;

@end

@implementation HWDataVC

static NSString *cellIdentifier = @"cellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    _titles = @[@"plist",@"Archiver归档",@"Core Data",@"SQLite3",@"SQLite3-商品属性选择"];
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:_tableView];
    _tableView.sd_layout
    .topEqualToView(self.view)
    .bottomEqualToView(self.view)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [_titles objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if(row == 0){
        HWCreatePlistDataVC *vc = [[HWCreatePlistDataVC alloc]init];
        vc.title = [_titles objectAtIndex:row];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(row == 1){
        HWArchiverVC *vc = [[HWArchiverVC alloc]init];
        vc.title = [_titles objectAtIndex:row];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(row == 2){
        
    }else if(row == 3){
        HWSqliteVC *vc = [[HWSqliteVC alloc]init];
        vc.title = [_titles objectAtIndex:row];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(row == 4){
        HWSelectGoodVC *vc = [[HWSelectGoodVC alloc]init];
        vc.title = [_titles objectAtIndex:row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
