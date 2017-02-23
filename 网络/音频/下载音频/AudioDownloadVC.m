//
//  AudioDownloadVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/23.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "AudioDownloadVC.h"
#import "SDAutoLayout.h"
#import <AVFoundation/AVFoundation.h>

#define UIColorFromHex(s,alp)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alp]
#define baseTag 170223

@interface AudioDownloadVC ()

@property(nonatomic,strong) UILabel *stateLabe;   //下载状态
@property(nonatomic,strong) AVAudioSession *session;    //音频控制器
@property(nonatomic,strong) AVAudioRecorder *recorder;   //录音控制器
@property(nonatomic,strong) AVAudioPlayer *player;    //播放控制器
@property(nonatomic,strong) NSData *musicData;  //音乐缓存

@end

@implementation AudioDownloadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);
    
    _stateLabe = [[UILabel alloc]init];
    _stateLabe.backgroundColor = [UIColor blackColor];
    _stateLabe.textColor = [UIColor whiteColor];
    [self.view addSubview:_stateLabe];
    _stateLabe.sd_layout
    .topSpaceToView(self.view,100)
    .centerXEqualToView(self.view)
    .widthIs(100)
    .heightIs(30);
    
    NSArray *titles = @[@"下载",@"播放"];
    
    for(NSInteger i=0;i<[titles count];i++){
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = baseTag + i;
        btn.layer.cornerRadius = 8.0;
        [btn setBackgroundColor:UIColorFromHex(0xFF8C00, 1.0)];
        [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn.sd_layout
        .centerXEqualToView(self.view)
        .widthIs(100)
        .heightIs(45)
        .topSpaceToView(_stateLabe, 15 + i*(15+45));
    }

}

- (void)buttonAction:(UIButton *)btn{
    NSInteger tag = btn.tag - baseTag;
    if(tag == 0){    //下载
        [self downloadAudioByiOS:btn];
    }else if(tag == 1){  //播放
        NSError *error=nil;
        NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath , @"qingtian"];
 
        NSURL *url = [NSURL URLWithString:filePath];
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        self.player.volume = 0.8;
        [self.player play];
        if(error){
            NSLog(@"error = %@",error);
        }else{
            NSLog(@"开始播放");
        }
    }
}

-(void)downloadAudioByiOS:(UIButton *)btn{
    //1.获的session，如果用代理的话，要用另外获得session的方式
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2.请求request
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.77:33333/main/audio/download/qingtian.mp3"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    //3.创建任务Task
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //解析数据
        dispatch_async(dispatch_get_main_queue(), ^{
            if(error){
            self.stateLabe.text = @"下载失败";
            }else{
            self.stateLabe.text = @"下载完成";
            NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
            NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath , @"qingtian"];
            [data writeToFile:filePath atomically:YES];
            }
        });
    }];
    
    //4.开始任务
    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
