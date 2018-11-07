//
//  MenuView.h
//  TH
//
//  Created by TonghuiMac on 2018/11/6.
//  Copyright © 2018 TonghuiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuView : UIView
- (void)addView:(UIView *)view;
/**
 退出按钮事件
 */
@property (nonatomic,copy) void (^ExitAction)(void);

- (void)closeMenuView;
@end

NS_ASSUME_NONNULL_END
