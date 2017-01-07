//
//  CoachDetailCellPhotos.m
//  yocheche
//
//  Created by carcool on 2/20/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "CoachDetailCellPhotos.h"

@implementation CoachDetailCellPhotos

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
-(void)updateViews
{
    if ([(NSArray*)[self.delegate.coachData objectForKey:@"imgurls"] count]>0)
    {
        [self creatPageScrollview];
    }
    
}
-(void)creatPageScrollview
{
    self.imagePlayerView.hidden=NO;
    self.imagePlayerView.tag=0;
    [self.imagePlayerView initWithCount:[(NSArray*)[self.delegate.coachData objectForKey:@"imgurls"] count] delegate:self];
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
    [imageView setWebImageViewWithURL:[NSURL URLWithString:[[self.delegate.coachData objectForKey:@"imgurls"] objectAtIndex:index]]];
}
@end
