//
//  NavTarView.m
//  TH
//
//  Created by TonghuiMac on 2018/11/1.
//  Copyright © 2018 TonghuiMac. All rights reserved.
//

#import "NavTarView.h"
#import "THUIHeader.h"

@implementation NavTarView{
    

    UIButton *leftBtn;
    UIButton *rightBtn;
    UILabel *titleLab;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addNavTarView];
    }
    return self;
}

-(void)addNavTarView{
    
    self.backgroundColor = LEFT_SLIDE_TINT_COLOR;
    leftBtn = [[UIButton alloc]init];
    [leftBtn setTitleColor:LEFT_SLIDE_HIGHTLIGHT_COLOR_X forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    leftBtn.frame = CGRectMake(0, 0, 60, 46);
    [leftBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    
    rightBtn = [[UIButton alloc]init];
    rightBtn.frame = CGRectMake(Push_View_Width-80, 0, 80, 46);
    [rightBtn setTitleColor:LEFT_SLIDE_HIGHTLIGHT_COLOR_X forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    
    titleLab = [[UILabel alloc]init];
    titleLab.frame = CGRectMake(40, 0, Push_View_Width-100, 46);
    titleLab.textAlignment = NSTextAlignmentCenter;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [self addSubview:titleLab];
}

-(void)layoutSubviews{
    [super layoutSubviews];
}
#pragma mark - =============== NavAction ==============

-(void)leftAction:(UIButton *)sender{
    
    if (self.LeftClose) {
        self.LeftClose();
    }
    
}

-(void)rightAction:(UIButton *)sender{
    
    if (self.RightAction) {
        self.RightAction();
    }
}


-(void)setLeftName:(NSString *)leftName setTitleName:(NSString *)titleName setRightName:(NSString *)rightName{
    
        [rightBtn setTitle:rightName forState:UIControlStateNormal];
        titleLab.text = titleName;
        [leftBtn setTitle:leftName forState:UIControlStateNormal];
}
@end
