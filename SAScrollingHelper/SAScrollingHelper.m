//
//  SAScrollingHelper.m
//  SAScrollingHelper
//
//  Created by Yoshihiro Kato on 2014/06/10.
//  Copyright (c) 2014年 Yoshihiro Kato. All rights reserved.
//
//  Released under the MIT license
//

#import "SAScrollingHelper.h"

CGFloat SARatioFromOffset(CGFloat offset, NSRange range) {
    CGFloat ratio = 0.0f;
    if(offset < range.location){
        ratio = 0.0f;
    }else if(offset >= range.location + range.length){
        ratio = 1.0f;
    }else {
        ratio = (offset - range.location)/range.length;
    }
    return ratio;
}

@implementation SAScrollingHelper {
    NSMutableDictionary* _scrollingActions;
    NSMutableDictionary* _zoomingActions;
    
    UIScrollView* _scrollView;
}

- (instancetype)init {
    self = [super init];
    if(self){
        _scrollView = nil;
        _scrollingActions = [[NSMutableDictionary alloc] init];
        _zoomingActions = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc {
    [self removeAllActions];
    [self setTarget:nil];
}

- (instancetype)initWithTarget:(UIScrollView*)scrollView {
    self = [self init];
    if(self){
        [self setTarget:scrollView];
    }
    return self;
}

- (void)setTarget:(UIScrollView*)scrollView {
    if(_scrollView){
        [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
        [_scrollView removeObserver:self forKeyPath:@"zoomScale"];
    }
    _scrollView = scrollView;
    if(_scrollView){
        [_scrollView addObserver:self
                      forKeyPath:@"contentOffset"
                         options:NSKeyValueObservingOptionInitial
                                |NSKeyValueObservingOptionNew context:nil];
        [_scrollView addObserver:self
                      forKeyPath:@"zoomScale"
                         options:NSKeyValueObservingOptionInitial
         |NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)addScrollingAction:(SAScrollingAction)action forKey:(NSString*)key {
    @synchronized(self){
        [_scrollingActions setObject:action forKey:key];
    }
}

- (void)addZoomingAction:(SAZoomingAction)action forKey:(NSString*)key {
    @synchronized(self){
        [_zoomingActions setObject:action forKey:key];
    }
}

- (void)removeActionForKey:(NSString*)key {
    @synchronized(self){
        [_scrollingActions removeObjectForKey:key];
        [_zoomingActions removeObjectForKey:key];
    }
}

- (void)removeAllActions {
    @synchronized(self){
        [_scrollingActions removeAllObjects];
        [_zoomingActions removeAllObjects];
    }
}

#pragma makr - Key Value Obsering
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if(_scrollView != object){
        return;
    }
    @synchronized(self){
        if([keyPath isEqualToString:@"contentOffset"]){
            NSDictionary* actions = [_scrollingActions copy];
            for(NSString* key in actions){
                SAScrollingAction action = [_scrollingActions objectForKey:key];
                __weak SAScrollingHelper* blockSelf = self;
                __weak UIScrollView* blockScrollView = _scrollView;
                action(blockSelf, blockScrollView, blockScrollView.contentOffset);
            }
        }else if([keyPath isEqualToString:@"zoomScale"]){
            NSDictionary* actions = [_zoomingActions copy];
            for(NSString* key in actions){
                SAZoomingAction action = [_zoomingActions objectForKey:key];
                __weak SAScrollingHelper* blockSelf = self;
                __weak UIScrollView* blockScrollView = _scrollView;
                action(blockSelf, blockScrollView, blockScrollView.zoomScale);
            }
        }
    }
}
@end
