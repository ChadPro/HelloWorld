//
//  HWInheritVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/3/8.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "HWInheritVC.h"
#import "SDAutoLayout.h"
#import "HWTestInheritOC.h"
#import "HWTestOC1.h"

#define UIColorFromHex(s,alp)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alp]

@interface HWInheritVC ()

@end

@implementation HWInheritVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);
    
    HWTestInheritOC *oc = [[HWTestInheritOC alloc]init];
    oc = [[HWTestOC1 alloc]init];
    [oc test];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
