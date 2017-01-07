//
//  OrderCoachCell.m
//  yocheche
//
//  Created by carcool on 2/4/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "OrderCoachCell.h"
#import "OrderTrainingVC.h"
@implementation OrderCoachCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=YCC_GrayBG;
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.btnChangeCoach.layer setBorderWidth:1.0];
    [self.btnChangeCoach.layer setBorderColor:[YCC_Green CGColor]];
    [self.btnChangeCoach setClipsToBounds:YES];
    [self.btnChangeCoach.layer setCornerRadius:3.0];
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    self.labelName.text=[self.data objectForKey:@"coachname"];
    self.labelSchool.text=[self.data objectForKey:@"dsname"];
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"headimgurl"]]];
}
-(IBAction)changeCoachBtnPressed:(id)sender
{
    [self.delegate showChangeCoachVC];
}
@end
