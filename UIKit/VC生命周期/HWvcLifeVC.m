//
//  HWvcLifeVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/3/10.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "HWvcLifeVC.h"

@interface HWvcLifeVC ()

@end

@implementation HWvcLifeVC

- (void)loadView{
    [super loadView];
    NSLog(@"loadView");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
}

- (void)dealloc{
    NSLog(@"dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
