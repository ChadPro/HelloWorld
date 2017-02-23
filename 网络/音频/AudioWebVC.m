//
//  AudioWebVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/21.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "AudioWebVC.h"
#import "SDAutoLayout.h"

#import "AudioUploadVC.h"
#import "AudioDownloadVC.h"

@interface AudioWebVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *titles;

@end

@implementation AudioWebVC

static NSString *cellIdentifier = @"cellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    _titles = @[@"上传音频",@"下载音频",@"实时播放"];
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc]init];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    _tableView.delegate = self;
    _tableView.dataSource = self;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if(row == 0){
        AudioUploadVC *vc = [[AudioUploadVC alloc]init];
        vc.title = [_titles objectAtIndex:row];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(row == 1){
        AudioDownloadVC *vc = [[AudioDownloadVC alloc]init];
        vc.title = [_titles objectAtIndex:row];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(row == 1){
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [_titles objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
