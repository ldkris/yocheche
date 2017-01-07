//
//  DriveDetailCellTop.m
//  yocheche
//
//  Created by carcool on 9/7/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "DriveDetailCellTop.h"

@implementation DriveDetailCellTop

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=[UIColor clearColor];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    NSDictionary *coachData=[self.data objectForKey:@"coach"];
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[coachData objectForKey:@"coa_pic"]]];
    self.labelTime.text=[NSString stringWithFormat:@"%@ %@-%@",[coachData objectForKey:@"coa_date"],[coachData objectForKey:@"coa_begintime"],[coachData objectForKey:@"coa_endtime"]];
    NSArray *aryState=[NSArray arrayWithObjects:@"预约审核中",@"预约成功",@"预约失败",@"取消预约审核中",@"取消预约成功",@"取消预约失败",@"练车完成",@"学员未到场",@"过期未处理",@"待评价",nil];
    self.labelState.text=[aryState objectAtIndex:[[self.data objectForKey:@"status"] integerValue]];
    if(([[self.data objectForKey:@"status"] integerValue]==6||[[self.data objectForKey:@"status"] integerValue]==9)&&[[self.data objectForKey:@"haveComment"] boolValue]==true)
    {
        self.labelState.text=@"练车完成";
    }
    else if (([[self.data objectForKey:@"status"] integerValue]==6||[[self.data objectForKey:@"status"] integerValue]==9)&&[[self.data objectForKey:@"haveComment"] boolValue]==false)
    {
        self.labelState.text=@"待评价";
    }
    self.labelName.text=[coachData objectForKey:@"coa_idcname"];
    self.labelClassType.text=[coachData objectForKey:@"coa_kemu"];
}
-(IBAction)avatarBtnPressed:(id)sender
{
    if (self.delegate)
    {
        [self.delegate showCoachDetailVC:[[self.data objectForKey:@"coach"] objectForKey:@"coachid"]];
    }
}
@end
