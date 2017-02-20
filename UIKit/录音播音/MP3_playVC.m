//
//  MP3_playVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/20.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "MP3_playVC.h"
#import <AVFoundation/AVFoundation.h>
#import "SDAutoLayout.h"

#define UIColorFromHex(s,alp)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alp]

@interface MP3_playVC ()

@property(nonatomic,strong) AVAudioPlayer *player;
@property(nonatomic,assign) float volume;

@end

@implementation MP3_playVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self setPlayer];
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
    
    UIButton *btn1 = [[UIButton alloc]init];
    [btn1 setTitle:@"Stop" forState:UIControlStateNormal];
    btn1.layer.cornerRadius = 8.0;
    [btn1 setBackgroundColor:UIColorFromHex(0xFF8C00, 1.0)];
    [btn1 addTarget:self action:@selector(stopAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    btn1.sd_layout
    .topSpaceToView(btn,15)
    .centerXEqualToView(btn)
    .widthIs(100)
    .heightIs(30);
    
    UIButton *btn2 = [[UIButton alloc]init];
    [btn2 setTitle:@"+" forState:UIControlStateNormal];
    btn2.layer.cornerRadius = 8.0;
    [btn2 setBackgroundColor:UIColorFromHex(0xFF8C00, 1.0)];
    [btn2 addTarget:self action:@selector(plusAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    btn2.sd_layout
    .topEqualToView(btn)
    .leftSpaceToView(btn,15)
    .widthIs(30)
    .heightIs(30);
    
    UIButton *btn3 = [[UIButton alloc]init];
    [btn3 setTitle:@"-" forState:UIControlStateNormal];
    btn3.layer.cornerRadius = 8.0;
    [btn3 setBackgroundColor:UIColorFromHex(0xFF8C00, 1.0)];
    [btn3 addTarget:self action:@selector(minusAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    btn3.sd_layout
    .topEqualToView(btn1)
    .leftSpaceToView(btn1,15)
    .widthIs(30)
    .heightIs(30);
    
}

- (void)setPlayer{
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"qingtian" ofType:@"mp3"]] error:nil];
    self.player.volume = 0.5;
    
}

- (void)playAction:(UIButton *)btn{
    [self.player play];
}

- (void)stopAction:(UIButton *)btn{
    [self.player stop];
}
- (void)plusAction:(UIButton *)btn{
    if(_volume<1.0){
        _volume = _volume + 0.1;
        self.player.volume = _volume;
    }
}
- (void)minusAction:(UIButton *)btn{
    if(_volume>0.0){
        _volume = _volume - 0.1;
        self.player.volume = _volume;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
