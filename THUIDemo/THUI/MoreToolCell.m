//
//  MoreToolCell.m
//  THZT
//
//  Created by TonghuiMac on 2018/10/24.
//  Copyright © 2018 TonghuiMac. All rights reserved.
//

#import "MoreToolCell.h"
#import "THUIHeader.h"


@implementation MoreToolCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.btn = [[ToolButton alloc] initWithFrame:CGRectMake(5.0, 5.0, self.frame.size.width - 10.0, self.frame.size.height - 10.0)];
    [self.btn setBackgroundColor:LEFT_SLIDE_HIGHTLIGHT_COLOR];
    [self.contentView addSubview:self.btn];
}

@end
