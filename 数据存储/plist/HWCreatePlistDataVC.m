//
//  HWCreatePlistDataVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/23.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "HWCreatePlistDataVC.h"

#define UIColorFromHex(s,alp)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alp]

@interface HWCreatePlistDataVC ()

@end

@implementation HWCreatePlistDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
