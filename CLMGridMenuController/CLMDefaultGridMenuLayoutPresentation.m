//
//  BRADefaultGridMenuLayoutPresentation.m
//  GridMenuControllerTest
//
//  Created by Andrew Hulsizer on 8/18/13.
//  Copyright (c) 2013 Andrew Hulsizer. All rights reserved.
//

#import "CLMDefaultGridMenuLayoutPresentation.h"


@implementation CLMDefaultGridMenuLayoutPresentation

#pragma mark - BRAGridMenuLayout

- (void)layoutMenuItems:(NSArray *)gridMenuItems inParentView:(UIView *)parentView
{
	CGFloat sectionWidth = CGRectGetWidth(parentView.frame)/[gridMenuItems count];
	CGFloat sectionCenter = sectionWidth / 2;
	
	__block CGFloat currentOffset = sectionCenter;

    [gridMenuItems enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        button.center = CGPointMake(currentOffset, CGRectGetMaxY(parentView.bounds)-(CGRectGetHeight(button.frame)/2));
        currentOffset += sectionWidth;
    }];
}


#pragma mark - BRAGridMenuPresentation

- (void)transitionFromViewController:(UIViewController<CLMGridMenuItemViewController> *)fromViewController toViewController:(UIViewController<CLMGridMenuItemViewController> *)toViewController
{
	if (fromViewController == toViewController)
	{
		return;
	}
	
    UIView *parentView = fromViewController.view.superview;
    toViewController.view.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(toViewController.view.frame), 0);
    [parentView bringSubviewToFront:toViewController.view];
    [parentView bringSubviewToFront:fromViewController.view];
    [UIView animateWithDuration:.5 animations:^{
		
        fromViewController.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(fromViewController.view.frame), 0);
        toViewController.view.transform = CGAffineTransformIdentity;
		
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        [fromViewController.view removeFromSuperview];
    }];
}

@end
