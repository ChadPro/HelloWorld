//
//  HWSelectGoodVC.m
//  HelloWorld
//
//  Created by Ji Ling on 2017/3/6.
//  Copyright © 2017年 Ji Ling. All rights reserved.
//

#import "HWSelectGoodVC.h"
#import "SDAutoLayout.h"
#import "HWGoodAttributesCell.h"

#define UIColorFromHex(s,alp)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:alp]
#define MainScreenWidth [UIScreen mainScreen].bounds.size.width  //屏幕宽度
#define MainScreenHeight [UIScreen mainScreen].bounds.size.height  //屏幕高度

@interface HWSelectGoodVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UIView* topView;
@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UICollectionView* collectionView;
@property(nonatomic,strong) UIButton *addButton;

@property(nonatomic,strong) NSArray *keys;
@property(nonatomic,strong) NSArray *goods;
@property(nonatomic,strong) NSMutableDictionary *selectedAttributes;

@end

@implementation HWSelectGoodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    HWGoodAttributesCell *cell = [[HWGoodAttributesCell alloc]init];
}

- (void)createUI{
    self.view.backgroundColor = UIColorFromHex(0x009966, 1.0);
    
    _topView = [[UIView alloc]init];
    _topView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_topView];
    _topView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topSpaceToView(self.view,64)
    .heightIs(50);
    
    
    _bottomView = [[UIView alloc]init];
    _bottomView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_bottomView];
    _bottomView.sd_layout
    .rightEqualToView(self.view)
    .leftEqualToView(self.view)
    .bottomEqualToView(self.view)
    .heightIs(50);
    
    _addButton = [[UIButton alloc]init];
    [_addButton setBackgroundColor:[UIColor whiteColor]];
    [_addButton setTitle:@"添加购物车" forState:UIControlStateNormal];
    [_addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _addButton.layer.cornerRadius = 5.0;
    [_addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_addButton];
    _addButton.sd_layout
    .centerXEqualToView(_bottomView)
    .topSpaceToView(_bottomView,5)
    .bottomSpaceToView(_bottomView,5)
    .widthIs(100);
   
    [self.view addSubview:self.collectionView];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_keys count];
}

- (void)addAction:(UIButton *)btn{
    NSLog(@"添加购物车成功");
}

- (UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 5.0;
        layout.minimumInteritemSpacing = 5.0;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64+50 ,MainScreenWidth, MainScreenHeight - 50*2 -64) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[HWGoodAttributesCell class] forCellWithReuseIdentifier:@"goodAttributesCell"];
    }
    return _collectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

@end
