//
//  XAGuidePage.h
//  DingDongAngel
//
//  Created by Sure on 2018/12/22.
//  Copyright © 2018年 JOBO. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XAGuidePageDissmissBlock)(void);
@interface XAGuidePage : UIView

/**
 滑动视图
 */
@property (nonatomic , retain)UIScrollView *scrollView;

@property (nonatomic , copy)XAGuidePageDissmissBlock dissmissBlock;

- (void)setImageArr:(NSArray<NSString *> *)imageNameArr buttonImageArr:(NSArray<NSString *> *)btnImageNameArr;

- (void)show;

@end
