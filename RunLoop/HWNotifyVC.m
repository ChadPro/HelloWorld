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
    
    //注册观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyAction:) name:@"NotifyTest" object:nil];
}

- (void)btnAction:(UIButton *)btn{
    //发送通知，并带着一个dic传递信息
    NSDictionary *dic = @{@"name":@"Chad",@"age":@"27"};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NotifyTest" object:nil userInfo:dic];
    
}

- (void)notifyAction:(NSNotification *)notification{
    NSDictionary *dic = notification.userInfo;
    NSLog(@"name = %@",[dic valueForKey:@"name"]);
    NSLog(@"age = %@",[dic valueForKey:@"age"]);
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:@"NotifyTest"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
