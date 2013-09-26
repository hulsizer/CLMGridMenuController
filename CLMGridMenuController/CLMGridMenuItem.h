//
//  CLMGridMenuItem.h
//  GridMenuController
//
//  Created by Andrew Hulsizer on 9/2/13.
//  Copyright (c) 2013 Andrew Hulsizer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLMGridMenuItem : NSObject

/// \brief Image for the default state of a GridMenuItem
@property (nonatomic, strong) UIImage *image;

/// \brief Image for the selected state of a GridMenuItem.
@property (nonatomic, strong) UIImage *selectedImage;

/// \brief Image for when the button is held down.
@property (nonatomic, strong) UIImage *highlightedImage;
@end