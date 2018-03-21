//
//  UIImage+RemoteSize.h
//  CustomIOS7AlertView
//
//  Created by Ranosys Technologies on 21/2/14.
//  Copyright (c) 2014 Wimagguc. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef void (^UIImageSizeRequestCompleted) (NSURL* imgURL, CGSize size);

@interface UIImage (RemoteSize)

+ (void) requestSizeFor: (NSURL*) imgURL completion: (UIImageSizeRequestCompleted) completion;

@end
