//
//  ToolView.m
//  TH
//
//  Created by TonghuiMac on 2018/10/26.
//  Copyright © 2018 TonghuiMac. All rights reserved.
//

#import "ToolView.h"
#import "MoreToolView.h"
#import "NavTarView.h"
#import "THUIHeader.h"


@interface ToolView ()<changeToolListArrDelegate>

@end

@implementation ToolView{
    NSMutableArray <ToolButton *> *btnArray;
    NSMutableArray <ToolButton *> *savebtnArray;
    UIView *mToolBarView;
    ToolButton *moreBtn;
    MoreToolView *moreView;
    UIView *mSlideView;//折叠View
    NavTarView *mNav;//折叠View
    
    UIView *menuView;//横向View
    UIView *mView;//横向View
    
    NSArray *btnFrameArr;
    BOOL isaFirst;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addToolBarView];
        isaFirst = YES;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (isaFirst&&btnFrameArr.count>0) {
        [self setBtnFrameIsFirst:isaFirst];
    }
}
- (void)addToolBarView{
    savebtnArray = [[NSMutableArray alloc]init];
    btnArray = [[NSMutableArray alloc]init];
    mToolBarView = [[UIView alloc] init];
    mToolBarView.backgroundColor = LEFT_SLIDE_HIGHTLIGHT_COLOR;
    mToolBarView.layer.cornerRadius = 6;
    mToolBarView.frame = CGRectMake(ScreenWidth-50, 20, 50, ScreenHeight-40);
    [self addSubview:mToolBarView];
    
    btnFrameArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"btnFrameArr"];
    
}
- (void)setBtnFrameIsFirst:(bool)isFirst{
    CGFloat Size = 56;
    CGFloat  y0 = 1;
    NSUInteger iConut = btnArray.count;
    
    //将所有frame设置为0
    for (int i = 0; i<iConut; i++) {
        
        btnArray[i].frame = CGRectMake(0, 0, 0, 0);
        
    }
    isFirst = btnFrameArr.count==btnArray.count?isFirst:NO;//判断功能的增减
    if (isFirst&&btnFrameArr.count>0) {
        
        for (int i = 0; i<iConut; i++) {
            NSString *titleName = btnFrameArr[i][@"titleName"];
            double orgy = [btnFrameArr[i][@"orgy"] doubleValue];
            for (int j = 0; j<iConut; j++) {
                if ([titleName isEqualToString:btnArray[j].titleLabel.text]) {
                    if (orgy>0) {
                        btnArray[j].frame = CGRectMake(0, orgy, 50, Size);
                    }
                }
            }
        }
        
        isaFirst = NO;
    }else{
        
        NSUInteger j = (iConut>13?12:iConut);    //如果iConut大于13则循环数为12
        for (int i = 0; i<j; i++) {
            
            btnArray[i].frame = CGRectMake(0, y0, 50, Size);
            y0 += Size;
            
        }
    }
    
    //超过13个时添加设置moreBtn的Frame
    if (iConut>13) {
        moreBtn = [[ToolButton alloc]init];
        [moreBtn btnWithName:@"更多" imgName:@"\U0000e938"];
        [moreBtn addTarget:self action:@selector(moreAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [mToolBarView addSubview:moreBtn];
        UILongPressGestureRecognizer *morelongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(clearAction:)];
        morelongPress.minimumPressDuration = 1; //定义按的时间
        [moreBtn addGestureRecognizer:morelongPress];
        moreBtn.frame = CGRectMake(0, 672, 50, Size);
        y0 += Size;
    }
    
    [self saveBtnFrame];
}


/**
 保存Frame
 */
- (void)saveBtnFrame{
    NSMutableArray *btnFrameArr = [[NSMutableArray alloc]init];
    for (int i = 0; i<btnArray.count; i++) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        NSString *titleName = btnArray[i].titleLabel.text;
        
        NSString *orgy = [NSString stringWithFormat:@"%.f",btnArray[i].frame.origin.y];
        [dict setObject:titleName forKey:@"titleName"];
        [dict setObject:orgy forKey:@"orgy"];
        [btnFrameArr addObject:dict];
    }
    
    NSArray * array = [NSArray arrayWithArray:btnFrameArr];
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"btnFrameArr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/**
 添加btn到数组 视图
 
 @param btn ToolButton
 */
- (void)addBtn:(ToolButton *)btn{
    
    [btnArray addObject:btn];
    [savebtnArray addObject:btn];
    [mToolBarView addSubview:btn];
}


/**
 推出视图
 
 @param aSubviewNibName 文件名
 @param aleftName 左边按钮名称
 @param atitleName 标题名称
 @param arightName 右边按钮名称
 */
- (void)pushSubviewNibName:(UIView *)aSubviewNibName leftName:(NSString *)aleftName titleName:(NSString *)atitleName rightName:(NSString *)arightName{
    [self changeToolListArr:btnArray];//重新改变Btn 不然点击事件有问题
    
    if(menuView)
    {
        [menuView removeFromSuperview];
        menuView = nil;
    }
    
    if((mSlideView == nil)|| (strcmp(object_getClassName(mSlideView), object_getClassName(aSubviewNibName)) != 0))
    {
        [mSlideView removeFromSuperview];
        mToolBarView.frame =  CGRectMake(ScreenWidth-50-Push_View_Width+3, 20, 50+Push_View_Width, ScreenHeight-40);
        mSlideView = aSubviewNibName;
        mSlideView.backgroundColor = [UIColor whiteColor];
        [self addSubview:mSlideView];
        
        WEAKSELF;
        mNav = [[NavTarView alloc]initWithFrame:CGRectMake(0, 0, Push_View_Width, 44)];
        [mNav setLeftName:aleftName setTitleName:atitleName setRightName:arightName];
        mNav.RightAction = ^{
            
            [weakSelf rightAction];
        };
        mNav.LeftClose = ^{
            [weakSelf leftAction];
        };
        [mSlideView addSubview:mNav];
        
        mSlideView.frame = CGRectMake(ScreenWidth-Push_View_Width, 20, Push_View_Width, self.frame.size.height-40);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.08];
        [UIView setAnimationDelay:0];
        [UIView commitAnimations];
    }
}

