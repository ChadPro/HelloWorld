//
//  HWCreatePlistDataVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/23.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "HWCreatePlistDataVC.h"
#import "SDAutoLayout.h"

#define UIColorFromHex(s,alp)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alp]
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface HWCreatePlistDataVC ()

@property(nonatomic,strong) UITextView *plistView;
@property(nonatomic,strong) UITextField *keyTextField;
@property(nonatomic,strong) UITextField *valueTextField;
@property(nonatomic,strong) UIButton *addBtn;
@property(nonatomic,strong) UIButton *deleteBtn;

@end

@implementation HWCreatePlistDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //文件路径
    NSString *tmpPath = NSTemporaryDirectory();
    NSString *fileName = @"str.plist";
    NSString *path = [tmpPath stringByAppendingPathComponent:fileName];


    
    
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);
    
    _plistView = [[UITextView alloc] init];
    _plistView.backgroundColor = [UIColor blackColor];
    _plistView.textColor = [UIColor whiteColor];
    _plistView.layer.cornerRadius = 8.0;
    [self.view addSubview:_plistView];
    _plistView.sd_layout
    .topSpaceToView(self.view,80)
    .leftSpaceToView(self.view,30)
    .rightSpaceToView(self.view,30)
    .bottomSpaceToView(self.view,105);
    
    _keyTextField = [[UITextField alloc]init];
    _keyTextField.backgroundColor = [UIColor whiteColor];
    _keyTextField.textColor = [UIColor blackColor];
    _keyTextField.layer.cornerRadius = 8.0;
    _keyTextField.placeholder = @"key";
    [self.view addSubview:_keyTextField];
    _keyTextField.sd_layout
    .topSpaceToView(_plistView,15)
    .leftSpaceToView(self.view,30)
    .widthIs((ScreenWidth-75)/2)
    .heightIs(30);
    
    _valueTextField = [[UITextField alloc]init];
    _valueTextField.backgroundColor = [UIColor whiteColor];
    _valueTextField.textColor = [UIColor blackColor];
    _valueTextField.layer.cornerRadius = 8.0;
    _valueTextField.placeholder = @"key";
    [self.view addSubview:_valueTextField];
    _valueTextField.sd_layout
    .topSpaceToView(_plistView,15)
    .rightSpaceToView(self.view,30)
    .widthIs((ScreenWidth-75)/2)
    .heightIs(30);
    
    _addBtn = [[UIButton alloc] init];
    [_addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [_addBtn setBackgroundColor:UIColorFromHex(0xFF8C00, 1.0)];
    _addBtn.layer.cornerRadius = 8.0;
    [_addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addBtn];
    _addBtn.sd_layout
    .topSpaceToView(_keyTextField,15)
    .leftEqualToView(_keyTextField)
    .widthIs((ScreenWidth-75)/2)
    .heightIs(30);

    _deleteBtn = [[UIButton alloc] init];
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteBtn setBackgroundColor:UIColorFromHex(0xFF8C00, 1.0)];
    _deleteBtn.layer.cornerRadius = 8.0;
    [_deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_deleteBtn];
    _deleteBtn.sd_layout
    .topSpaceToView(_valueTextField,15)
    .leftEqualToView(_valueTextField)
    .widthIs((ScreenWidth-75)/2)
    .heightIs(30);
}


- (void)addAction:(UIButton *)btn{
    if((_keyTextField.text.length>0)&&(_valueTextField.text.length>0)){
        
        NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentDirectory = [directoryPaths objectAtIndex:0];
        NSString *filePath = [documentDirectory stringByAppendingPathComponent:@"learn.plist"];
        
        NSMutableDictionary *mutalbeDic = [[NSMutableDictionary alloc]init];
        NSDictionary *dd = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
//        mutalbeDic = [dd copy];
//        [mutalbeDic setObject:_valueTextField.text forKey:_keyTextField.text];
//        NSDictionary *dic = [mutalbeDic copy];
//        
//        [dic writeToFile:filePath atomically:YES];
        
    }else{
        NSLog(@"键值对赋值错误");
    }
}

- (void)deleteAction:(UIButton *)btn{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
