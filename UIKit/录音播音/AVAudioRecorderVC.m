//
//  AVAudioRecorderVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/20.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "AVAudioRecorderVC.h"
#import <AVFoundation/AVFoundation.h>
#import "SDAutoLayout.h"

#define UIColorFromHex(s,alp)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alp]
#define baseTag 170220

@interface AVAudioRecorderVC ()

@property(nonatomic,strong) NSString *recordFilePath;
@property(nonatomic,strong) NSURL *recordUrl;
@property(nonatomic,strong) AVAudioSession *session;
@property(nonatomic,strong) AVAudioRecorder *recorder;
@property(nonatomic,strong) AVAudioPlayer *player;

@end

@implementation AVAudioRecorderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _recordFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"record.caf"];
    _recordUrl = [NSURL fileURLWithPath:self.recordFilePath];
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);
    
    NSArray *titles = @[@"录音",@"停止",@"播放"];
    
    for(NSInteger i=0;i<[titles count];i++){
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = baseTag + i;
        btn.layer.cornerRadius = 8.0;
        [btn setBackgroundColor:UIColorFromHex(0xFF8C00, 1.0)];
        [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn.sd_layout
        .centerXEqualToView(self.view)
        .widthIs(100)
        .heightIs(45)
        .topSpaceToView(self.view, 150 + i*(15+45));
    }
    
}

- (void)btnAction:(UIButton *)btn{
    NSInteger tag = btn.tag - baseTag;
    if(tag == 0){         //录音
        [self couldRecord];
    }else if(tag == 1){   //停止
        [self.recorder stop];
    }else if(tag == 2){   //播放
        NSData *data =  [NSData dataWithContentsOfURL:self.recordUrl];
        self.player = [[AVAudioPlayer alloc] initWithData:data error:nil];
        self.player.volume = 0.5;
        [self.player play];
    }
}

//判断是否可以录音
-(void)couldRecord{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    if ([session respondsToSelector:@selector(requestRecordPermission:)]){
        [session performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                
                // 用户同意获取麦克风，一定要在主线程中执行UI操作！！！
                dispatch_queue_t queueOne = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_async(queueOne, ^{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //在主线程中执行UI，这里主要是执行录音和计时的UI操作
                        [self record];
                    });
                });
            } else {
                
                // 用户不同意获取麦克风
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"麦克风不可用" message:@"请在“设置 - 隐私 - 麦克风”中允许XXX访问你的麦克风" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *openAction = [UIAlertAction actionWithTitle:@"前往开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    //如果要让用户直接跳转到设置界面，则可以进行下面的操作，如不需要，就忽略下面的代码
                    /*
                     *iOS10 开始苹果禁止应用直接跳转到系统单个设置页面，只能跳转到应用所有设置页面
                     *iOS10以下可以添加单个设置的系统路径，并在info里添加URL Type，将URL schemes 设置路径为prefs即可。
                     *@"prefs:root=Sounds"
                     */
                    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    
                    if([[UIApplication sharedApplication] canOpenURL:url]) {
                        
                        [[UIApplication sharedApplication] openURL:url];
                    }
                }];
                
                [alertController addAction:openAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }];
    }
}

-(void)record{
    _session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [_session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    //判断后台有没有播放
    if (_session == nil) {
        
        NSLog(@"Error creating sessing:%@", [sessionError description]);
    } else {
        //关闭其他音频播放，把自己设为活跃状态
        [_session setActive:YES error:nil];
    }
    

    
    //设置AVAudioRecorder
    if (!self.recorder) {
        
        NSDictionary *settings = @{AVFormatIDKey  :  @(kAudioFormatLinearPCM), AVSampleRateKey : @(11025.0), AVNumberOfChannelsKey :@2, AVEncoderBitDepthHintKey : @16, AVEncoderAudioQualityKey : @(AVAudioQualityHigh)};
        
        //开始录音,将所获取到得录音存到文件里 _recordUrl 是存放录音的文件路径，在下面附上
        
        self.recorder = [[AVAudioRecorder alloc] initWithURL:_recordUrl settings:settings error:nil];
        
        /*
         * settings 参数
         1.AVNumberOfChannelsKey 通道数 通常为双声道 值2
         2.AVSampleRateKey 采样率 单位HZ 通常设置成44100 也就是44.1k,采样率必须要设为11025才能使转化成mp3格式后不会失真
         3.AVLinearPCMBitDepthKey 比特率 8 16 24 32
         4.AVEncoderAudioQualityKey 声音质量
         ① AVAudioQualityMin  = 0, 最小的质量
         ② AVAudioQualityLow  = 0x20, 比较低的质量
         ③ AVAudioQualityMedium = 0x40, 中间的质量
         ④ AVAudioQualityHigh  = 0x60,高的质量
         ⑤ AVAudioQualityMax  = 0x7F 最好的质量
         5.AVEncoderBitRateKey 音频编码的比特率 单位Kbps 传输的速率 一般设置128000 也就是128kbps
         
         */
    }
    
    //准备记录录音
    [_recorder prepareToRecord];
    
    //开启仪表计数功能,必须开启这个功能，才能检测音频值
    [_recorder setMeteringEnabled:YES];
    //启动或者恢复记录的录音文件
    [_recorder record];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
