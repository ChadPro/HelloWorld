//
//  SlideControlView.m
//  HelloWorld
//
//  Created by Chad Pro on 2017/5/21.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "SlideControlView.h"

@interface SlideControlView()

@property(nonatomic,strong)UIView *squareView;

@end

@implementation SlideControlView

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        [self createUI];
    }
    return self;
}

- (void)createUI{
    CGFloat sqV_w = self.frame.size.width;
    CGFloat sqV_h = sqV_w;
    CGFloat sqV_x = 0;
    CGFloat sqV_y = self.frame.size.height/2 - sqV_h/2;
    
    _squareView = [[UIView alloc]initWithFrame:CGRectMake(sqV_x, sqV_y, sqV_w, sqV_h)];
    _squareView.backgroundColor = [UIColor greenColor];
    _squareView.layer.cornerRadius = 5.0;
    [self addSubview:_squareView];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self addGestureRecognizer:panGesture];

}

- (void)handlePan:(UIPanGestureRecognizer *)pan{
    
    //当停止滑动时
    if((pan.state == UIGestureRecognizerStateEnded) || (pan.state == UIGestureRecognizerStateFailed)){
        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
            CGFloat sqV_y = self.frame.size.height/2 - self.frame.size.width/2;
            _squareView.frame = CGRectMake(_squareView.frame.origin.x, sqV_y, _squareView.frame.size.width, _squareView.frame.size.height);
        } completion:^(BOOL finish){
        }];
    }else{ //滑动块时
        CGPoint point = [pan translationInView:self];
        CGFloat yy = point.y;
        
        CGFloat absY = fabs(yy);
        CGFloat sqV_y = 0;
        
        if(absY>(self.frame.size.height/2 - self.frame.size.width/2)){
            if(yy>0){
                sqV_y = self.frame.size.height - self.frame.size.width - 1;
            }else{
                sqV_y = 1;
            }
        }else{
            sqV_y = self.frame.size.height/2 - self.frame.size.width/2 +yy;
        }
        
        if((sqV_y>0)&&(sqV_y<(self.frame.size.height-self.frame.size.width))){
            [_squareView setFrame:CGRectMake(_squareView.frame.origin.x, sqV_y, _squareView.frame.size.width, _squareView.frame.size.height)];
        }
        
        
        if(yy<0){
            CGFloat num = self.frame.size.height/2 - self.frame.size.width/2 - _squareView.frame.origin.y;
            [self.controlDelegate slideControlFloatBack:num controlType:1];
        }else{
            CGFloat num = _squareView.frame.origin.y - (self.frame.size.height/2 - self.frame.size.width/2);
            [self.controlDelegate slideControlFloatBack:num controlType:2];
        }
    }
}



@end
