//
//  HWvcLifeNavi2Vc.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/3/10.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "HWvcLifeNavi2Vc.h"

@interface HWvcLifeNavi2Vc ()

@end

@implementation HWvcLifeNavi2Vc

- (void)loadView{
    [super loadView];
    NSLog(@"vc2-loadView");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"vc2-viewDidLoad");
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"vc2-viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"vc2-viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"vc2-viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"vc2-viewDidDisappear");
}

- (void)dealloc{
    NSLog(@"vc2-dealloc");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
