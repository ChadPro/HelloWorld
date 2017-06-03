//
//  QSTCSlideCtlView.m
//  HelloWorld
//
//  Created by Chad Pro on 2017/6/3.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "QSTCSlideCtlView.h"

@interface QSTCSlideCtlView()

@property(nonatomic,strong) UIImageView *slideBarY;
@property(nonatomic,strong) UIImageView *slideBarX;

@property(nonatomic,assign) CGFloat viewCenter;
@property(nonatomic,assign) CGFloat barSize;

@end

@implementation QSTCSlideCtlView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self createUI];
    }
    return self;
}

-(void)createUI{
    _viewCenter = self.frame.size.width;
    _barSize = self.frame.size.width/5;
    
}

@end
