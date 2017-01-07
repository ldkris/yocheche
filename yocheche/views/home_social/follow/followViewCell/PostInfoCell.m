//
//  PostInfoCell.m
//  yocheche
//
//  Created by carcool on 8/21/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "PostInfoCell.h"
#import <ShareSDK/ShareSDK.h>
@implementation PostInfoCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:YCC_GrayBG];
    [self.contentBG setRoundedCorners:TKRoundedCornerBottomLeft|TKRoundedCornerBottomRight];
    [self.contentBG setCornerRadius:3.0];
    [self.contentBG setBorderWidth:0];
    [self.moreBG setClipsToBounds:YES];
    [self.moreBG.layer setCornerRadius:3.0];
    self.moreBG.hidden=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    self.moreBG.hidden=YES;
    if ([[self.data objectForKey:@"follow"] integerValue]==0)
    {
        [self.likePostImg setImage:[UIImage imageNamed:@"taoxin_big"]];
    }
    else
    {
        [self.likePostImg setImage:[UIImage imageNamed:@"taoxin_big_red"]];
    }
    self.labelHeatNum.text=[NSString stringWithFormat:@"%@热度",[self.data objectForKey:@"heat_count"]];
}
#pragma mark -------- event response
-(IBAction)moreBtnPressed:(id)sender
{
    if (self.moreBG.hidden==NO)
    {
        
        self.moreBG.alpha=1;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.moreBG.alpha=0;
        } completion:^(BOOL finished) {
            self.moreBG.hidden=YES;
        }];
    }
    else
    {
        self.moreBG.hidden=NO;
        self.moreBG.alpha=0;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.moreBG.alpha=1;
        } completion:^(BOOL finished) {
            
        }];
        
    }
}

-(IBAction)GoodBtnPressed:(id)sender
{
    if (self.delegate)
    {
        AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        [appdelegate.m_homeVC likePostOperate:(NSMutableDictionary*)[NSDictionary dictionaryWithDictionary:self.data] postCell:self];
    }
    else
    {
        [self.vcDelegate likePostOperate:self.data postCell:self];
    }
}
-(IBAction)shareBtnPressed:(id)sender
{
    self.moreBG.hidden=YES;
    if (self.delegate)
    {
        AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        [appdelegate.m_homeVC sharePostDetail:self.data];
    }
    else
    {
        [self.vcDelegate sharePostDetail:self.data];
    }
}
-(IBAction)commentBtnPressed:(id)sender
{
    self.moreBG.hidden=YES;
    [self.vcDelegate CommentPostDetail:self.data];
}
-(IBAction)chatBtnPressed:(id)sender
{
    self.moreBG.hidden=YES;
    [self.vcDelegate ChatPostDetail:self.data];
}
@end
