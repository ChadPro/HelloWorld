//
//  QSTCSlideCtlView.m
//  HelloWorld
//
//  Created by Chad Pro on 2017/6/3.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "QSTCSlideCtlView.h"

@interface QSTCSlideCtlView()

@property(nonatomic,strong) UIImageView *slideBarY; //Y轴滑杆
@property(nonatomic,strong) UIImageView *slideBarX; //X轴滑杆

@property(nonatomic,assign) CGFloat viewCenter; //视图中心
@property(nonatomic,assign) CGFloat barSize;    //滑杆Size
@property(nonatomic,assign) CGFloat viewSize;   //视图Size

@end

@implementation QSTCSlideCtlView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self createUI];
    }
    return self;
}

- (void)createUI{
    _viewCenter = self.frame.size.width/2;
    _barSize = self.frame.size.width/5;
    _viewSize = self.frame.size.width;
    self.userInteractionEnabled = YES;
    
    /************ Self ******************
     */
    self.backgroundColor = [UIColor blackColor];
    self.layer.cornerRadius = 8.0;
    
    /************ SlideBarY *************
     */
    _slideBarY = [[UIImageView alloc] initWithFrame:CGRectMake(0, _viewCenter-_barSize/2, _viewSize, _barSize)];
    _slideBarY.backgroundColor = [UIColor grayColor];
    _slideBarY.layer.cornerRadius = 8.0;
    [self addSubview:_slideBarY];
    _slideBarY.userInteractionEnabled = YES;
    
    /************ SlideBarX *******************
     */
    _slideBarX = [[UIImageView alloc] initWithFrame:CGRectMake(_viewCenter-_barSize/2, 0, _barSize, _barSize)];
    _slideBarX.backgroundColor = [UIColor blueColor];
    _slideBarX.layer.cornerRadius = 8.0;
    [_slideBarY addSubview:_slideBarX];
    
    UIPanGestureRecognizer *xPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
    [_slideBarX addGestureRecognizer:xPanGesture];
    _slideBarX.userInteractionEnabled = YES;
}


- (void)panHandle:(UIPanGestureRecognizer *)pan{
    
    //当停止滑动时
    if((pan.state == UIGestureRecognizerStateEnded) || (pan.state == UIGestureRecognizerStateFailed)){
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
            [_slideBarY setFrame:CGRectMake(0, _viewCenter - _barSize/2, _viewSize, _barSize)];
            [_slideBarX setFrame:CGRectMake(_viewCenter-_barSize/2, 0, _barSize, _barSize)];
        } completion:^(BOOL finish){
        }];
    }else{ //滑动块时
        CGPoint point = [pan translationInView:self];
        CGFloat yy = point.y;   //在self中滑动距离
        CGFloat xx = point.x;
        
        CGFloat absY = fabs(yy);    //滑动距离绝对值
        CGFloat absX = fabs(xx);
        CGFloat barMove_y = 0;
        CGFloat barMove_x = 0;
        
        //对于Y轴 -- barMove_y
        if(absY > (_viewSize/2-_barSize/2)){  //当滑块到达极值时
            if(yy>0){   //向下滑
                barMove_y = _viewSize - _barSize - 0;
            }else{  //向上滑
                barMove_y = 1;
            }
        }else{
            barMove_y = _viewCenter - _barSize/2 + yy;
        }
        //对于X轴 -- barMove_x
        if(absX > (_viewSize/2-_barSize/2)){
            if(xx>0){
                barMove_x = _viewSize - _barSize - 0;
            }else{
                barMove_x = 1;
            }
        }else{
            barMove_x = _viewCenter - _barSize/2 + xx;
        }
        
        
        [_slideBarY setFrame:CGRectMake(0, barMove_y, _viewSize, _barSize)];
        [_slideBarX setFrame:CGRectMake(barMove_x, 0, _barSize, _barSize)];
        CGFloat slidexNum = (barMove_x-(_viewSize/2-_barSize/2))/(_viewSize/2-_barSize/2);
        CGFloat slideyNum = (barMove_y-(_viewSize/2-_barSize/2))/(_viewSize/2-_barSize/2);
        [self.ctlDelegate slideControlFloatBack:slidexNum controlType:0];
        [self.ctlDelegate slideControlFloatBack:slideyNum controlType:1];
    }
}

@end
