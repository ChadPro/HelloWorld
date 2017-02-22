//
//  OneImageULVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/22.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "OneImageULVC.h"
#import "SDAutoLayout.h"
#import "AFNetworking.h"

#define UIColorFromHex(s,alp)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alp]
#define MainScreenWidth [UIScreen mainScreen].bounds.size.width  //屏幕宽度
#define MainScreenHeight [UIScreen mainScreen].bounds.size.height  //屏幕高度

@interface OneImageULVC ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic,strong) UIImageView *imageView;

@end

@implementation OneImageULVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI{
        self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);
    
    //
    UIView *bottomBar = [[UIView alloc] init];
    bottomBar.backgroundColor = [UIColor grayColor];
    bottomBar.userInteractionEnabled = YES;
    [self.view addSubview:bottomBar];
    bottomBar.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view)
    .heightIs(50);
    
    _imageView = [[UIImageView alloc]init];
    _imageView.backgroundColor = [UIColor grayColor];
    _imageView.layer.cornerRadius = 8.0;
    [self.view addSubview:_imageView];
    _imageView.sd_layout
    .leftSpaceToView(self.view,30)
    .rightSpaceToView(self.view,30)
    .topSpaceToView(self.view,100)
    .bottomSpaceToView(bottomBar,100-64);
    
    UIButton *btnPhotos = [[UIButton alloc]init];
    [btnPhotos setTitle:@"相册" forState:UIControlStateNormal];
    [btnPhotos setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnPhotos setBackgroundColor:[UIColor whiteColor]];
    [btnPhotos addTarget:self action:@selector(openPhotosLibrary) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:btnPhotos];
    btnPhotos.sd_layout
    .leftSpaceToView(bottomBar,10)
    .centerYEqualToView(bottomBar)
    .heightIs(30)
    .widthIs((MainScreenWidth-40)/3);
    
    UIButton *btnCameral = [[UIButton alloc] init];
    [btnCameral setTitle:@"相机" forState:UIControlStateNormal];
    [btnCameral setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnCameral setBackgroundColor:[UIColor whiteColor]];
    [btnCameral addTarget:self action:@selector(openCamera) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:btnCameral];
    btnCameral.sd_layout
    .leftSpaceToView(btnPhotos,10)
    .centerYEqualToView(bottomBar)
    .heightIs(30)
    .widthIs((MainScreenWidth-40)/3);
    
    UIButton *btnSend = [[UIButton alloc] init];
    [btnSend setTitle:@"发送" forState:UIControlStateNormal];
    [btnSend setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSend setBackgroundColor:[UIColor whiteColor]];
    [btnSend addTarget:self action:@selector(sendFile) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:btnSend];
    btnSend.sd_layout
    .leftSpaceToView(btnCameral,10)
    .centerYEqualToView(bottomBar)
    .heightIs(30)
    .widthIs((MainScreenWidth-40)/3);
}

#pragma mark- ---相机&相册代理---
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //选择完成后dismiss选择控制器，同时处理选择的图
    [picker dismissViewControllerAnimated:YES completion:^
     {
         //info中有选中图片的全部信息，根据需要去获取，此处获取的为原图
         UIImage *choiceImage = [info objectForKey:UIImagePickerControllerOriginalImage];
         
         if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
         {
             //若为相机拍摄则保存到相册
             UIImageWriteToSavedPhotosAlbum(choiceImage, NULL, NULL, NULL);
             self.imageView.image = choiceImage;
         }else if(picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary)
         {
             //若为相册
             self.imageView.image = choiceImage;
         }
     }];
}


#pragma mark- ---按钮action---
//打开相册action
-(void)openPhotosLibrary{
    BOOL isPhotosLibraryAvailabel = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    if(isPhotosLibraryAvailabel){
        UIImagePickerController *photoLibraryPicker = [[UIImagePickerController alloc]init];
        photoLibraryPicker.delegate = self;
        [self presentViewController:photoLibraryPicker animated:YES completion:nil];
        
    }else{
        NSLog(@"无法进入相册");
    }
}

//打开相机action
-(void)openCamera{
    BOOL isCameraAvailabel = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    
    if(isCameraAvailabel){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        NSLog(@"无法打开相机");
    }
}

//发送文件action
-(void)sendFile{
    [self sendByNSURLSession];  //用iOS-NSURLSession
//    [self sendByAfnetworking];  //用AFNetworking
}

#pragma mark- ---发送图片---
//用iOS-NSURLSession
- (void)sendByNSURLSession{
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.77:33333/main/imageFile/upload/logo.png"];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//
//    NSString *boundary = @"boundary=---------------827292";
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data;boundary=%@",boundary];
//    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPMethod:@"POST"];
//    //******
//    NSMutableString *bodyHead = [[NSMutableString alloc]init];
//    NSMutableData *multableData = [[NSMutableData alloc]init];
//    
//    NSString *name = @"one";
//    NSString *fileName = @"one.png";
//    
//    NSData *imageData =UIImagePNGRepresentation(self.imageView.image);
//    //*****
//    NSString *beginBoundary = @"--827292";
//    NSString *endBoundary = @"827292--";
//    [bodyHead appendString:beginBoundary];
//    [bodyHead appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",name,fileName];
//    [bodyHead appendFormat:@"Content-Type: application/png\r\n\r\n"];
//    
//    [multableData appendData:[bodyHead dataUsingEncoding:NSUTF8StringEncoding]];
//    [multableData appendData:imageData];
//    [multableData appendData:[endBoundary dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSURLSession *session = [NSURLSession sharedSession];
//    
//    NSData *data = [multableData copy];
//    
//    NSURLSessionDataTask *dataTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//    }];
//    
//    [dataTask resume];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *name = @"long.png";
    
    NSMutableData *data = [[NSMutableData alloc] init];
    
    NSData *nameData =[name dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData * imagedata = UIImagePNGRepresentation(self.imageView.image);

    [data appendData:nameData];
    [data appendData:imagedata];
    
    NSURLSessionUploadTask * uploadtask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    }];
    
    [uploadtask resume];
}
//用AFNetworking
- (void)sendByAfnetworking{
    //设置网络请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //发送网络请求
    NSString *url=@"http://192.168.1.77:33333/main/imageFile/upload";
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSData *data = UIImagePNGRepresentation(self.imageView.image);
            NSString *name = [NSString stringWithFormat:@"one"];
            NSString *fileName = [NSString stringWithFormat:@"one.png"];
            [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
