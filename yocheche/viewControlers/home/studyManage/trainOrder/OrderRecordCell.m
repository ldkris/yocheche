//
//  OrderRecordCell.m
//  yocheche
//
//  Created by carcool on 2/18/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "OrderRecordCell.h"

@implementation OrderRecordCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=YCC_GrayBG;
    [self.btn setColor:[UIColor whiteColor]];
    [self.btn.layer setBorderWidth:1.0];
    [self.btn.layer setBorderColor:[YCC_Green CGColor]];
    [self.btn setTitleColor:YCC_Green forState:UIControlStateNormal];
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
    self.labelTime.text=[NSString stringWithFormat:@"%@ %@-%@",[self.data objectForKey:@"date"],[self.data objectForKey:@"beginTime"],[self.data objectForKey:@"endTime"]];
    NSArray *aryState=[NSArray arrayWithObjects:@"预约审核中",@"预约成功",@"预约失败",@"取消预约审核中",@"取消预约成功",@"取消预约失败",@"已过期",nil];
    self.labelState.text=[aryState objectAtIndex:[[self.data objectForKey:@"status"] integerValue]];
    
    self.labelName.text=[self.data objectForKey:@"coachname"];
    self.labelSchool.text=[self.data objectForKey:@"dsname"];
    
    if ([[self.data objectForKey:@"status"] integerValue]==0||[[self.data objectForKey:@"status"] integerValue]==1||[[self.data objectForKey:@"status"] integerValue]==5)
    {
        self.btn.hidden=NO;
        [self.btn setTitle:@"取消预约" forState:UIControlStateNormal];
    }
    else
    {
        self.btn.hidden=YES;
    }
}
-(IBAction)btnPressed:(id)sender
{
    if ([[self.data objectForKey:@"status"] integerValue]==0||[[self.data objectForKey:@"status"] integerValue]==1||[[self.data objectForKey:@"status"] integerValue]==5)
    {
        [self.delegate cancelOrderDrive:self.data];
    }
}
@end
