//
//  iOSCodeVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/20.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "iOSCodeVC.h"
#import "iOSCodeVCDataSource.h"
#import "SDAutoLayout.h"

#import "MP3_playVC.h"
#import "AVAudioRecorderVC.h"
#import "HWvcLifeVC.h"
#import "HWvcLifeNaviVC.h"
#import "BtnTestViewController.h"
#import "SlideControlViewController.h"

#define UIColorFromHex(s,alp)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alp]

@interface iOSCodeVC ()<UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) iOSCodeVCDataSource *dataSource;
@property(nonatomic,strong) NSArray *titleArray;

@end

@implementation iOSCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = @[@"播放音频",@"录制音频",@"VC生命周期",@"VC生命周期+导航",@"UIButton",@"比例滑块"];
    [self createUI];
}

-(void) createUI{
    self.view.backgroundColor = [UIColor whiteColor];

    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    _dataSource = [[iOSCodeVCDataSource alloc]init];
    _dataSource.titleArray = _titleArray;
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
        MP3_playVC *vc = [[MP3_playVC alloc]init];
        vc.title = [_titleArray objectAtIndex:row];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(row == 1){
        AVAudioRecorderVC *vc = [[AVAudioRecorderVC alloc]init];
        vc.title = [_titleArray objectAtIndex:row];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(row == 2){
        HWvcLifeVC *vc = [[HWvcLifeVC alloc]init];
        vc.title = [_titleArray objectAtIndex:row];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(row == 3){
        HWvcLifeNaviVC *vc = [[HWvcLifeNaviVC alloc]init];
        vc.title = [_titleArray objectAtIndex:row];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(row == 4){
        BtnTestViewController *vc = [[BtnTestViewController alloc]init];
        vc.title = [_titleArray objectAtIndex:row];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(row == 5){
        SlideControlViewController *vc = [[SlideControlViewController alloc]init];
        vc.title = [_titleArray objectAtIndex:row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
