//
//  SAScrollingHelper.h
//  SAScrollingHelper
//
//  Created by Yoshihiro Kato on 2014/06/10.
//  Copyright (c) 2014年 Yoshihiro Kato. All rights reserved.
//
//  Released under the MIT license
//

#import <UIKit/UIKit.h>

CGFloat SARatioFromOffset(CGFloat offset, NSRange range);

@class SAScrollingHelper;

typedef void (^SAScrollingAction)(SAScrollingHelper* helper, UIScrollView* view, CGPoint offset);
typedef void (^SAZoomingAction)(SAScrollingHelper* helper, UIScrollView* view, CGFloat zoomScale);

@interface SAScrollingHelper : NSObject

- (instancetype)initWithTarget:(UIScrollView*)scrollView;
- (void)addScrollingAction:(SAScrollingAction)action forKey:(NSString*)key;
- (void)addZoomingAction:(SAZoomingAction)action forKey:(NSString*)key;
- (void)removeActionForKey:(NSString*)key;
- (void)removeAllActions;


@end
