//
//  MenuBtnView.h
//  TH
//
//  Created by TonghuiMac on 2018/11/6.
//  Copyright © 2018 TonghuiMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THUIHeader.h"
#import "ToolButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface MenuBtnView : UIView
- (void)addBtn:(ToolButton *)btn;
@property (nonatomic, assign) CGFloat menuBtnViewWidth;
@end

NS_ASSUME_NONNULL_END
