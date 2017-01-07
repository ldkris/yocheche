//
//  TrainDetailCell0.m
//  yocheche
//
//  Created by carcool on 2/19/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "TrainDetailCell0.h"

@implementation TrainDetailCell0

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=YCC_GrayBG;
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    NSDictionary *coachData=self.data;
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[coachData objectForKey:@"headimgurl"]]];
    self.labelTime.text=[coachData objectForKey:@"practiceDate"];
    self.labelState.text=@"已完成";
    self.labelName.text=[coachData objectForKey:@"coachname"];
    self.labelClassType.text=[coachData objectForKey:@"teachItem"];
}
-(IBAction)avatarBtnPressed:(id)sender
{
    if (self.delegate)
    {
        [self.delegate showCoachDetailVC:[[self.data objectForKey:@"coachid"] stringValue]];
    }
}
@end
