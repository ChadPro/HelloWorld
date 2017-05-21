//
//  SlideControlViewController.m
//  HelloWorld
//
//  Created by Chad Pro on 2017/5/21.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "SlideControlViewController.h"
#import "SlideControlView.h"

#import "SDAutoLayout.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface SlideControlViewController ()

@end

@implementation SlideControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat vHeight = 200;
    CGFloat vWidth = 50;
    CGFloat vX = ScreenWidth/2-vWidth/2;
    CGFloat vY = ScreenHeight/2-vHeight/2;
    SlideControlView *cmdView = [[SlideControlView alloc]initWithFrame:CGRectMake(vX, vY, vWidth, vHeight)];
    cmdView.layer.cornerRadius = 5.0;
    cmdView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:cmdView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
