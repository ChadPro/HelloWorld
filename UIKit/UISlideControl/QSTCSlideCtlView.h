//
//  QSTCSlideCtlView.h
//  HelloWorld
//
//  Created by Chad Pro on 2017/6/3.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlideBarCtlDelegate <NSObject>

- (void)slideControlFloatBack:(CGFloat)slideNum controlType:(NSInteger)type;

@end

@interface QSTCSlideCtlView : UIImageView

@property(nonatomic,weak)id<SlideBarCtlDelegate> ctlDelegate;

@end
