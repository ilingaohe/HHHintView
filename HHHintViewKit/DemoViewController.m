//
//  DemoViewController.m
//  HHHintViewKit
//
//  Created by lingaohe on 8/1/13.
//  Copyright (c) 2013 ilingaohe. All rights reserved.
//

#import "DemoViewController.h"
#import "HHHintView.h"
#import "ALActionBlocks.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  [self setupView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- SetupView
- (void)setupView
{
  //
  self.view.backgroundColor = [UIColor whiteColor];
  //
  float btnWidth = 100.0f;
  float btnHeight = 44.0f;
  float screenWidth = [UIScreen mainScreen].bounds.size.width;
//  float screenHeight = [UIScreen mainScreen].bounds.size.height;
  //BtnOne
  UIButton *btnOne = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  btnOne.frame = CGRectMake((screenWidth-btnWidth)/2, 100+btnHeight, btnWidth, btnHeight);
  [btnOne setTitle:@"BtnOne" forState:UIControlStateNormal];
  [btnOne handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
    //
    [self showHintViewOne];
  }];
  [self.view addSubview:btnOne];
  //BtnTwo
  UIButton *btnTwo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  btnTwo.frame = CGRectMake((screenWidth-btnWidth)/2, 150+btnHeight, btnWidth, btnHeight);
  [btnTwo setTitle:@"BtnTwo" forState:UIControlStateNormal];
  [btnTwo handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
    //
    [self showHintViewTwo];
  }];
  [self.view addSubview:btnTwo];
  //BtnThree
  UIButton *btnThree = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  btnThree.frame = CGRectMake((screenWidth-btnWidth)/2, 200+btnHeight, btnWidth, btnHeight);
  [btnThree setTitle:@"BtnThree" forState:UIControlStateNormal];
  [btnThree handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
    //
    [self showHintViewThree];
  }];
  [self.view addSubview:btnThree];
}
#pragma mark -- HHHintView
- (void)showHintViewOne
{
  //
  UIView *contentView = [[UIView alloc] init];
  contentView.frame = CGRectMake(0, 0, self.view.frame.size.width, 80);
  contentView.backgroundColor = [UIColor greenColor];
  //
  HHHintView *hintView = [[HHHintView alloc] initWithContentView:contentView];
  [hintView setupPositionType:HHHintViewPositionTop animationType:HHHintViewAnimationSlide];
  [hintView setupStartPoint:HHHintViewAnimationStartTop customStartCenter:CGPointZero];
  //
  [hintView showInView:self.view tapDismiss:YES];
}
- (void)showHintViewTwo
{
  //
  UIView *contentView = [[UIView alloc] init];
  contentView.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
  contentView.backgroundColor = [UIColor blueColor];
  //
  HHHintView *hintView = [[HHHintView alloc] initWithContentView:contentView];
  [hintView setupPositionType:HHHintViewPositionBottom animationType:HHHintViewAnimationZoom];
  [hintView setupStartPoint:HHHintViewAnimationStartBottomRight customStartCenter:CGPointZero];
  //
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  btn.frame = CGRectMake(0, 0, 60, 44.0f);
  btn.center = contentView.center;
  [btn setTitle:@"Close" forState:UIControlStateNormal];
  [btn handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
    //
    [hintView dismissHintView];
  }];
  [contentView addSubview:btn];
  //
  [hintView showInView:self.view tapDismiss:NO];
}
- (void)showHintViewThree
{
  //
  UIView *contentView = [[UIView alloc] init];
  contentView.frame = CGRectMake(0, 200+44+44, self.view.frame.size.width, 100);
  contentView.backgroundColor = [UIColor blueColor];
  //
  HHHintView *hintView = [[HHHintView alloc] initWithContentView:contentView];
  [hintView setupPositionType:HHHintViewPositionCustom animationType:HHHintViewAnimationZoom];
  [hintView setupStartPoint:HHHintViewAnimationStartCustom customStartCenter:CGPointMake(contentView.frame.origin.x+contentView.frame.size.width/2, contentView.frame.origin.y)];
  //
  [hintView showInView:self.view tapDismiss:YES];
}
@end
