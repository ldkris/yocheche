//
//  HotCategoryCellNew.m
//  yocheche
//
//  Created by carcool on 1/13/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "HotCategoryCellNew.h"

@implementation HotCategoryCellNew

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=YCC_GrayBG;
    [self.imgBG setClipsToBounds:YES];
    [self.imgBG.layer setCornerRadius:3.0];
    [self.contentBG setBackgroundColor:[UIColor blackColor]];
    [self.contentBG setAlpha:0.7];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.img1 removeFromSuperview];
    [self.img2 removeFromSuperview];
    [self.img3 removeFromSuperview];
    self.img1=nil;
    self.img2=nil;
    self.img3=nil;
    self.img1=[[WebImageViewNormal alloc] initWithFrame:CGRectMake(20, 175, 90, 90)];
    self.img1.contentMode=UIViewContentModeScaleAspectFill;
    [self.img1 setClipsToBounds:YES];
    [self addSubview:self.img1];
    self.img2=[[WebImageViewNormal alloc] initWithFrame:CGRectMake(115, 175, 90, 90)];
    self.img2.contentMode=UIViewContentModeScaleAspectFill;
    [self.img2 setClipsToBounds:YES];
    [self addSubview:self.img2];
    self.img3=[[WebImageViewNormal alloc] initWithFrame:CGRectMake(210, 175, 90, 90)];
    self.img3.contentMode=UIViewContentModeScaleAspectFill;
    [self.img3 setClipsToBounds:YES];
    [self addSubview:self.img3];
    
    
    self.labelTitle.text=[self.data objectForKey:@"themeName"];
    self.labelSubTitle.text=[self.data objectForKey:@"desc"];
    [self.imgBG setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"iconurl"]]];
    NSArray *aryPosts=[self.data objectForKey:@"photos"];
    NSInteger i=0;
    while (i<aryPosts.count)
    {
        if (i==0)
        {
            [self.img1 setWebImageViewWithURL:[NSURL URLWithString:[[aryPosts objectAtIndex:i] objectForKey:@"imgurl"]]];
        }
        else if (i==1)
        {
            [self.img2 setWebImageViewWithURL:[NSURL URLWithString:[[aryPosts objectAtIndex:i] objectForKey:@"imgurl"]]];
        }
        else if (i==2)
        {
            [self.img3 setWebImageViewWithURL:[NSURL URLWithString:[[aryPosts objectAtIndex:i] objectForKey:@"imgurl"]]];
        }
        i++;
    }
}
@end
