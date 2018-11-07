//
//  MenuBtnView.m
//  TH
//
//  Created by TonghuiMac on 2018/11/6.
//  Copyright © 2018 TonghuiMac. All rights reserved.
//

#import "MenuBtnView.h"


@interface MenuBtnView ()
@property (nonatomic, strong) NSMutableArray <ToolButton *> *btnArray;
@property (nonatomic, strong) UIView *menuView;
@end


@implementation MenuBtnView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addUI];
    //    self.menuBtnViewWidth = 0.0;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self setBtnFrame];
}
- (void)addUI{
    
    self.btnArray = [[NSMutableArray alloc]init];
    
    self.menuView = [[UIView alloc] init];
    self.menuView.backgroundColor = LEFT_SLIDE_HIGHTLIGHT_COLOR;
    self.menuView.layer.cornerRadius = 6;
    [self addSubview:self.menuView];
}

- (void)setBtnFrame{
    
    CGFloat Size = 56;
    CGFloat Width = 50;
    CGFloat  y0 = 1;
    NSUInteger iConut = self.btnArray.count;
    for (int i = 0; i<iConut; i++) {
        self.btnArray[i].frame = CGRectMake(y0, 0, Width, Size);
        y0 += Width;
    }
    
    self.menuBtnViewWidth = y0+5;
    self.menuView.frame = CGRectMake(0, 0,self.menuBtnViewWidth, Size);

}


/**
 添加btn到数组 视图
 
 @param btn MenuButton
 */
- (void)addBtn:(ToolButton *)btn{
    
    [self.btnArray addObject:btn];
    [self.menuView addSubview:btn];
}

@end
