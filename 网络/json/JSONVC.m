//
//  JSONVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/21.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "JSONVC.h"
#import "AFNetworking.h"
#import "SDAutoLayout.h"

#define UIColorFromHex(s,alp)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alp]


@interface JSONVC ()

@property(nonatomic,strong) UITextView *logView;
@property(nonatomic,strong) UITextField *parametersTextView;


@end

@implementation JSONVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"Go" forState:UIControlStateNormal];
    [btn setBackgroundColor:UIColorFromHex(0xFF8C00, 1.0)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 8.0;
    [btn addTarget:self action:@selector(getData:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.sd_layout
    .centerXEqualToView(self.view)
    .widthIs(100)
    .heightIs(30)
    .bottomSpaceToView(self.view,30);
    
    _parametersTextView = [[UITextField alloc]init];
    _parametersTextView.backgroundColor = [UIColor blackColor];
    _parametersTextView.textColor = [UIColor whiteColor];
    _parametersTextView.layer.cornerRadius =8.0;
    [self.view addSubview:_parametersTextView];
    _parametersTextView.sd_layout
    .centerXEqualToView(self.view)
    .bottomSpaceToView(btn,15)
    .widthIs(100)
    .heightIs(30);
    
    _logView = [[UITextView alloc] init];
    _logView.backgroundColor = [UIColor blackColor];
    _logView.textColor = [UIColor whiteColor];
    _logView.layer.cornerRadius = 8.0;
    [_logView setFont:[UIFont systemFontOfSize:20]];
    [self.view addSubview:_logView];
    _logView.sd_layout
    .topSpaceToView(self.view,90)
    .leftSpaceToView(self.view,15)
    .rightSpaceToView(self.view,15)
    .bottomSpaceToView(_parametersTextView,15);
}

#pragma mark- --网络获取函数--
//选择用哪一种网络获取方式
- (void)getData:(UIButton *)btn{
    [self getJsWithNSUrlSession:btn];
}

//使用iOS自带网络session
- (void)getJsWithNSUrlSession:(UIButton *)btn{
    //1.获的session，如果用代理的话，要用另外获得session的方式
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2.请求request
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
    if((_parametersTextView.text!=nil)&&(_parametersTextView.text.length>0)){
        [mutableDic setObject:_parametersTextView.text forKey:@"userID"];
    }else{
        NSLog(@"输入的userID错误");
        return;
    }
    NSDictionary *parameters = [mutableDic copy];
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.77:33333/main/js/user"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [self dicToData:parameters];
    
    //3.创建任务Task
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //解析数据
        NSError *err = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
        
        NSLog(@"dic = %@",dic);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *dicString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            self.logView.text = dicString;
        });
    }];
    
    //4.开始任务
    [dataTask resume];
}


//使用AFNetworking
- (void)getJsWithAFNetworking:(UIButton *)btn{
    
}


//dic -> data
-(NSData *)dicToData:(NSDictionary *)dic{
    NSError *error = nil;
    return [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
