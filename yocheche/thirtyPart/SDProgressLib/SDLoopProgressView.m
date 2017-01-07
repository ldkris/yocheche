//
//  SDLoopProgressView.m
//  SDProgressView
//
//  Created by aier on 15-2-19.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "SDLoopProgressView.h"

@implementation SDLoopProgressView

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.5;
    [YCC_Green set];
    
    CGContextSetLineWidth(ctx, 2);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGFloat to = - M_PI * 0.5 + self.progress * M_PI * 2 + 0.05; // 初始值0.05
    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5 - SDProgressViewItemMargin;
    CGContextAddArc(ctx, xCenter, yCenter, radius, - M_PI * 0.5, to, 0);
    CGContextStrokePath(ctx);
    
    // 进度数字
//    NSString *progressStr = [NSString stringWithFormat:@"%.0f", self.progress * 100];
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//    attributes[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20 * SDProgressViewFontScale];
//    attributes[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    [self setCenterProgressText:progressStr withAttributes:attributes];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:15.0];
    attributes[NSForegroundColorAttributeName] = YCC_Green;
    [self setCenterProgressText:@"抢单中" withAttributes:attributes];
}

@end
