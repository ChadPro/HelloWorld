//
//  BtnTestViewController.m
//  HelloWorld
//
//  Created by Chad Pro on 2017/5/20.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "BtnTestViewController.h"
#import "SDAutoLayout.h"

@interface BtnTestViewController ()

@property(nonatomic,strong) UIButton *btn1;
@property(nonatomic,strong) UIButton *btn2;

@end

@implementation BtnTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor  = [UIColor whiteColor];
    
    self.btn1 = [[UIButton alloc] init];
    [_btn1 setTitle:@"btn" forState:UIControlStateNormal];
    [_btn1 setTitle:@"en" forState:UIControlStateHighlighted];
    [_btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _btn1.layer.cornerRadius = 5.0;
    _btn1.layer.borderColor = [UIColor greenColor].CGColor;
    _btn1.layer.borderWidth = 3.0;
    [_btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn1];
    self.btn1.sd_layout
    .centerXEqualToView(self.view)
    .centerYEqualToView(self.view)
    .widthIs(100)
    .heightIs(30);
}

- (void)btnAction:(UIButton *)btn{
    NSInteger tag = btn.tag;
    NSLog(@"touch btn %ld",tag);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
