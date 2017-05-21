//
//  SlideControlView.h
//  HelloWorld
//
//  Created by Chad Pro on 2017/5/21.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlideControlDelegate <NSObject>

- (void)slideControlFloatBack:(CGFloat)slideNum controlType:(NSInteger)type;

@end

@interface SlideControlView : UIView

@property(nonatomic,weak)id<SlideControlDelegate>controlDelegate;

@end
