//
//  HWArchiverVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/24.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "HWArchiverVC.h"
#import "UserTest1.h"

#define UIColorFromHex(s,alp)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alp]

@interface HWArchiverVC ()

@property(nonatomic,strong) UserTest1 *user;

@end

@implementation HWArchiverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);
    [self test];
}

- (void)test{
    
    NSString *tmpPath = NSTemporaryDirectory();
    NSString *fileName = @"user.archiver";
    NSString *path = [tmpPath stringByAppendingPathComponent:fileName];
    
//    self.user.name = @"Chad Pro";
//    self.user.age = 18;
//    [NSKeyedArchiver archiveRootObject:self.user toFile:path];
    
    self.user = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"name = %@",self.user.name);
    NSLog(@"age = %d",self.user.age);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}



@end
