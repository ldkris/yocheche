//
//  MyCoachCell.m
//  yocheche
//
//  Created by carcool on 9/23/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyCoachCell.h"

@implementation MyCoachCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=YCC_GrayBG;
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"headimgurl"]]];
    if ([[self.data objectForKey:@"type"] integerValue]==2)
    {
        self.labelClassType.text=@"科目二";
    }
    else if ([[self.data objectForKey:@"type"] integerValue]==3)
    {
        self.labelClassType.text=@"科目三";
    }
    self.labelName.text=[self.data objectForKey:@"coachname"];
    self.labelSchool.text=[self.data objectForKey:@"dsname"];
}
@end
