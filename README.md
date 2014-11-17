SAScrollingHelper
==================

UIScrollView helper for scroll effects like parallax scrolling.

## Usage

The usage is like this.

```objective-c  
// Add Scrolling Action for label
_helper = [[SAScrollingHelper alloc] initWithTarget:_scrollView];
__weak UILabel* blockLabel = label;
[_helper addScrollingAction:^(SAScrollingHelper *helper, UIScrollView *view, CGPoint offset) {
    CGFloat r = SARatioFromOffset(offset.y, NSMakeRange(60, 120));
    blockLabel.alpha = 1.0 - r;
    r = SARatioFromOffset(offset.y, NSMakeRange(20, 360));
    blockLabel.transform = CGAffineTransformMakeScale(1.0 - r, 1.0 - r);
} forKey:@"label_action"];
```

## License

Released under the MIT license