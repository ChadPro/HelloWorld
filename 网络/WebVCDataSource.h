//
//  WebVCDataSource.h
//  HelloWorld
//
//  Created by Ji Ling on 2017/2/20.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <UIKit/UIKit.h>

@interface WebVCDataSource : NSObject<UITableViewDataSource>

@property(nonatomic,strong) NSString *cellIdentifier;
@property(nonatomic,strong) NSArray *titles;

@end
