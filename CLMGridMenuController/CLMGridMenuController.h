//
//  CLMGridMenuController.h
//  GridMenuController
//
//  Created by Andrew Hulsizer on 9/2/13.
//  Copyright (c) 2013 Andrew Hulsizer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLMGridMenuController;
@class CLMGridMenuView;
@class CLMGridMenuItem;

@protocol CLMGridMenuLayout;
@protocol CLMGridMenuPresentation;

@protocol CLMGridMenuItemViewController <NSObject>

/// \brief The grid menu item contains all the information needed to display on the menu view controller
@property (nonatomic, strong) CLMGridMenuItem *gridMenuItem;

/// \brief The gridMenuController points to the owner of the view controller
@property (nonatomic, weak) CLMGridMenuController *gridMenuController;

@optional

/// \brief This method is called when the gridMenuItem was selected
- (void)gridMenuItemWasSelected;
@end


/// \brief CLMGridMenuController is a menu controller for managing views in an application.
@interface CLMGridMenuController : UIViewController

/// \brief Use this initializer to specify the menu controllers view controllers as well as the layout and presentation that will be called when a GridMenuItem is selected
- (instancetype)initWithViewControllers:(NSArray *)viewControllers layout:(id<CLMGridMenuLayout>)layout presentation:(id<CLMGridMenuPresentation>)presentation;


/// \brief This is the view where all GridMenuItems are laid out and displayed based on the layout passed in from initWithViewControllers:layout:presentation:.
@property (nonatomic, strong) CLMGridMenuView *gridMenuView;

/// \brief This is where all content for the GridMenuController will be placed. View Controllers passed in from the initWithViewControllers:layout:presentation: will be added to the contentView when selected from the gridMenuView
@property (nonatomic, strong) UIView *contentView;

/// \brief This is the currently selected and displayed view controller
@property (nonatomic, strong) UIViewController<CLMGridMenuItemViewController> *contentViewController;
@end



