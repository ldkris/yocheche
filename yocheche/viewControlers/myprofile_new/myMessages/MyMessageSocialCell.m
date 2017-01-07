//
//  MyMessageSocialCell.m
//  yocheche
//
//  Created by carcool on 9/20/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyMessageSocialCell.h"

@implementation MyMessageSocialCell

- (void)awakeFromNib {
    // Initialization code
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [self.pic setClipsToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"userpic"]]];
    [self.pic setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"imgurl"]]];
    self.labelName.text=[self.data objectForKey:@"nikename"];
    self.labelComment.text=[self.data objectForKey:@"content"];
    self.labelTime.text=[self.data objectForKey:@"operatetime"];
    if ([[self.data objectForKey:@"datatype"] integerValue]==1)//赞
    {
        self.taoxin.hidden=NO;
        self.labelComment.hidden=YES;
    }
    else if ([[self.data objectForKey:@"datatype"] integerValue]==2)//comment
    {
        self.taoxin.hidden=YES;
        self.labelComment.hidden=NO;
    }
}
-(IBAction)showOtherCenterVC:(id)sender
{
    [self.delegate showOtherCenterVC:[self.data objectForKey:@"otheraccount"]];
}
@end
