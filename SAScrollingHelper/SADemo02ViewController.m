//
//  SADemo02ViewController.m
//  SAScrollingHelper
//
//  Created by Yoshihiro Kato on 2014/11/17.
//  Copyright (c) 2014年 Yoshihiro Kato. All rights reserved.
//

#import "SADemo02ViewController.h"
#import "SAScrollingHelper.h"

@interface SADemo02ViewController ()

@end

@implementation SADemo02ViewController {
    UIWebView* _webView;
    SAScrollingHelper* _helper;
    
    __block CGFloat _statusBarHeight;
    __block CGFloat _naviBarHeight;
}

- (void)loadView {
    [super loadView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"Demo 2";
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView = webView;
    [self.view addSubview:_webView];
    
    __weak SADemo02ViewController* blockSelf = self;
    __weak UIWebView* blockWebView = _webView;
    _helper = [[SAScrollingHelper alloc] initWithTarget:_webView.scrollView];
    [_helper addScrollingAction:^(SAScrollingHelper *helper, UIScrollView *view, CGPoint offset) {
        UINavigationBar* naviBar = blockSelf.navigationController.navigationBar;
        
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        CGFloat naviBarHeight = naviBar.frame.size.height;
        CGFloat barHeight = statusBarHeight + naviBarHeight;
        
        
        
        if(blockWebView.request && !blockWebView.loading){
            CGFloat r = SARatioFromOffset(offset.y + barHeight,
                                              NSMakeRange(0, barHeight));
            
            CGRect f = naviBar.frame;
            f.origin.y = -naviBarHeight * r + statusBarHeight;
            naviBar.frame = f;
            
            [blockSelf updateNavigationBarItemsWithAlpha:1.0 - r];
            
            if(f.origin.y <= -naviBarHeight + statusBarHeight){
                [blockSelf.navigationItem setHidesBackButton:YES animated:NO];
            }else {
                [blockSelf.navigationItem setHidesBackButton:NO animated:NO];
            }
        }else {
            [blockSelf restoreNavigationBar];
        }
        blockWebView.scrollView.contentInset = UIEdgeInsetsMake(barHeight, 0, 0, 0);
    } forKey:@"handle_navibar"];
}

- (void)updateNavigationBarItemsWithAlpha:(CGFloat)alpha
{
    UINavigationBar* naviBar = self.navigationController.navigationBar;
    CGFloat r = 0, g=0, b=0, a=0;
    
    [naviBar.tintColor getRed:&r green:&g blue:&b alpha:&a];
    naviBar.tintColor = [UIColor colorWithRed:r green:g blue:b alpha:alpha];
    
    NSMutableDictionary* attr = [NSMutableDictionary dictionaryWithDictionary:naviBar.titleTextAttributes];
    attr[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.0 alpha:alpha];
    naviBar.titleTextAttributes = attr;
}

- (void)restoreNavigationBar
{
    UINavigationBar* naviBar = self.navigationController.navigationBar;
    CGRect f = naviBar.frame;
    f.origin.y = [[UIApplication sharedApplication] statusBarFrame].size.height;
    if(naviBar.frame.origin.y < 0.0){
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             naviBar.frame = f;
                             
                             [self updateNavigationBarItemsWithAlpha:1.0];
                         }
                         completion:nil];
    }
    [self.navigationItem setHidesBackButton:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(!_webView.request){
        NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://apple.com"]];
        [_webView loadRequest:request];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self restoreNavigationBar];
}

@end
