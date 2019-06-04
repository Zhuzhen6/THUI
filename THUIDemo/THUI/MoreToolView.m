//
//  MoreToolView.m
//  THZT
//
//  Created by TonghuiMac on 2018/10/24.
//  Copyright © 2018 TonghuiMac. All rights reserved.
//

#import "MoreToolView.h"
#import "MoreToolCell.h"
#import "THUIHeader.h"

static NSString *collectionCell = @"mineCell";
@interface MoreToolView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *mineCollection;
@property (nonatomic, strong) NSMutableArray *cellAttributesArray;
@property (nonatomic, assign) CGPoint lastPressPoint;
@property(nonatomic,strong)UIView *bg;
@property(nonatomic,strong)UIView *topView;

@end

@implementation MoreToolView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        {
            [self tapBtnToShareF];
        }
    }
    return self;
}

- (NSMutableArray *)imagesArray{
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}

- (NSMutableArray *)cellAttributesArray{
    if (!_cellAttributesArray) {
        self.cellAttributesArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _cellAttributesArray;
}


-(void)tapBtnToShareF{
    
    //底部大的透明 view
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    self.bg = bgView;
    self.bg.hidden = NO;
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    //创建手势对象
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnce:)];
    //点击的次数
    tap.numberOfTouchesRequired = 1;
    [self.bg addGestureRecognizer:tap];
    
    //透明 view 上在贴个 view
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    topView.alpha = 1.0;
    topView.frame = self.frame;
    topView.layer.cornerRadius = 6;
    topView.layer.masksToBounds = YES;
    self.topView = topView;
    self.topView.hidden = NO;
    [[UIApplication sharedApplication].keyWindow addSubview:topView];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:topView];
    
    _lastPressPoint = CGPointZero;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 5.0;
    layout.minimumInteritemSpacing = 5.0;
    layout.sectionInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    _mineCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 200, 200) collectionViewLayout:layout];
    _mineCollection.backgroundColor = [UIColor whiteColor];
    _mineCollection.dataSource = self;
    _mineCollection.delegate = self;
    [_mineCollection registerClass:[MoreToolCell class] forCellWithReuseIdentifier:collectionCell];
    [_topView addSubview:_mineCollection];
    
    _topView.transform=CGAffineTransformMakeScale(0.3f, 0.3f);//先让要显示的view最小直至消失
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];//InOut 表示进入和出去时都启动动画
    [UIView setAnimationDuration:0.5f];//动画时间
    _topView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);//将要显示的view按照正常比例显示出来
    [UIView commitAnimations]; //启动动画
}


/**
 

 @param tapGes 关闭后调整顺序
 */
-(void)tapOnce:(UITapGestureRecognizer *)tapGes{
    self.bg.hidden = YES;
    self.topView.hidden = YES;
    if (_delegate && [_delegate respondsToSelector:@selector(changeToolListArr:)]) {
        [_delegate changeToolListArr:self.imagesArray];
    }
}

- (void)hideView{
    self.bg.hidden = YES;
    self.topView.hidden = YES;
        if (_delegate && [_delegate respondsToSelector:@selector(changeToolListArr:)]) {
        [_delegate changeToolListArr:self.imagesArray];
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imagesArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(60,60);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MoreToolCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesture:)];
    [cell addGestureRecognizer:longPress];
    ToolButton *btn = self.imagesArray[indexPath.row];
    btn.frame = CGRectMake(5.0, 5.0, cell.frame.size.width - 10.0, cell.frame.size.height - 10.0);
    [btn addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:btn];
    return cell;
}

- (void)longPressGesture:(UILongPressGestureRecognizer *)sender{
    MoreToolCell *cell = (MoreToolCell *)sender.view;
    NSIndexPath *cellIndexPath = [_mineCollection indexPathForCell:cell];
    [_mineCollection bringSubviewToFront:cell];
    BOOL isChanged = NO;
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self.cellAttributesArray removeAllObjects];
        for (int i = 0;i< self.imagesArray.count; i++) {
            [self.cellAttributesArray addObject:[_mineCollection layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
        }
        self.lastPressPoint = [sender locationInView:_mineCollection];
    }else if (sender.state == UIGestureRecognizerStateChanged){
        cell.center = [sender locationInView:_mineCollection];
        for (UICollectionViewLayoutAttributes *attributes in self.cellAttributesArray) {
            if (CGRectContainsPoint(attributes.frame, cell.center) && cellIndexPath != attributes.indexPath) {
                isChanged = YES;
                //对数组中存放的元素重新排序
                ToolButton *toolBtn = self.imagesArray[cellIndexPath.row];
                [self.imagesArray removeObjectAtIndex:cellIndexPath.row];
                [self.imagesArray insertObject:toolBtn atIndex:attributes.indexPath.row];
                [self.mineCollection moveItemAtIndexPath:cellIndexPath toIndexPath:attributes.indexPath];
                
                [self.mineCollection reloadData];
            }
        }
        
    }else if (sender.state == UIGestureRecognizerStateEnded) {
        if (!isChanged) {
            cell.center = [_mineCollection layoutAttributesForItemAtIndexPath:cellIndexPath].center;
        }
        //        NSLog(@"排序后---%@",self.imagesArray);
    }
    
}

@end
