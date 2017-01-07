//
//  SchoolDetailCell0.m
//  yocheche
//
//  Created by carcool on 12/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "SchoolDetailCell0.h"

@implementation SchoolDetailCell0

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor whiteColor];
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self creatPageScrollview];
    self.labelName.text=[self.data objectForKey:@"dsname"];
    self.labelPhone.text=[self.data objectForKey:@"phone"];
    self.labelAddress.text=[self.data objectForKey:@"address"];
}
-(void)creatPageScrollview
{
    self.imagePlayerView.tag=0;
    [self.imagePlayerView initWithCount:[(NSArray*)[self.data objectForKey:@"styleList"] count] delegate:self];
    self.imagePlayerView.scrollInterval = 999.0f;
    self.imagePlayerView.autoScroll=NO;
    
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
#pragma mark ----------- event response ----------
-(IBAction)callThePhone:(id)sender
{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[self.data objectForKey:@"phone"]]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self addSubview:callWebview];
}
@end
