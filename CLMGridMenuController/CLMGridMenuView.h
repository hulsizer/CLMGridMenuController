//
//  CLMGridMenuView.h
//  GridMenuController
//
//  Created by Andrew Hulsizer on 9/2/13.
//  Copyright (c) 2013 Andrew Hulsizer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLMGridMenuItem;

@protocol CLMGridMenuViewDelegate;
@protocol CLMGridMenuViewDataSource;
@protocol CLMGridMenuLayout;

/// \brief CLMGridMenuView is the menu view where all GridMenuItems are added as subviews based on the layout provided to the CLMGridMenuController
@interface CLMGridMenuView : UIView

/// \brief This deallocs all previous buttons and rebuilds the menu from new buttons and calls the delegate to lay them out.
- (void)reloadView;

/// \brief All current grid items created and placed by the menu view. Because of the ability to insert other views into the menu view this could provide unwanted results if we just used subviews
- (NSArray *) gridItemViews;

/// \brief Used to select a GridMenuItem in the menu view
/// \param index of the GridMenuitem (Assert will be thrown if index out of bounds occurs)
- (void)selectGridMenuItemAtIndex:(NSUInteger)index;

/// \brief Used to deselect a GridMenuItem in the menu view
/// \param index of the GridMenuItem (Assert will be thrown if index out of bounds occurs)
- (void)deselectGridMenuItemAtIndex:(NSUInteger)index;

@property (nonatomic, weak) id<CLMGridMenuViewDataSource> dataSource;
@property (nonatomic, weak) id<CLMGridMenuViewDelegate> delegate;
@end

/// \brief CLMGridMenuViewDataSource is used to provide the GridMenuView with a layout and GridMenuItems to transfer to view controllers
@protocol CLMGridMenuViewDataSource <NSObject>

@required
- (id<CLMGridMenuLayout>)layoutForMenu;
- (NSUInteger)numberOfMenuItems;
- (CLMGridMenuItem *)gridMenuItemForIndex:(NSUInteger)index;

@end

/// \brief CLMGridMenuViewDelegate provides callbacks when a menu item goes through various states. There is an additional callback provided for when the menu has finished updating.
@protocol CLMGridMenuViewDelegate <NSObject>

@optional
- (void)gridMenuViewDidUpdate:(CLMGridMenuView *)gridMenuView;
- (void)gridMenuView:(CLMGridMenuView *)gridMenuView didHighlightItemAtIndex:(NSUInteger)index;
- (void)gridMenuView:(CLMGridMenuView *)gridMenuView didUnhighlightItemAtIndex:(NSUInteger)index;
- (void)gridMenuView:(CLMGridMenuView *)gridMenuView didSelectItemAtIndex:(NSUInteger)index;
- (void)gridMenuView:(CLMGridMenuView *)gridMenuView didDeselectItemAtIndex:(NSUInteger)index;
@end
