//
//  MoreToolView.h
//  THZT
//
//  Created by TonghuiMac on 2018/10/24.
//  Copyright © 2018 TonghuiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol changeToolListArrDelegate <NSObject>

-(void)changeToolListArr:(NSMutableArray *)toolListArr;
@end

@interface MoreToolView : UIView
@property(nonatomic,weak) id<changeToolListArrDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *imagesArray;
@end

NS_ASSUME_NONNULL_END
