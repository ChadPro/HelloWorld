//
//  iOSCodeVCDataSource.h
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/20.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface iOSCodeVCDataSource : NSObject<UITableViewDataSource>

@property(nonatomic,strong) NSArray *titleArray;
@property(nonatomic,strong) NSString *cellIdentifier;

@end
