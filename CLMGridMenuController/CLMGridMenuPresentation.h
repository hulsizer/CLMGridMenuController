//
//  CLMGridMenuPresentation.h
//  GridMenuController
//
//  Created by Andrew Hulsizer on 9/2/13.
//  Copyright (c) 2013 Andrew Hulsizer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLMGridMenuController.h"

@protocol CLMGridMenuPresentation <NSObject>

/// \brief This method is called once a grid menu item was selected. It enables the a easy customization of for transitioning from the current view controller to the selected view controller. If you implement this protocol you are responsible for managing the removal of fromViewController.
/// \param fromViewController The current view controller displayed to the user.
/// \param toViewController The selected view controller that has been requested to the content view
- (void)transitionFromViewController:(id<CLMGridMenuItemViewController>)fromViewController toViewController:(UIViewController *)toViewController;

@end
