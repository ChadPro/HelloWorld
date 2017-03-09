//
//  HWNotifyVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/3/9.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "HWNotifyVC.h"

@interface HWNotifyVC ()

@property(nonatomic,strong) UILabel *textLabel;

@end

@implementation HWNotifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);
    
    _textLabel = [[UILabel alloc]init];
    _textLabel.textColor = [UIColor blackColor];
    _textLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_textLabel];
    _textLabel.sd_layout
    .leftSpaceToView(self.view,100)
    .rightSpaceToView(self.view,100)
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view,200);
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"send" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5.0;
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.sd_layout
    .topSpaceToView(_textLabel,30)
    .centerXEqualToView(_textLabel)
    .heightIs(50)
    .widthIs(100);
    
}

- (void)btnAction:(UIButton *)btn{
    
}

- (void)notifyAction:(NSNotification *)notification{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
