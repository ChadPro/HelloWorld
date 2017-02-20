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

#include "lame.h"

#define UIColorFromHex(s,alp)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alp]
#define baseTag 170220

@interface AVAudioRecorderVC ()

@property(nonatomic,strong) NSString *recordFilePath;  //录音缓存地址
@property(nonatomic,strong) NSURL *recordUrl;   //录音url
@property(nonatomic,strong) AVAudioSession *session;    //音频控制器
@property(nonatomic,strong) AVAudioRecorder *recorder;   //录音控制器
@property(nonatomic,strong) AVAudioPlayer *player;    //播放控制器

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
    
    NSArray *titles = @[@"录音",@"停止",@"播放",@"转mp3",@"转换后播放"];
    
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
        self.player.volume = 0.8;
        [self.player play];
    }else if(tag == 3){  //转mp3
        [self audioTomp3];
    }else if(tag == 4){  //抓换后播放
        NSString *path =[NSTemporaryDirectory() stringByAppendingPathComponent:@"record.mp3"];
        NSURL *url = [NSURL fileURLWithPath:path];
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.player = [[AVAudioPlayer alloc] initWithData:data error:nil];
        self.player.volume = 0.8;
        [self.player play];
    }
}

//判断是否可以录音
-(void)couldRecord{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    if ([session respondsToSelector:@selector(requestRecordPermission:)]){
        [session performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted)
            {  //用户同意获取麦克风
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //在主线程中是执行录音操作
                        [self record];
                    });
            }else{}
        }];
    }
}

//录制
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
    //开启仪表计数功能,开启这个功能，才能检测音频值
    [_recorder setMeteringEnabled:YES];
    //启动或者恢复记录的录音文件
    [_recorder record];
}

//转换 -> mp3
- (void)audioTomp3{
    
    NSString *mp3FilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"record.mp3"];
    
    @try {
        int read, write;
        
        FILE *pcm = fopen([self.recordFilePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 11025.0);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        NSLog(@"MP3生成成功!");
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
