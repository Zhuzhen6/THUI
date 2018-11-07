//
//  THUIHeader.h
//  THUIDemo
//
//  Created by TonghuiMac on 2018/11/7.
//  Copyright © 2018 TonghuiMac. All rights reserved.
//

#ifndef THUIHeader_h
#define THUIHeader_h

#import "TBCityIconFont.h"
#import "UIImage+TBCityIconFont.h"
#import "FSCustomButton.h"

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define LEFT_SLIDE_TINT_COLOR                    [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1] //头部颜色
#define LEFT_SLIDE_TINT_COLOR2                   [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1]
#define LEFT_SLIDE_HIGHTLIGHT_COLOR_X            [UIColor colorWithRed:0.0 green:0.48 blue:1 alpha:1]//Title颜色
#define LEFT_SLIDE_HIGHTLIGHT_COLOR              [UIColor colorWithRed:0.0 green:0.48 blue:1 alpha:1]//蓝色背景工具栏颜色



#define ToolBar_View_Width        50        //工具栏宽度
#define Push_View_Width           300       //推出视图宽度
#define SLIDE_VIEW_MARGIN_X        4.       //按钮圆角
#define StatusBarH           [UIApplication sharedApplication].statusBarFrame.size.height      //状态栏高度


#define WEAKSELF __weak typeof(self) weakSelf = self

#endif /* THUIHeader_h */
