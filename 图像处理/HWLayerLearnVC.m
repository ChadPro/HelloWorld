//
//  HWLayerLearnVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/3/7.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "HWLayerLearnVC.h"
#import "SDAutoLayout.h"

#define UIColorFromHex(s,alp)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alp]

@interface HWLayerLearnVC ()

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *titles;

@end

@implementation HWLayerLearnVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = @[@"动画",@"头像截取",@"图片圆角",@"贝塞尔曲线"];
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.backgroundColor = [UIColor clearColor];
       
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
