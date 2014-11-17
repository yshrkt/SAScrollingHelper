//
//  SADemo01ViewController.m
//  SAScrollingHelper
//
//  Created by Yoshihiro Kato on 2014/06/10.
//  Copyright (c) 2014年 Yoshihiro Kato. All rights reserved.
//

#import "SADemo01ViewController.h"
#import "SAScrollingHelper.h"
#import "UIColor+FlatUIColors.h"

@interface SADemo01ViewController ()

@end

@implementation SADemo01ViewController {
    UIScrollView* _scrollView;
    SAScrollingHelper* _helper;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.view.backgroundColor = [UIColor asbestosColor];
    
    // setup scrollView
    int numOfPages = 3;
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView = scrollView;
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height*numOfPages);
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    
    // setup page background
    for(int i = 0; i < numOfPages; i++){
        CGRect frame = CGRectMake(0, self.view.bounds.size.height*i,
                                  self.view.bounds.size.width, self.view.bounds.size.height);
        UIView* bgView = [[UIView alloc] initWithFrame:frame];
        bgView.backgroundColor = (i%2 == 0) ? [UIColor whiteColor] : [UIColor cloudsColor];
        [_scrollView addSubview:bgView];
    }
    
    // setup page1
    [self setupPage1];
    
    // setup page2
    [self setupPage2];
    
    // setup page3
    [self setupPage3];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    _scrollView.frame = self.view.bounds;
    _scrollView.contentInset = UIEdgeInsetsZero;
}

- (void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupPage1 {
    //// Setup header
    CGFloat headerHeight = 64.0;
    UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                              self.view.bounds.size.width,
                                                              headerHeight)];
    header.backgroundColor = [UIColor turquoiseColor];
    [_scrollView addSubview:header];
    
    UIButton* back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [back setTitle:@"Back" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [back sizeToFit];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    CGRect f = back.frame;
    f.origin.y = 20;
    f.origin.x = 10;
    f.size.height = 44.0;
    back.frame = f;
    [header addSubview:back];
    
    // Add Scrolling Action for header
    _helper = [[SAScrollingHelper alloc] initWithTarget:_scrollView];
    __weak UIView* blockHeader = header;
    __weak UIButton* blockBack = back;
    [_helper addScrollingAction:^(SAScrollingHelper *helper, UIScrollView *view, CGPoint offset) {
        CGFloat r = SARatioFromOffset(offset.y, NSMakeRange(0, view.bounds.size.height));
        CGRect f = blockHeader.frame;
        f.size.height = headerHeight * (1.0 - r);
        if(f.size.height < 20.0){
            f.size.height = 20;
        }
        if(f.size.height == 64.0){
            blockBack.hidden = NO;
        }else {
            blockBack.hidden = YES;
        }
        f.origin.y = view.bounds.size.height * r;
        blockHeader.frame = f;
    } forKey:@"header_action"];
    
    //// Setup label
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 64)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor turquoiseColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Scroll me!";
    label.center = CGPointMake(self.view.bounds.size.width*0.5, self.view.bounds.size.height*0.5);
    [_scrollView addSubview:label];
    
    // Add Scrolling Action for label
    __weak UILabel* blockLabel = label;
    [_helper addScrollingAction:^(SAScrollingHelper *helper, UIScrollView *view, CGPoint offset) {
        CGFloat r = SARatioFromOffset(offset.y, NSMakeRange(60, 120));
        blockLabel.alpha = 1.0 - r;
        r = SARatioFromOffset(offset.y, NSMakeRange(20, 360));
        blockLabel.transform = CGAffineTransformMakeScale(1.0 - r, 1.0 - r);
    } forKey:@"label_action"];
}

- (void)setupPage2 {
    // setup view
    UIView* v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    v.backgroundColor = [UIColor peterRiverColor];
    v.alpha = 0.0;
    v.center = CGPointMake(self.view.bounds.size.width*0.5, self.view.bounds.size.height*1.5);
    v.transform = CGAffineTransformMakeScale(0.0, 0.0);
    [_scrollView addSubview:v];
    
    __weak UIView* blockView = v;
    [_helper addScrollingAction:^(SAScrollingHelper *helper, UIScrollView *view, CGPoint offset) {
        CGFloat r = SARatioFromOffset(offset.y, NSMakeRange(0, view.bounds.size.height));
        blockView.alpha = r;
        blockView.transform = CGAffineTransformMakeScale(r, r);
    } forKey:@"page2_action"];
}

- (void)setupPage3 {
    // setup view
    UIView* v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    v.backgroundColor = [UIColor wisteriaColor];
    v.center = CGPointMake(self.view.bounds.size.width*0.5, self.view.bounds.size.height*2 - 40);
    v.hidden = YES;
    [_scrollView addSubview:v];
    
    __weak UIView* blockView = v;
    [_helper addScrollingAction:^(SAScrollingHelper *helper, UIScrollView *view, CGPoint offset) {
        if(offset.y >= view.bounds.size.height*2){
            [helper removeActionForKey:@"page3_action"];
            
            blockView.hidden = NO;
            [UIView animateWithDuration:0.6 delay:0.1
                 usingSpringWithDamping:0.3
                  initialSpringVelocity:0.08
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 blockView.center = CGPointMake(view.bounds.size.width*0.5, view.bounds.size.height*2.5);
                             } completion:nil];
        }
    } forKey:@"page3_action"];
}
@end
