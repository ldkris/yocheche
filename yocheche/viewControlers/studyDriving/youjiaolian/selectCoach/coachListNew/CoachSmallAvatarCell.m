//
//  CoachSmallAvatarCell.m
//  yocheche
//
//  Created by carcool on 12/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "CoachSmallAvatarCell.h"

@implementation CoachSmallAvatarCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=YCC_GrayBG;
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
    [self.contentBG setClipsToBounds:YES];
    [self.contentBG.layer setCornerRadius:3.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"coachPic"]]];
    self.labelGood.text=[[self.data objectForKey:@"goodNum"] stringValue];
    NSString *strType=@"";
    if ([[self.data objectForKey:@"type"] integerValue]==1)
    {
        strType=@"全科";
    }
    else if ([[self.data objectForKey:@"type"] integerValue]==2)
    {
        strType=@"科目二";
    }
    else if ([[self.data objectForKey:@"type"] integerValue]==3)
    {
        strType=@"科目三";
    }
    self.labelInfo.text=[NSString stringWithFormat:@"%@ %@",strType,[self.data objectForKey:@"jl"]];
    self.labelName.text=[self.data objectForKey:@"coachName"];
    self.labelPeople.text=[[self.data objectForKey:@"stuNum"] stringValue];
    self.labelPrice.text=[NSString stringWithFormat:@"¥%d",[[self.data objectForKey:@"fee"] integerValue]];
}
@end
