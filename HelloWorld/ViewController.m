//
//  ViewController.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/20.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "ViewController.h"
#import "SDAutoLayout.h"

#import "iOSCodeVC.h"
#import "WebVC.h"
#import "HWDataVC.h"
#import "HWLayerLearnVC.h"
#import "HWRunLoopMainVC.h"

#define UIColorFromHex(s,alp)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alp]
#define tagBase 170220

@interface ViewController ()

@property(nonatomic,strong) NSArray *btnTitles;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btnTitles = @[@"UIKit",@"网络",@"数据存储",@"图像处理",@"RunLoop"];
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);
    
    for (NSInteger i = 0; i<_btnTitles.count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = tagBase + i;
        btn.layer.cornerRadius = 8.0;
        [btn setBackgroundColor:UIColorFromHex(0xFF8C00, 1.0)];
        [btn setTitle:[_btnTitles objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(jumpAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn.sd_layout
        .centerXEqualToView(self.view)
        .widthIs(100)
        .heightIs(45)
        .topSpaceToView(self.view, 150 + i*(15+45));
    }
}

- (void)jumpAction:(UIButton *)btn{
    NSInteger tag = btn.tag - tagBase;
    if(tag == 0){
        iOSCodeVC *vc = [[iOSCodeVC alloc] init];
        vc.title = [self.btnTitles objectAtIndex:tag];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(tag == 1){
        WebVC *vc = [[WebVC alloc] init];
        vc.title = [self.btnTitles objectAtIndex:tag];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(tag == 2){
        HWDataVC *vc = [[HWDataVC alloc] init];
        vc.title = [self.btnTitles objectAtIndex:tag];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(tag == 3){
        HWLayerLearnVC *vc = [[HWLayerLearnVC alloc] init];
        vc.title = [self.btnTitles objectAtIndex:tag];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(tag == 4){
        HWRunLoopMainVC *vc = [[HWRunLoopMainVC alloc] init];
        vc.title = [self.btnTitles objectAtIndex:tag];
        [self.navigationController pushViewController:vc animated:YES];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
