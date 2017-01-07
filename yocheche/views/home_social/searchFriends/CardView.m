//
//  CardView.m
//  yocheche
//
//  Created by carcool on 6/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "CardView.h"
#import "SlidePostVC.h"
@implementation CardView
-(void)awakeFromNib
{
    [self.layer setBorderWidth:0.5];
    [self.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
//    [self.layer setShadowColor:[[UIColor darkGrayColor] CGColor]];
//    [self.layer setShadowOffset:CGSizeMake(4, 4)];
//    [self.layer setShadowRadius:2.0];
//    [self.layer setShadowOpacity:0.6];
    
    [self.btn addTarget:self action:@selector(showOtherCenterVC) forControlEvents:UIControlEventTouchUpInside];
    [self.btnPost addTarget:self action:@selector(showPostVC) forControlEvents:UIControlEventTouchUpInside];
    [self.pic setClipsToBounds:YES];
}
-(void)updateView
{
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"headurl"]]];
    [self.pic setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"imgurl"]]];
    self.laeblName.text=[self.data objectForKey:@"nikename"];
    self.laeblDistance.text=[NSString stringWithFormat:@"%@",[self.data objectForKey:@"distance"]];
}
-(void)showOtherCenterVC
{
//    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
//    [appdelegate.m_homeVC showOtherCenterVC:self.data];
    [self.delegate.delegate showOtherCenterVC:self.data];
}
-(void)showPostVC
{
//    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
//    [appdelegate.m_homeVC showPostVC:self.data];
    [self.delegate.delegate showPostVC:self.data];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
