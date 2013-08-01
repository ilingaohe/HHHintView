//
//  HHHintView.m
//  HHHintViewDemo
//
//  Created by lingaohe on 5/23/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import "HHHintView.h"
#import "UIView+SEAnimations.h"

//Define
//Duration
#define DURATION_OF_ANIMATION 0.3

@interface HHHintView ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSTimer *dismissTimer;
@property (nonatomic, assign) BOOL tapDismiss;

- (void)show;
- (void)show:(NSTimeInterval)duration;
- (void)dismiss;
@end

@implementation HHHintView

#pragma mark -- Init
- (id)initWithContentView:(UIView *)contentView
{
  CGRect frame = contentView.frame;
  if (self = [super initWithFrame:frame]) {
    _contentView = contentView;
    [self addSubview:contentView];
    [self setupData];
  }
  return self;
}
#pragma mark -- Private
- (void)show
{
  [self setupView];
  [self setupAnimationIn];
}
- (void)show:(NSTimeInterval)duration
{
  [self show];
  if (duration > 0) {
    self.dismissTimer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(handleDismissTimer:) userInfo:nil repeats:NO];
  }
}
- (void)dismiss
{
  [self setupAnimationOut];
}
- (void)dismissCompletion
{
  [self removeFromSuperview];
}
#pragma mark -- UIAction
- (void)handleTapDismissBtnAction:(id)sender
{
  [self dismiss];
}
#pragma mark -- NSTimer
- (void)handleDismissTimer:(NSTimer *)timer
{
  if (self.dismissTimer) {
    [self.dismissTimer invalidate];
  }
  [self dismiss];
}
#pragma mark -- SetupData
- (void)setupData
{
  self.positionType = HHHintViewPositionBottom;
  self.startPoint = HHHintViewAnimationStartBottom;
  self.animationType = HHHintViewAnimationSlide;
  self.tapDismiss = NO;
}
- (SEAnimationDirection)animationStartPoint:(HHHintViewAnimationStartPoint)startPoint
{
  SEAnimationDirection direction = kSEAnimationTop;
  if (startPoint == HHHintViewAnimationStartTop) {
    direction = kSEAnimationTop;
  }else if (startPoint == HHHintViewAnimationStartLeft){
    direction = kSEAnimationLeft;
  }else if (startPoint == HHHintViewAnimationStartRight){
    direction = kSEAnimationRight;
  }else if (startPoint == HHHintViewAnimationStartBottom){
    direction = kSEAnimationBottom;
  }else if (startPoint == HHHintViewAnimationStartTopLeft){
    direction = kSEAnimationTopLeft;
  }else if (startPoint == HHHintViewAnimationStartTopRight){
    direction = kSEAnimationTopRight;
  }else if (startPoint == HHHintViewAnimationStartBottomLeft){
    direction = kSEAnimationBottomLeft;
  }else if (startPoint == HHHintViewAnimationStartBottomRight){
    direction = kSEAnimationBottomRight;
  }
  return direction;
}
- (CGPoint)animationStartCenter:(HHHintViewAnimationStartPoint)startPoint forView:(UIView *)view
{
  CGPoint startCenter = view.center;
  CGPoint viewOrigin = view.frame.origin;
  CGSize viewSize = view.frame.size;
  if (startPoint == HHHintViewAnimationStartTop) {
    startCenter = CGPointMake(viewOrigin.x + viewSize.width/2.0f, viewOrigin.y);
  }else if (startPoint == HHHintViewAnimationStartLeft){
    startCenter = CGPointMake(viewOrigin.x, viewOrigin.y + viewSize.height/2.0f);
  }else if (startPoint == HHHintViewAnimationStartRight){
    startCenter = CGPointMake(viewOrigin.x + viewSize.width, viewOrigin.y + viewSize.height/2.0f);
  }else if (startPoint == HHHintViewAnimationStartBottom){
    startCenter = CGPointMake(viewOrigin.x + viewSize.width/2.0f, viewOrigin.y + viewSize.height);
  }else if (startPoint == HHHintViewAnimationStartTopLeft){
    startCenter = CGPointMake(viewOrigin.x, viewOrigin.y);
  }else if (startPoint == HHHintViewAnimationStartTopRight){
    startCenter = CGPointMake(viewOrigin.x + viewSize.width, viewOrigin.y);
  }else if (startPoint == HHHintViewAnimationStartBottomLeft){
    startCenter = CGPointMake(viewOrigin.x, viewOrigin.y + viewSize.height);
  }else if (startPoint == HHHintViewAnimationStartBottomRight){
    startCenter = CGPointMake(viewOrigin.x + viewSize.width, viewOrigin.y + viewSize.height);
  }else if (startPoint == HHHintViewAnimationStartCenter){
    startCenter = view.center;
  }else if (startPoint == HHHintViewAnimationStartCustom){
    startCenter = self.customStartCenter;
  }
  return startCenter;
}
#pragma mark -- UIView
- (void)setupView
{
  //调整位置
  self.backgroundColor = [UIColor clearColor];
  self.frame = self.superview.bounds;
  CGSize parentSize = self.frame.size;
  CGSize contentSize = self.contentView.frame.size;
  if (self.positionType == HHHintViewPositionTop) {
    self.contentView.center = CGPointMake(parentSize.width/2.0f, contentSize.height/2.0f);
  }else if (self.positionType == HHHintViewPositionMiddle){
    self.contentView.center = self.center;
  }else if (self.positionType == HHHintViewPositionBottom){
    self.contentView.center = CGPointMake(parentSize.width/2.0f, parentSize.height-contentSize.height/2.0f);
  }else if (self.positionType == HHHintViewPositionCustom){
    
  }
  //设置TapDismiss背景
  if (self.tapDismiss) {
    UIButton *tapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tapBtn addTarget:self action:@selector(handleTapDismissBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [tapBtn setFrame:self.bounds];
    [self addSubview:tapBtn];
    [self sendSubviewToBack:tapBtn];
  }
}
- (void)setupAnimationIn
{
  SEAnimationDirection direction = [self animationStartPoint:self.startPoint];
  if (self.animationType == HHHintViewAnimationFade) {
    [self.contentView animationFadeInWithDuration:DURATION_OF_ANIMATION];
  }else if (self.animationType == HHHintViewAnimationSlide){
    [self.contentView animationSlideInWithDirection:direction boundaryView:self duration:DURATION_OF_ANIMATION];
  }else if (self.animationType == HHHintViewAnimationSwirl){
    [self.contentView animationSwirlInWithDuration:DURATION_OF_ANIMATION];
  }else if (self.animationType == HHHintViewAnimationBounce){
    [self.contentView animationBounceInWithDirection:direction boundaryView:self duration:DURATION_OF_ANIMATION];
  }else if (self.animationType == HHHintViewAnimationDrop){
    [self.contentView animationDropInWithDuration:DURATION_OF_ANIMATION];
  }else if (self.animationType == HHHintViewAnimationZoom){
    //
    CGPoint originCenter = self.contentView.center;
    CGPoint animationStartCenter = [self animationStartCenter:self.startPoint forView:self.contentView];
    self.contentView.center = animationStartCenter;
    self.contentView.alpha = 0.8f;
    self.contentView.transform = CGAffineTransformScale(self.contentView.transform, 0.1, 0.1);
    [UIView animateWithDuration:DURATION_OF_ANIMATION delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
      self.contentView.transform = CGAffineTransformIdentity;
      self.contentView.alpha = 1.0f;
      self.contentView.center = originCenter;
    } completion:^(BOOL finished) {
      //
    }];
  }
}
- (void)setupAnimationOut
{
  SEAnimationDirection direction = [self animationStartPoint:self.startPoint];
  if (self.animationType == HHHintViewAnimationFade) {
    [self.contentView animationFadeOutWithDuration:DURATION_OF_ANIMATION delegate:self startSelector:nil stopSelector:@selector(dismissCompletion)];
  }else if (self.animationType == HHHintViewAnimationSlide){
    [self.contentView animationSlideOutWithDirection:direction boundaryView:self duration:DURATION_OF_ANIMATION delegate:self startSelector:nil stopSelector:@selector(dismissCompletion)];
  }else if (self.animationType == HHHintViewAnimationSwirl){
    [self.contentView animationSwirlOutWithDuration:DURATION_OF_ANIMATION delegate:self startSelector:nil stopSelector:@selector(dismissCompletion)];
  }else if (self.animationType == HHHintViewAnimationBounce){
    [self.contentView animationBounceOutWithDirection:direction boundaryView:self duration:DURATION_OF_ANIMATION delegate:self startSelector:nil stopSelector:@selector(dismissCompletion)];
  }else if (self.animationType == HHHintViewAnimationDrop){
    [self.contentView animationDropOutWithDuration:DURATION_OF_ANIMATION  delegate:self startSelector:nil stopSelector:@selector(dismissCompletion)];
  }else if (self.animationType == HHHintViewAnimationZoom){
    self.contentView.transform = CGAffineTransformIdentity;
    self.contentView.alpha = 1.0f;
    CGPoint animationStopCenter = [self animationStartCenter:self.startPoint forView:self.contentView];
    [UIView animateWithDuration:DURATION_OF_ANIMATION delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
      self.contentView.alpha = 0.8f;
      self.contentView.transform = CGAffineTransformScale(self.contentView.transform, 0.1, 0.1);
      self.contentView.center = animationStopCenter;
    } completion:^(BOOL finished) {
      //
      [self dismissCompletion];
    }];
  }
  
}
#pragma mark -- Public
- (void)setupPositionType:(HHHintViewPositionType)positionType animationType:(HHHintViewAnimationType)animationType
{
  self.positionType = positionType;
  self.animationType = animationType;
}
- (void)setupStartPoint:(HHHintViewAnimationStartPoint)startPoint customStartCenter:(CGPoint)customStartPoint
{
  self.startPoint = startPoint;
  self.customStartCenter = customStartPoint;
}
- (void)showInView:(UIView *)view
{
  [self showInView:view duration:0];
}
- (void)showInView:(UIView *)view duration:(CGFloat)duration
{
  [self showInView:view duration:duration tapDismiss:NO];
}
- (void)showInView:(UIView *)view tapDismiss:(BOOL)tapDismiss
{
  [self showInView:view duration:0 tapDismiss:tapDismiss];
}
- (void)showInView:(UIView *)view duration:(CGFloat)duration tapDismiss:(BOOL)tapDismiss
{
  self.tapDismiss = tapDismiss;
  [view addSubview:self];
  [view bringSubviewToFront:self];
  [self show:duration];
}
- (void)dismissHintView
{
  [self dismiss];
}

@end
