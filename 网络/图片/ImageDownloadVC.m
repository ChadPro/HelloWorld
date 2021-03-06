//
//  ImageDownloadVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/22.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "ImageDownloadVC.h"
#import "SDAutoLayout.h"

#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

#define UIColorFromHex(s,alp)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alp]

@interface ImageDownloadVC ()

@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UIButton *btn;

@end

@implementation ImageDownloadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);
    
    _imageView = [[UIImageView alloc]init];
    _imageView.layer.cornerRadius = 8.0;
    _imageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_imageView];
    _imageView.sd_layout
    .leftSpaceToView(self.view,20)
    .rightSpaceToView(self.view,20)
    .topSpaceToView(self.view,80)
    .heightIs(200);
    
    _btn = [[UIButton alloc]init];
    [_btn setTitle:@"GO!" forState:UIControlStateNormal];
    [_btn setBackgroundColor:UIColorFromHex(0xFF8C00, 1.0)];
    [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _btn.layer.cornerRadius = 8.0;
    [_btn addTarget:self action:@selector(downloadImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    _btn.sd_layout
    .topSpaceToView(_imageView,15)
    .centerXEqualToView(self.view)
    .heightIs(30)
    .widthIs(100);
}

#pragma mark-- --网络获取--
//获取网路数据
- (void)downloadImage:(UIButton *)btn{
    [self getImageWithNSURLSession1:btn];  //用NSURLSessionDataTask
//    [self getImageWithNSURLSession2:btn];  //用NSURLSessionDownloadTask
//    [self getImageWithAFNetworking1:btn];   //用AFNetworkging
//    [self getImageWithAFNetworking2:btn];   //用AFNetworkging
}

//用iOS-NSURLSession获取图片数据--DataTask
- (void)getImageWithNSURLSession1:(UIButton *)btn{
    //1.获的session，如果用代理的话，要用另外获得session的方式
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2.请求request
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.77:33333/main/imageFile/download/logo.png"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    //3.创建任务Task
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //解析数据
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [[UIImage alloc]initWithData:data];
            self.imageView.image = image;
        });
    }];

    //4.开始任务
    [dataTask resume];
}

//用iOS-NSURLSession获取图片数据--DownloadTask
- (void)getImageWithNSURLSession2:(UIButton *)btn{
    //1.获得session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    
    //2.请求request
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.77:33333/main/imageFile/download/logo.png"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    //3.创建任务Task
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       dispatch_async(dispatch_get_main_queue(), ^{
           NSData *data = [NSData dataWithContentsOfURL:location];
           UIImage *image = [UIImage imageWithData:data];
           _imageView.image = image;
       });
    }];
    
    //4.开始任务
    [downloadTask resume];
}

//用AFNetworking获取图片数据
- (void)getImageWithAFNetworking1:(UIButton *)btn{
    //1.创建 HTTP manager ，并设置请求/获取数据格式
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //2.设置 url
    NSString *url =@"http://192.168.1.77:33333/main/imageFile/download/logo.png";
    
    //3.开始网络请求
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //使用网络数据
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:responseObject];
            self.imageView.image = image;
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

//用AFNetworking获取图片数据
- (void)getImageWithAFNetworking2:(UIButton *)btn{
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.77:33333/main/imageFile/download/logo.png"];
    [self.imageView setImageWithURL:url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
