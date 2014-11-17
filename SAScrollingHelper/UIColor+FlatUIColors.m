//
//  UIColor+FlatUIColors.m
//
//  Referencing to http://flatuicolors.com
//
//  Created by Yoshihiro Kato on 2014/06/10.
//  Copyright (c) 2014年 Yoshihiro Kato. All rights reserved.
//

#import "UIColor+FlatUIColors.h"

@implementation UIColor (FlatUIColors)

+ (UIColor*)colorWithHexString:(NSString*)hex {
    UIColor* color;
    if(hex && [hex length] >= 7 && [hex hasPrefix:@"#"]){
        hex = [hex substringFromIndex:1];
    }
    if(hex && ([hex length] == 8 || [hex length] == 6)){
        CGFloat red, green, blue, alpha;
        unsigned int colorValue;
        NSScanner* scanner = [NSScanner scannerWithString:hex];
        [scanner scanHexInt:&colorValue];
        
        if([hex length] == 8){
            red = ((colorValue >> 24)&0xFF)/255.0;
            green = ((colorValue >> 16)&0xFF)/255.0;
            blue = ((colorValue >> 8)&0xFF)/255.0;
            alpha = (colorValue&0xFF)/255.0;
        }else {
            red = ((colorValue >> 16)&0xFF)/255.0;
            green = ((colorValue >> 8)&0xFF)/255.0;
            blue = (colorValue&0xFF)/255.0;
            alpha = 1.0;
        }
        color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    }else {
        color = [UIColor blackColor];
    }
    return color;
}

+ (UIColor*)turquoiseColor {
    // #1abc9c
    return [UIColor colorWithHexString:@"#1abc9c"];
}

+ (UIColor*)greenSeaColor {
    // #16a085
    return [UIColor colorWithHexString:@"#16a085"];
}

+ (UIColor*)emeraldColor {
    // #2ecc71
    return [UIColor colorWithHexString:@"#2ecc71"];
}

+ (UIColor*)nephritisColor {
    // #27ae60
    return [UIColor colorWithHexString:@"#27ae60"];
}

+ (UIColor*)peterRiverColor {
    // #3498db
    return [UIColor colorWithHexString:@"#3498db"];
}

+ (UIColor*)belizeHoleColor {
    // #2980b9
    return [UIColor colorWithHexString:@"#2980b9"];
}

+ (UIColor*)amethystColor {
    // #9b59b6
    return [UIColor colorWithHexString:@"#9b59b6"];
}

+ (UIColor*)wisteriaColor {
    // #8e44ad
    return [UIColor colorWithHexString:@"#8e44ad"];
}

+ (UIColor*)wetAsphaltColor {
    // #34495e
    return [UIColor colorWithHexString:@"#34495e"];
}

+ (UIColor*)midnightBlueColor {
    // #2c3e50
    return [UIColor colorWithHexString:@"#2c3e50"];
}

+ (UIColor*)sunFlowerColor {
    // #f39c12
    return [UIColor colorWithHexString:@"#f39c12"];
}

+ (UIColor*)orangeColor {
    // #1abc9c
    return [UIColor colorWithHexString:@"#1abc9c"];
}

+ (UIColor*)carrotColor {
    // #e67e22
    return [UIColor colorWithHexString:@"#e67e22"];
}

+ (UIColor*)pumpkinColor {
    // #d35400
    return [UIColor colorWithHexString:@"#d35400"];
}

+ (UIColor*)alizarinColor {
    // #e74c3c
    return [UIColor colorWithHexString:@"#e74c3c"];
}

+ (UIColor*)pomegranateColor {
    // #c0392b
    return [UIColor colorWithHexString:@"#c0392b"];
}

+ (UIColor*)cloudsColor {
    // #ecf0f1
    return [UIColor colorWithHexString:@"#ecf0f1"];
}

+ (UIColor*)silverColor {
    // #bdc3c7
    return [UIColor colorWithHexString:@"#bdc3c7"];
}

+ (UIColor*)concreteColor {
    // #95a5a6
    return [UIColor colorWithHexString:@"#95a5a6"];
}

+ (UIColor*)asbestosColor {
    // #7f8c8d
    return [UIColor colorWithHexString:@"#7f8c8d"];
}


@end