/**
 关闭推出视图
 */
-(void)closePushView{
    mToolBarView.frame = CGRectMake(ScreenWidth-50, 20, 50, ScreenHeight-40);
    [self bringSubviewToFront:mToolBarView];//移回顶层
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.08];
    [UIView setAnimationDelay:0];
    [UIView commitAnimations];
    if(mSlideView)
    {
        [mSlideView removeFromSuperview];
        mSlideView = nil;
    }
    if(mNav)
    {
        [mNav removeFromSuperview];
        mNav = nil;
    }
}

/**
 更多按钮
 
 @param btn 添加视图
 */
-(void)moreAction:(UIButton*)btn{
    NSUInteger iConut = btnArray.count;
    //循环建立新的btn 用于界面展示。否则界面会成空白（原因待定...）
    CGFloat Size = 56;
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"btnFrameArr"];
    for (int i = 0; i<iConut; i++) {
        NSString *titleName = array[i][@"titleName"];
        double orgy = [array[i][@"orgy"] doubleValue];
        for (int j = 0; j<iConut; j++) {
            if ([btnArray[j].titleLabel.text isEqualToString:titleName]) {
                if (orgy>0) {
                    ToolButton *btn = [[ToolButton alloc]init];
                    [btn setTitle:btnArray[j].titleLabel.text forState:UIControlStateNormal];
                    [btn setImage:btnArray[j].imageView.image forState:UIControlStateNormal];
                    btn.frame = CGRectMake(0, orgy, 50, Size);
                    [mToolBarView addSubview:btn];
                }
            }
        }
    }
    
    [moreView removeFromSuperview];
    
    moreView = [[MoreToolView alloc]initWithFrame:CGRectMake(mToolBarView.frame.origin.x-200-8, ScreenHeight-220,200,200)];
    moreView.delegate = self;
    moreView.imagesArray = btnArray;
    [self addSubview:moreView];
    
}

/**
 
 @param gestureRecognizer 长按更多清除保存数据
 */
-(void)clearAction:(UILongPressGestureRecognizer *)gestureRecognizer{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"btnFrameArr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [mToolBarView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];//移除所有的子视图
    [self changeToolListArr:savebtnArray];
}
#pragma mark - =============== MoreToolViewDelegete ==============

/**
 
 @param toolListArr 改变后数组操作
 */
-(void)changeToolListArr:(NSMutableArray *)toolListArr{
    
    //转化一次数组，避免操作时还在处理数组 引起奔溃
    NSArray * array = [NSArray arrayWithArray:toolListArr];
    [btnArray removeAllObjects];
    [mToolBarView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];//移除所有的子视图
    //重新添加btn
    for (ToolButton *btn in array) {
        [btnArray addObject:btn];
        [mToolBarView addSubview:btn];
    }
    
    
    [self setBtnFrameIsFirst:NO];
}

#pragma mark - =============== NavAction ==============

-(void)leftAction{
    
    [self closePushView];
    if (self.LeftClose) {
        self.LeftClose();
    }
    
}

-(void)rightAction{
    
    if (self.RightAction) {
        self.RightAction();
    }
}


- (void)addMenuView:(UIView *)aSubviewName{
    
    [self closePushView];
    [self changeToolListArr:btnArray];
    if((menuView == nil) || mView != aSubviewName)
    {
        
        [menuView removeFromSuperview];
        
        menuView = [[UIView alloc] init];
        menuView.backgroundColor = LEFT_SLIDE_HIGHTLIGHT_COLOR;
        menuView.layer.cornerRadius = 4;
        
        mView = aSubviewName;
        [menuView addSubview:mView];
        
        CGFloat Width = mView.frame.size.width + mView.frame.origin.x;
        ToolButton *exitBtn = [[ToolButton alloc]init];
        [exitBtn btnWithName:@"退出" imgName:@"\U0000e916"];
        exitBtn.frame = CGRectMake(Width+5, 0, 50, 56);
        [exitBtn addTarget:self action:@selector(exitAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [menuView addSubview:exitBtn];
        
        menuView.frame = CGRectMake(5, ScreenHeight-110, Width + 5 + 50 , 56);
        [self addSubview:menuView];
    }
}


-(void)exitAction:(UIButton*)btn{
    
    [menuView removeFromSuperview];
    if (self.ExitAction) {
        self.ExitAction();
    }
}
@end
