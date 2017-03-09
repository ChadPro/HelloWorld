//
//  HWhttpsLearnVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/3/8.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "HWhttpsLearnVC.h"

#define UIColorFromHex(s,alp)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alp]

@interface HWhttpsLearnVC ()<NSURLSessionDelegate,NSURLSessionDataDelegate,NSURLSessionDownloadDelegate>

@property(nonatomic,strong) NSMutableData *allData;

@end

@implementation HWhttpsLearnVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);
    [self getData];
}

- (void)getData{
    [self getJsWithNSUrlSession];
}

- (void)getJsWithNSUrlSession{
//    NSURL *url = [NSURL URLWithString:@"https://www.12306.cn"];
    NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/book/1220562"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    [task resume];
}

#pragma mark- --DataDelegate--
//接收到返回信息时（还未开始下载)
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(nonnull NSURLResponse *)response completionHandler:(nonnull void (^)(NSURLSessionResponseDisposition))completionHandler{
    NSHTTPURLResponse *r = (NSHTTPURLResponse *)response;
//    NSLog(@"statusCode = %ld",r.statusCode);
    self.allData = [NSMutableData data];
    completionHandler(NSURLSessionResponseAllow);
}

//接收返回的数据
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    [self.allData appendData:data];
}

//证书处理
- (void)URLSession:(NSURLSession *)session
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
{
    //AFNetworking中的处理方式
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    //判断服务器返回的证书是否是服务器信任的
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        NSLog(@"serverTrust = %@",challenge.protectionSpace.serverTrust);
        /*disposition：如何处理证书
         NSURLSessionAuthChallengePerformDefaultHandling:默认方式处理
         NSURLSessionAuthChallengeUseCredential：使用指定的证书    NSURLSessionAuthChallengeCancelAuthenticationChallenge：取消请求
         */
        if (credential) {
            disposition = NSURLSessionAuthChallengeUseCredential;
        } else {
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        }
    } else {
        disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
    }
    //安装证书
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
}

#pragma mark- --TaskDelegate--
//任务完成之后调用--TaskDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    NSError *err = nil;
    id result = [NSJSONSerialization JSONObjectWithData:self.allData options:NSJSONReadingMutableContainers error:&err];
//    NSLog(@"result: %@",result);
    if(err){
        NSLog(@"error = %@",err);
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
