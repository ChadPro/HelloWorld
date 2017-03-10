//
//  HWBasicAnimationVc.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/3/10.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "HWBasicAnimationVc.h"

@interface HWBasicAnimationVc ()

@property(nonatomic,strong) UIView *sectionView;
@property(nonatomic,strong) UIView *animationView;
@property(nonatomic,strong) UIButton *btn;

@end

@implementation HWBasicAnimationVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);
    
    _btn = [[UIButton alloc]init];
    [_btn setTitle:@"start" forState:UIControlStateNormal];
    [_btn setBackgroundColor:[UIColor clearColor]];
    [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _btn.layer.cornerRadius = 5.0;
    [_btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    _btn.sd_layout
    .centerXEqualToView(self.view)
    .bottomSpaceToView(self.view,15)
    .widthIs(100)
    .heightIs(30);
    
    _sectionView = [[UIView alloc]initWithFrame:CGRectMake(15, 80, ScreenWidth-30, ScreenHeight-80-30-15-15)];
    
    
    _sectionView.backgroundColor = [UIColor grayColor];
    _sectionView.layer.cornerRadius = 5.0;
    [self.view addSubview:_sectionView];

    
    _animationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    _animationView.layer.cornerRadius = 8.0;
    _animationView.backgroundColor = [UIColor blueColor];
    [_sectionView addSubview:_animationView];
    
}

- (void)btnAction:(UIButton *)btn{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 0.5;
    
    animation.fromValue = [NSValue valueWithCGPoint:_animationView.layer.position];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(_animationView.layer.position.x+100, _animationView.layer.position.y+100)];
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [_animationView.layer addAnimation:animation forKey:@"translate"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
