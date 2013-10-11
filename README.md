HHHintView
==========

###说明：
[HHHintView](https://github.com/ilingaohe/HHHintView)是基于[TBHintView](https://github.com/touchbee/TBHintView)改编的用于iOS上在界面进行Hint提示的一个实现，通过addSubview的方式在原有的界面上显示用来Hint提示的View，并且用removeSubview的方式进行消失。


TBHintView的优点在于，他实现了Hint提示View显示和消失时的各种动画。TBHintView的实现方式是，使用Core Animation实现一系列View切换的效果（SEAnimationFactory类），然后扩展UIView（UIView+SEAnimations类），可以直接在UIView上调用SEAnimationFactory中实现的动画方式。TBHintView类是入口，使用Delegate的方式获取用于Hint显示的View，和控制View的显示和消失。


HHHintView对TBHintView的改编有两处，第一处是把Delegate获取View的方式修改为直接设置UIView作为HHHintView创建时的参数传人，这样的好处是在编写代码的时候，代码比较集中，不会像Delegate实现方式那样分散在不同的地方。第二处是整理了一下动画参数的设置方法。


###使用要求和方式：
1、需要iOS5.0及以上和ARC的支持

2、把HHHintView文件夹加入你的工程

3、包含QuartCore这个Framework



###示例代码：
	- (void)showHintViewOne
	{
	  //设置用于Hint显示的ContentView
	  UIView *contentView = [[UIView alloc] init];
	  contentView.frame = CGRectMake(0, 0, self.view.frame.size.width, 80);
	  contentView.backgroundColor = [UIColor greenColor];
	  //直接把ContentView作为参数传入
	  HHHintView *hintView = [[HHHintView alloc] initWithContentView:contentView];
	  //设置在界面上显示的位置和显示时的动画
	  [hintView setupPositionType:HHHintViewPositionTop animationType:HHHintViewAnimationFade];
	  //进行显示
	  [hintView showInView:self.view tapDismiss:YES];
	}


更多代码请参考Demo和HHHintView的实现。

###感谢:
HHHintView的实现基于GitHub上的两个开源仓库，开头介绍过的[TBHintView](https://github.com/touchbee/TBHintView)和为UIControl类的Event增加Block实现的[ALActionBlocks](https://github.com/lavoy/ALActionBlocks)。

