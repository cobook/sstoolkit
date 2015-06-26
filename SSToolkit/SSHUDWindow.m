//
//  SSHUDWindow.m
//  SSToolkit
//
//  Created by Sam Soffes on 3/17/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSHUDWindow.h"
#import "SSDrawingUtilities.h"
#import "UIImage+SSToolkitAdditions.h"


@interface SSHUDWindowRootViewController : UIViewController
@end


static SSHUDWindow *kHUDWindow = nil;

@implementation SSHUDWindow

#pragma mark - Accessors

@synthesize hidesVignette = _hidesVignette;

- (void)setHidesVignette:(BOOL)hide {
	_hidesVignette = hide;
	self.userInteractionEnabled = !hide;
	[self setNeedsDisplay];
}


#pragma mark - Class Methods

+ (SSHUDWindow *)defaultWindow {
	if (!kHUDWindow) {
		kHUDWindow = [[SSHUDWindow alloc] init];
	}
	return kHUDWindow;
}


#pragma mark - NSObject

- (id)init {
	if ((self = [super initWithFrame:[[UIScreen mainScreen] bounds]])) {
		self.backgroundColor = [UIColor clearColor];
		self.windowLevel = UIWindowLevelStatusBar + 1.0f;
		self.rootViewController = [SSHUDWindowRootViewController new];
	}
	return self;
}


#pragma mark - UIView

- (void)drawRect:(CGRect)rect {
	if (_hidesVignette) {
		return;
	}

	CGContextRef context = UIGraphicsGetCurrentContext();
	CGGradientRef gradient = SSCreateGradientWithColors(@[[UIColor colorWithWhite:0.0f alpha:0.1f], [UIColor colorWithWhite:0.0f alpha:0.5f]]);
	CGContextDrawRadialGradient(context, gradient, self.center, 0.0f, self.center, fmaxf(self.bounds.size.width, self.bounds.size.height) / 2.0f, kCGGradientDrawsAfterEndLocation);
}

@end


@implementation SSHUDWindowRootViewController


- (UIStatusBarStyle)preferredStatusBarStyle
{
	return UIStatusBarStyleLightContent;
}


- (BOOL)shouldAutorotate
{
	return YES;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
	UIWindow *mainWindow = [UIApplication sharedApplication].delegate.window;
	UIViewController *rootViewController = mainWindow.rootViewController;
	if (rootViewController.presentedViewController) {
		return [rootViewController.presentedViewController supportedInterfaceOrientations];
	} else {
		return [rootViewController supportedInterfaceOrientations];
	}
}


- (UIView *)view
{
	return nil;
}


@end
