//
//  HomeVCCell0.m
//  yocheche
//
//  Created by carcool on 1/11/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "HomeVCCell0.h"
#import "HomeVC.h"
#import "WebViewVC.h"
@implementation HomeVCCell0

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self creatPageScrollview];
}
-(void)creatPageScrollview
{
    [self.imagePlayerView removeFromSuperview];
    self.imagePlayerView=nil;
    
    self.imagePlayerView=[[ImagePlayerView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 142)];
    [self addSubview:self.imagePlayerView];
    self.imagePlayerView.tag=0;
    [self.imagePlayerView initWithCount:[self.delegate.m_aryAdversHome count] delegate:self];
    self.imagePlayerView.scrollInterval = 5.0f;
    self.imagePlayerView.autoScroll=YES;
    
    // adjust pageControl position
    self.imagePlayerView.pageControlPosition = ICPageControlPosition_BottomCenter;
    
    // hide pageControl or not
    if ([self.delegate.m_aryAdversHome count]>1)
    {
        self.imagePlayerView.hidePageControl = NO;
    }
    else
    {
        self.imagePlayerView.hidePageControl = YES;
    }
}
#pragma mark ------------- image player delegate
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(WebImageViewNormal *)imageView index:(NSInteger)index
{
    [imageView setWebImageViewWithURL:[NSURL URLWithString:[[self.delegate.m_aryAdversHome objectAtIndex:index] objectForKey:@"imgurl"]]];
    
}
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NSString *skipURL=[[self.delegate.m_aryAdversHome objectAtIndex:index] objectForKey:@"imgSkipUrl"];
    if (![skipURL isEqualToString:@""])
    {
        //Umeng
        NSDictionary *dict = @{@"title" : [[self.delegate.m_aryAdversHome objectAtIndex:index] objectForKey:@"title"]};
        [MobClick event:@"home_adver" attributes:dict];
        
        AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.tabBarController hideTabBar];
        self.delegate.navigationController.navigationBar.hidden=NO;
        
        WebViewVC *vc=[[WebViewVC alloc] init];
        vc.title=[[self.delegate.m_aryAdversHome objectAtIndex:index] objectForKey:@"title"];
        vc.urlStr=skipURL;
        [self.delegate.navigationController pushViewController:vc animated:YES];
    }
    
}
#pragma mark ------------ event response --------------
-(IBAction)btnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    switch (btn.tag)
    {
        case 0:
            [self.delegate showStudyManageVC];
            break;
        case 1:
            [self.delegate orderTrainDrive];
            break;
        case 2:
//            [self.delegate showSchoolListVC];
            [self.delegate showCoachListVC];
            break;
        case 3:
//            [self.delegate showCoachListVC];
            [self.delegate showFenqiVC];
            break;
        case 4:
            [self.delegate showSelectProgressVC];
            break;
        case 5:
//            [self.delegate showKnowledgevc];
//            [self.delegate showOrderExamVC];
            [self.delegate checkToApplyOrApplyedStatus];
            break;
        default:
            break;
    }
}
@end
