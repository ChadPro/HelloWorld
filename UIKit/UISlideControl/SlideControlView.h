//
//  SlideControlView.h
//  HelloWorld
//
//  Created by Chad Pro on 2017/5/21.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlideControlDelegate <NSObject>



@end

@interface SlideControlView : UIView

@property(nonatomic,weak)id<SlideControlDelegate>controlDelegate;

@end
