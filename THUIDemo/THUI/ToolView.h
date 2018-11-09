//
//  ToolView.h
//  TH
//
//  Created by TonghuiMac on 2018/10/26.
//  Copyright © 2018 TonghuiMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface ToolView : UIView

/**
 左边按钮事件
 */
@property (nonatomic,copy) void (^LeftClose)(void);

/**
 右边按钮事件
 */
@property (nonatomic,copy) void (^RightAction)(void);

- (void)addBtn:(ToolButton *)btn;//添加btn

- (void)setBtnFrameIsFirst:(bool)isFirst;//最后设置frame

- (void)pushSubviewNibName:(UIView *)aSubviewNibName leftName:(NSString *)aleftName titleName:(NSString *)atitleName rightName:(NSString *)arightName;//toolView打开

- (void)closePushView;

- (void)addMenuView:(UIView *)aSubviewName;

/**
 退出按钮事件
 */
@property (nonatomic,copy) void (^ExitAction)(void);
@end

NS_ASSUME_NONNULL_END
