//
//  HHHintView.h
//  HHHintViewDemo
//
//  Created by lingaohe on 5/23/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import <UIKit/UIKit.h>

//
#pragma mark ---
typedef enum{
  HHHintViewPositionTop = 1, //停留在页面的顶部
  HHHintViewPositionMiddle = 2, //停留在页面的中间
  HHHintViewPositionBottom = 3, //停留在页面的底部
  HHHintViewPositionCustom  //自己设置
}HHHintViewPositionType;//停留的位置

typedef enum{
  HHHintViewAnimationStartTop = 0,
	HHHintViewAnimationStartRight,
	HHHintViewAnimationStartBottom,
	HHHintViewAnimationStartLeft,
	HHHintViewAnimationStartTopLeft,
	HHHintViewAnimationStartTopRight,
	HHHintViewAnimationStartBottomLeft,
	HHHintViewAnimationStartBottomRight,
  HHHintViewAnimationStartCenter,
  HHHintViewAnimationStartCustom //自己设置
}HHHintViewAnimationStartPoint; //页面显示动画的起始位置

typedef enum{
  HHHintViewAnimationFade = 0,
  HHHintViewAnimationDrop,
  HHHintViewAnimationSlide,
  HHHintViewAnimationBounce,
  HHHintViewAnimationSwirl,
  HHHintViewAnimationZoom
}HHHintViewAnimationType; //页面动画的效果

typedef enum{
  HHHintViewMaskNone = 0,  //没有覆盖
  HHHintViewMaskSuperView  //覆盖住SuperView
}HHHintViewMaskType; //覆盖的范围
//
#pragma mark ---
@interface HHHintView : UIView
@property (nonatomic, assign) HHHintViewPositionType positionType;
@property (nonatomic, assign) HHHintViewAnimationStartPoint startPoint;
@property (nonatomic, assign) HHHintViewAnimationType animationType;
@property (nonatomic, assign) HHHintViewMaskType maskType;
@property (nonatomic, assign) CGPoint customStartCenter; //自定义动画的起始位置

//设置ContentView，ContentView包含要显示的内容
- (id)initWithContentView:(UIView *)contentView;
//设置展示的类型
//设置页面的位置及出现的动画
- (void)setupPositionType:(HHHintViewPositionType)positionType animationType:(HHHintViewAnimationType)animationType;
//设置页面出现动画的起始位置,customStartPoint只有在startPoint的类型设置为HHHintViewAnimationStartCustom时才有用，因为其他类型的时候，customStartPoint是计算出来的
- (void)setupStartPoint:(HHHintViewAnimationStartPoint)startPoint customStartCenter:(CGPoint)customStartPoint;
//不同的展示方式
- (void)showInView:(UIView *)view;
- (void)showInView:(UIView *)view duration:(CGFloat)duration;
- (void)showInView:(UIView *)view tapDismiss:(BOOL)tapDismiss;
//
- (void)dismissHintView;
- (void)dismissHintViewAnimated:(BOOL)animated;
@end
