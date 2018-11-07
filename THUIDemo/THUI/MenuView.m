//
//  MenuView.m
//  TH
//
//  Created by TonghuiMac on 2018/11/6.
//  Copyright © 2018 TonghuiMac. All rights reserved.
//

#import "MenuView.h"
#import "THUIHeader.h"
#import "ToolButton.h"

@interface MenuView ()
@property (nonatomic, strong) NSMutableArray <UIView *> *viewArray;
@property (nonatomic, strong) UIView *menuView;
@end

@implementation MenuView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addUI];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self setBtnFrame];
}
- (void)addUI{
    
    self.viewArray = [[NSMutableArray alloc]init];
    
    self.menuView = [[UIView alloc] init];
    self.menuView.backgroundColor = LEFT_SLIDE_HIGHTLIGHT_COLOR;
    self.menuView.layer.cornerRadius = 4;
    [self addSubview:self.menuView];
}

- (void)setBtnFrame{
    
    CGFloat Size = 56;
    CGFloat Width = 0;
    CGFloat  y0 = 1;
    NSUInteger iConut = self.viewArray.count;
    for (int i = 0; i<iConut; i++) {
        Width =  self.viewArray[i].frame.size.width;
        self.viewArray[i].frame = CGRectMake(y0, 0, Width, Size);
        y0 += Width;
    }
    
    ToolButton *exitBtn = [[ToolButton alloc]init];
    [exitBtn btnWithName:@"退出" imgName:@"\U0000e916"];
    exitBtn.frame = CGRectMake(y0+3, 0, 50, Size);
    [exitBtn addTarget:self action:@selector(exitAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.menuView addSubview:exitBtn];
    
    CGFloat  menuViewWidth = y0 + 50 + 3;
    self.menuView.frame = CGRectMake(0, 0, menuViewWidth, Size);
}

- (void)addView:(UIView *)view{
    
    [self.menuView addSubview:view];
    [self.viewArray addObject:view];
}



-(void)exitAction:(UIButton*)btn{
    [self closeMenuView];
    if (self.ExitAction) {
        [self ExitAction];
    }
}

- (void)closeMenuView{
    [self removeFromSuperview];
}
@end
