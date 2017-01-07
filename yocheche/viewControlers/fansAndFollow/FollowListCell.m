//
//  FollowListCell.m
//  yocheche
//
//  Created by carcool on 8/24/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "FollowListCell.h"

@implementation FollowListCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [MyFounctions setLineViewMoreThin:self.lineView0];
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"userpic"]]];
    self.labelName.text=[self.data objectForKey:@"nikename"];
    self.labelDescription.text=[self.data objectForKey:@"desc"];
    if([[self.data objectForKey:@"status"] integerValue]==1)
    {
        [self.btnFollow setBackgroundColor:[UIColor lightGrayColor]];
        [self.btnFollow setTitle:@"已关注" forState:UIControlStateNormal];
        self.followType=@"2";
    }
    else if ([[self.data objectForKey:@"status"] integerValue]==2)
    {
        [self.btnFollow setBackgroundColor:YCC_Green];
        [self.btnFollow setTitle:@"关注" forState:UIControlStateNormal];
        self.followType=@"1";
    }
    else if([[self.data objectForKey:@"status"] integerValue]==3)
    {
        [self.btnFollow setBackgroundColor:[UIColor lightGrayColor]];
        [self.btnFollow setTitle:@"相互关注" forState:UIControlStateNormal];
        self.followType=@"2";
    }
    if ([__BASE64([self.data objectForKey:@"account"]) isEqualToString:[[MyFounctions getUserInfo] objectForKey:@"account"]])
    {
        self.btnFollow.hidden=YES;
    }
    else
    {
        self.btnFollow.hidden=NO;
    }
}
-(IBAction)followBtnPressed:(id)sender
{
    [self.vcDelegate followTheAccount:[self.data objectForKey:@"account"] followCell:self type:self.followType];
}
@end
