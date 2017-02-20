//
//  MP3_playVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/20.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "MP3_playVC.h"
#import "SDAutoLayout.h"

#define UIColorFromHex(s,alp)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alp]

@interface MP3_playVC ()

@end

@implementation MP3_playVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"Play" forState:UIControlStateNormal];
    btn.layer.cornerRadius = 8.0;
    [btn setBackgroundColor:UIColorFromHex(0xFF8C00, 1.0)];
    [btn addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.sd_layout
    .topSpaceToView(self.view,100)
    .centerXEqualToView(self.view)
    .widthIs(100)
    .heightIs(30);
    
}

- (void)playAction:(UIButton *)btn{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
