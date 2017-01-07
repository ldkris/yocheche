//
//  AboutYochecheCell.m
//  yocheche
//
//  Created by carcool on 11/9/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "AboutYochecheCell.h"

@implementation AboutYochecheCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:YCC_GrayBG];
    [self.lineView1 setBackgroundColor:YCC_GrayBG];
    [self.lineView2 setBackgroundColor:YCC_GrayBG];
    [self.lineView3 setBackgroundColor:YCC_GrayBG];
    [self updateView];
}
-(void)updateView
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    self.labelVersion.text=[infoDic objectForKey:@"CFBundleShortVersionString"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)btnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if (btn.tag==0)
    {
        [self.delegate showAboutUsVC];
    }
    else if (btn.tag==1)
    {
        
    }
    else if (btn.tag==2)
    {
        [self.delegate callThePhone];
    }
    else if (btn.tag==3)
    {
        [self.delegate clearRibbish];
    }
}
@end
