//
//  XAGuidePage.m
//  DingDongAngel
//
//  Created by Sure on 2018/12/22.
//  Copyright © 2018年 JOBO. All rights reserved.
//

#import "XAGuidePage.h"

#define XAGPSCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define XAGPSCREENHEIGHT [UIScreen mainScreen].bounds.size.height
///判断是不是刘海屏
#define XAIsiPhoneXClass [UIScreen mainScreen].bounds.size.width >= 375.0f && [UIScreen mainScreen].bounds.size.height >= 812.0f
#define XAGPFlag @"XAGPSaveFlag"

@implementation XAGuidePage

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = self.frame;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:CGRectMake(0, 0, XAGPSCREENWIDTH, XAGPSCREENHEIGHT)];
    if (self) {
        [self addSubview:self.scrollView];
    }
    return self;
}

/**
 消失
 */
- (void)removeSelf
{
    //调用回调
    if (self.dissmissBlock) {
        self.dissmissBlock();
    }
    [self removeFromSuperview];
}

/**
 显示
 */
- (void)show
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary* infoDictionary=[[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString* app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    NSString* app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSString *key = [NSString stringWithFormat:@"%@_%@",app_Version,app_build];
    NSString *saveKey = [userDefaults objectForKey:XAGPFlag];
    //在版本或build变更时,会显示
    if (![key isEqualToString:saveKey]) {
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        [window addSubview:self];
        [userDefaults setValue:key forKey:XAGPFlag];
        [userDefaults synchronize];
    }else {
        //直接调用回调
        if (self.dissmissBlock) {
            self.dissmissBlock();
        }
    }
}

- (void)setImageArr:(NSArray<NSString *> *)imageNameArr buttonImageArr:(NSArray<NSString *> *)btnImageNameArr
{
    for (int i = 0; i < imageNameArr.count; i++) {
        NSString *imageName = imageNameArr[i];
        NSString *btnImageName = btnImageNameArr[i];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        [self.scrollView addSubview:imageView];
        imageView.frame = CGRectMake(i*XAGPSCREENWIDTH, 0, XAGPSCREENWIDTH, XAGPSCREENHEIGHT);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setBackgroundImage:[UIImage imageNamed:btnImageName] forState:UIControlStateNormal];
        button.bounds = CGRectMake(0, 0, 350, 100);
        if (XAIsiPhoneXClass) {
            button.center = CGPointMake(XAGPSCREENWIDTH/2.0, XAGPSCREENHEIGHT-(button.bounds.size.height/2.0)-100);
        }else {
            button.center = CGPointMake(XAGPSCREENWIDTH/2.0, XAGPSCREENHEIGHT-(button.bounds.size.height/2.0)-50);
        }
        [button addTarget:self action:@selector(removeSelf) forControlEvents:UIControlEventTouchUpInside];
        button.userInteractionEnabled = YES;
        imageView.userInteractionEnabled = YES;
        [imageView addSubview:button];
    }
    self.scrollView.contentSize = CGSizeMake(XAGPSCREENWIDTH*imageNameArr.count, XAGPSCREENHEIGHT);
}

#pragma mark -
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            //禁用自动预留行高
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _scrollView;
}
@end
