//
//  CLMGridMenuView.m
//  GridMenuController
//
//  Created by Andrew Hulsizer on 9/2/13.
//  Copyright (c) 2013 Andrew Hulsizer. All rights reserved.
//

#import "CLMGridMenuView.h"
#import "CLMGridMenuItem.h"
#import "CLMGridMenuLayout.h"

// create structure to store delegate callback
typedef struct CLMGridMenuViewDelegateCallbacks
{
    BOOL didUpdate;
	BOOL didHighlightItemAtIndex;
    BOOL didUnhighlightItemAtIndex;
    BOOL didSelectItemAtIndex;
    BOOL didDeselectItemAtIndex;
} CLMGridMenuViewDelegateCallbacks;

@interface CLMGridMenuView ()
{
    CLMGridMenuViewDelegateCallbacks _delegateCanHandle;
}
@end

@implementation CLMGridMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [self reloadView];
}

#pragma mark - Custom Setters
- (void)setDelegate:(id<CLMGridMenuViewDelegate>)delegate
{
    if (_delegate != delegate)
    {
        _delegate = delegate;
        _delegateCanHandle.didUpdate = [delegate respondsToSelector:@selector(gridMenuViewDidUpdate:)];
        _delegateCanHandle.didHighlightItemAtIndex = [delegate respondsToSelector:@selector(gridMenuView:didHighlightItemAtIndex:)];
        _delegateCanHandle.didUnhighlightItemAtIndex = [delegate respondsToSelector:@selector(gridMenuView:didUnhighlightItemAtIndex:)];
        _delegateCanHandle.didSelectItemAtIndex = [delegate respondsToSelector:@selector(gridMenuView:didSelectItemAtIndex:)];
        _delegateCanHandle.didDeselectItemAtIndex = [delegate respondsToSelector:@selector(gridMenuView:didDeselectItemAtIndex:)];
    }
}

#pragma mark - Builders
- (void)buildGridMenu
{
    for (UIView *view in self.gridItemViews)
    {
        [view removeFromSuperview];
    }
    
    NSUInteger numberOfItems = [self.dataSource numberOfMenuItems];

    for (int itemIndex = 0; itemIndex < numberOfItems; ++itemIndex)
    {
        CLMGridMenuItem *item = [self.dataSource gridMenuItemForIndex:itemIndex];
        
        UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, item.image.size.width, item.image.size.height)];
        
        [menuButton setImage:item.image forState:UIControlStateNormal];
        [menuButton setImage:item.highlightedImage forState:UIControlStateHighlighted];
        [menuButton setImage:item.selectedImage forState:UIControlStateSelected];
        
        [menuButton addTarget:self action:@selector(didTouchUpInsideMenuItem:) forControlEvents:UIControlEventTouchUpInside];
        [menuButton addTarget:self action:@selector(didTouchDownMenuItem:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:menuButton];
    }
    
}

- (void)layoutGridMenu
{
    id<CLMGridMenuLayout> layout = [self.dataSource layoutForMenu];
    [layout layoutMenuItems:[self gridItemViews] inParentView:self];
}

- (void)reloadView
{
    [self buildGridMenu];
    [self layoutGridMenu];
	[self didFinishUpdating];
}

#pragma mark - Item Selection

- (void)selectGridMenuItemAtIndex:(NSUInteger)index
{
	//maybe a no op?
	NSAssert(index < [self.gridItemViews count], @"Index must be within the bounds of %d", [self.gridItemViews count]);
	
	//should the controller handle this and the view only worry about selecting the index
	[self.gridItemViews enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
		if (index == idx)
		{
			button.selected = YES;
		}else{
			button.selected = NO;
		}
	}];
}

- (void)deselectGridMenuItemAtIndex:(NSUInteger)index
{
	//maybe a no op?
	NSAssert(index < [self.gridItemViews count], @"Index must be within the bounds of %d", [self.gridItemViews count]);
	
	UIButton *button = [self gridMenuItemViewAtIndex:index];
	button.selected = NO;
}

#pragma mark - Helpers

- (NSArray *)gridItemViews
{
    return [self subviews];
}

- (id)gridMenuItemViewAtIndex:(NSUInteger)index
{
	if (index < [self.gridItemViews count])
	{
		return [self.gridItemViews objectAtIndex:index];
	}
	
	return nil;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
	for (UIView *subview in self.gridItemViews)
	{
		if (CGRectContainsPoint(subview.frame, point))
		{
			return YES;
		}
	}
	return NO;
}

#pragma mark - Actions

- (void)didFinishUpdating
{
	if (_delegateCanHandle.didUpdate)
	{
		[self.delegate gridMenuViewDidUpdate:self];
	}
}

- (void)didTouchUpInsideMenuItem:(UIButton *)button
{
	if (_delegateCanHandle.didSelectItemAtIndex)
    {
        NSUInteger index = [self.gridItemViews indexOfObject:button];
        [self.delegate gridMenuView:self didSelectItemAtIndex:index];
    }
}

- (void)didTouchUpOutsideMenuItem:(UIButton *)button
{
    if (_delegateCanHandle.didUnhighlightItemAtIndex)
    {
        NSUInteger index = [self.gridItemViews indexOfObject:button];
        [self.delegate gridMenuView:self didUnhighlightItemAtIndex:index];
    }
}

- (void)didTouchDownMenuItem:(UIButton *)button
{
	if (_delegateCanHandle.didHighlightItemAtIndex)
    {
        NSUInteger index = [self.gridItemViews indexOfObject:button];
        [self.delegate gridMenuView:self didHighlightItemAtIndex:index];
    }
}

@end
