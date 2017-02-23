//
//  AudioUploadVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/23.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "AudioUploadVC.h"
#import "SDAutoLayout.h"
#import <AVFoundation/AVFoundation.h>

#include "lame.h"

#define UIColorFromHex(s,alp)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alp]
#define baseTag 170223

@interface AudioUploadVC ()

@property(nonatomic,strong) UILabel *timeLabel;   //录音时间显示
@property(nonatomic,strong) NSString *recordFilePath;  //录音缓存地址
@property(nonatomic,strong) NSURL *recordUrl;   //录音url
@property(nonatomic,strong) AVAudioSession *session;    //音频控制器
@property(nonatomic,strong) AVAudioRecorder *recorder;   //录音控制器
@property(nonatomic,strong) AVAudioPlayer *player;    //播放控制器

@end

@implementation AudioUploadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _recordFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"record.caf"];
    _recordUrl = [NSURL fileURLWithPath:self.recordFilePath];
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);

    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.text = @"0";
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.layer.cornerRadius = 8.0;
    _timeLabel.backgroundColor = [UIColor blackColor];
    _timeLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:_timeLabel];
    _timeLabel.sd_layout
    .topSpaceToView(self.view,150)
    .centerXEqualToView(self.view)
    .widthIs(100)
    .heightIs(30);
    
    NSArray *titles = @[@"录音",@"停止",@"播放",@"上传"];
    
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
        .topSpaceToView(_timeLabel, 15 + i*(15+45));
    }
 
}

#pragma mark- --按钮action--
- (void)buttonAction:(UIButton *)btn{
    NSInteger i = btn.tag - baseTag;
    if(i == 0){   //record
        [self couldRecord];
    }else if(i == 1){   //stop
        [self.recorder stop];
    }else if(i == 2){   //play
        NSData *data =  [NSData dataWithContentsOfURL:self.recordUrl];
        self.player = [[AVAudioPlayer alloc] initWithData:data error:nil];
        self.player.volume = 0.8;
        [self.player play];
    }else if(i == 3){   //send
        [self audioTomp3];
        [self sendAudio];
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

//发送音频
- (void)sendAudio{
    NSString *path =[NSTemporaryDirectory() stringByAppendingPathComponent:@"record.mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self sendAudioByNSURLSession:data];
//    [self sendAudioByAFNetworking:data];
}

- (void)sendAudioByNSURLSession:(NSData *)data{
    //写请求行
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.77:33333/main/audio/upload"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    //写请求头
    NSString *boundary = @"--------827292";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data;boundary=%@",boundary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    //写请求体
    NSMutableString *bodyHead = [[NSMutableString alloc]init];
    NSMutableData *multableData = [[NSMutableData alloc]init];
    
    NSString *name = @"audio";
    NSString *fileName = @"audio.mp3";

    
    NSString *rn = @"\r\n";
    NSString *base = @"--";
    NSString *beginBoundary =[base stringByAppendingString:boundary];
    NSString *endBoundary =[rn stringByAppendingString:[beginBoundary stringByAppendingString:base]];
    [bodyHead appendString:beginBoundary];
    [bodyHead appendFormat:@"\r\nContent-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",name,fileName];
    [bodyHead appendFormat:@"Content-Type: audio/mp3\r\n\r\n"];
    
    [multableData appendData:[bodyHead dataUsingEncoding:NSUTF8StringEncoding]];
    [multableData appendData:data];
    [multableData appendData:[endBoundary dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSData *sendData = [multableData copy];
    
    NSURLSessionDataTask *dataTask = [session uploadTaskWithRequest:request fromData:sendData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error) NSLog(@"error = %@",error);
        
    }];
    
    [dataTask resume];
}

- (void)sendAudioByAFNetworking:(NSData *)data{
    
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
