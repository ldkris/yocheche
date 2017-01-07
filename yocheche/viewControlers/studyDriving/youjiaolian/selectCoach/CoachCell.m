//
//  CoachCell.m
//  yocheche
//
//  Created by carcool on 7/22/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "CoachCell.h"

@implementation CoachCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.labelDistance setTextColor:YCC_TextColor];
    [self.labelMembers setTextColor:YCC_TextColor];
    [self.labelscore setTextColor:YCC_TextColor];
    [self.labelSchool setTextColor:YCC_TextColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.imgPortrait setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"userpic"]]];
    self.labelName.text=[self.data objectForKey:@"name"];
    self.labelSchool.text=[self.data objectForKey:@"drivingschoolname"];
    self.labelPrice.text=[NSString stringWithFormat:@"¥%@",[self.data objectForKey:@"fee"]];
    self.labelMembers.text=[NSString stringWithFormat:@"%d",[[self.data objectForKey:@"studentcount"] integerValue]];
    self.labelDistance.text=[self.data objectForKey:@"distance"];
    self.labelscore.text=[NSString stringWithFormat:@"%d",[[self.data objectForKey:@"score"] integerValue]];
    
}

@end
