//
//  ChangeCoachCell.m
//  yocheche
//
//  Created by carcool on 2/17/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "ChangeCoachCell.h"
#import "changeCoachVC.h"
@implementation ChangeCoachCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=YCC_GrayBG;
    [self.btnOrder.layer setBorderWidth:1.0];
    [self.btnOrder.layer setBorderColor:[YCC_Green CGColor]];
    [self.btnOrder setClipsToBounds:YES];
    [self.btnOrder.layer setCornerRadius:3.0];
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
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"headimgurl"]]];
    self.labelInfo.text=[NSString stringWithFormat:@"%@ %@年教龄",[self.data objectForKey:@"teachItem"],[[self.data objectForKey:@"schoolAge"] stringValue]];
    self.labelName.text=[self.data objectForKey:@"coachname"];
}
-(IBAction)orderBtnPressed:(id)sender
{
    [self.delegate bundleCoach:[[self.data objectForKey:@"coachid"] stringValue]];
}
@end
