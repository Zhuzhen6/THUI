//
//  ToolButton.m
//  TH
//
//  Created by TonghuiMac on 2018/10/26.
//  Copyright © 2018 TonghuiMac. All rights reserved.
//

#import "ToolButton.h"
#import "THUIHeader.h"

@implementation ToolButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setStyle];
    }
    return self;
}

-(void)setStyle{
    
    self.adjustsTitleTintColorAutomatically = YES;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [self setTintColor:[UIColor whiteColor]];
    self.layer.cornerRadius = 6;
    self.buttonImagePosition = FSCustomButtonImagePositionTop;
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 2, 0);
    [self setBackgroundColor:[UIColor clearColor]];
    self.showsTouchWhenHighlighted = YES;
    self.userInteractionEnabled = YES;
}
- (void)btnWithName:(NSString *)btnName imgName:(NSString *)btnImgName{
    
    [self setTitle:btnName forState:UIControlStateNormal];
    [self setImage:[UIImage iconWithInfo:TBCityIconInfoMake(btnImgName, 26,[UIColor whiteColor])] forState:UIControlStateNormal];
    
}




@end
