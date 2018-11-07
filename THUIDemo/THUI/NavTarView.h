//
//  NavTarView.h
//  TH
//
//  Created by TonghuiMac on 2018/11/1.
//  Copyright © 2018 TonghuiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NavTarView : UIView

-(void)setLeftName:(NSString *)leftName setTitleName:(NSString *)titleName setRightName:(NSString *)rightName;

/**
 左边按钮事件
 */
@property (nonatomic,copy) void (^LeftClose)(void);

/**
 右边按钮事件
 */
@property (nonatomic,copy) void (^RightAction)(void);

@end

NS_ASSUME_NONNULL_END
