//
//  CLMGridMenuLayout.h
//  GridMenuController
//
//  Created by Andrew Hulsizer on 9/2/13.
//  Copyright (c) 2013 Andrew Hulsizer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CLMGridMenuLayout <NSObject>

/// \brief This method is called when the grid menu is built. The grid menu is built on initialization and when reloadView is called.
/// \param gridMenuItems An array of UIButtons to be displayed for the grid menu.
/// \param parentView The parent view of the grid menu items.
- (void)layoutMenuItems:(NSArray *)gridMenuItems inParentView:(UIView *)parentView;

/// \This method can be called to provide updates to the layout on a per view controller basis. (i.e. providing the content offset of a scroll view, you can fade the menu items)
/// \param context An NSDictionary to provide information about how to update menu items.
- (void)updateLayoutForContext:(NSDictionary *)context;
@end;