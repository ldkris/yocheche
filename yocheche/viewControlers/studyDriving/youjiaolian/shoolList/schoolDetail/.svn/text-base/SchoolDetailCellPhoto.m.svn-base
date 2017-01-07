//
//  SchoolDetailCellPhoto.m
//  yocheche
//
//  Created by carcool on 2/23/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "SchoolDetailCellPhoto.h"

@implementation SchoolDetailCellPhoto

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor whiteColor];
    self.imagePlayerView.hidden=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    if ([(NSArray*)[self.data objectForKey:@"styleList"] count]>0)
    {
        [self creatPageScrollview];
    }
    
}
-(void)creatPageScrollview
{
    self.imagePlayerView.hidden=NO;
    self.imagePlayerView.tag=0;
    [self.imagePlayerView initWithCount:[(NSArray*)[self.data objectForKey:@"styleList"] count] delegate:self];
    self.imagePlayerView.scrollInterval = 999.0f;
    self.imagePlayerView.autoScroll=NO;
    [self.imagePlayerView setBackgroundColor:YCC_GrayBG];
    
    // adjust pageControl position
    self.imagePlayerView.pageControlPosition = ICPageControlPosition_BottomCenter;
    
    // hide pageControl or not
    self.imagePlayerView.hidePageControl = NO;
}
#pragma mark ------------- image player delegate
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(WebImageViewNormal *)imageView index:(NSInteger)index
{
    [imageView setWebImageViewWithURL:[NSURL URLWithString:[[[self.data objectForKey:@"styleList"] objectAtIndex:index] objectForKey:@"styleUrl"]]];
}
@end
