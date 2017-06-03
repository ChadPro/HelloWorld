//
//  SlideControlViewController.m
//  HelloWorld
//
//  Created by Chad Pro on 2017/5/21.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "SlideControlViewController.h"
#import "SlideControlView.h"
#import "QSTCSlideCtlView.h"

#import "SDAutoLayout.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface SlideControlViewController ()<SlideBarCtlDelegate>

@end

@implementation SlideControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
//    CGFloat vHeight = 400;
//    CGFloat vWidth = 50;
//    CGFloat vX = ScreenWidth/2-vWidth/2;
//    CGFloat vY = ScreenHeight/2-vHeight/2;
//    SlideControlView *cmdView = [[SlideControlView alloc] initWithFrame:CGRectMake(vX, vY, vWidth, vHeight)];
//    cmdView.controlDelegate = self;
//    cmdView.layer.cornerRadius = 5.0;
//    cmdView.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:cmdView];
    
    CGFloat vHeight = 200;
    CGFloat vWidth = 200;
    QSTCSlideCtlView *cmdView = [[QSTCSlideCtlView alloc] initWithFrame:CGRectMake(50, 114, vWidth, vHeight)];
    cmdView.ctlDelegate = self;
    [self.view addSubview:cmdView];
}

- (void)slideControlFloatBack:(CGFloat)slideNum controlType:(NSInteger)type{
    if(type == 0){
        NSLog(@"x = %f",slideNum);
    }else if(type == 1){
        NSLog(@"y = %f",slideNum);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
