//
//  HWvcLifeNaviVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/3/10.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "HWvcLifeNaviVC.h"
#import "HWvcLifeNavi2Vc.h"

@interface HWvcLifeNaviVC ()

@end

@implementation HWvcLifeNaviVC

- (void)loadView{
    [super loadView];
    NSLog(@"vc1-loadView");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"vc1-viewDidLoad");
    self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
    btn.layer.cornerRadius = 5.0;
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view,200)
    .heightIs(50)
    .widthIs(100);
}

- (void)btnAction:(UIButton *)btn{
    HWvcLifeNavi2Vc *vc = [[HWvcLifeNavi2Vc alloc]init];
    vc.view.backgroundColor = UIColorFromHex(0x009966, 1.0);
    vc.title = @"第二视图";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"vc1-viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"vc1-viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"vc1-viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"vc1-viewDidDisappear");
}

- (void)dealloc{
    NSLog(@"vc1-dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
