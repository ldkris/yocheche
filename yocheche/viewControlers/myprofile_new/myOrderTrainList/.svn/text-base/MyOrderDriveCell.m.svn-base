//
//  MyOrderDriveCell.m
//  yocheche
//
//  Created by carcool on 9/7/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyOrderDriveCell.h"

@implementation MyOrderDriveCell

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
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"userprc"]]];
    self.labelTime.text=[NSString stringWithFormat:@"%@ %@-%@",[self.data objectForKey:@"date"],[self.data objectForKey:@"begin_time"],[self.data objectForKey:@"end_time"]];
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
    self.labelName.text=[self.data objectForKey:@"idc_name"];
    self.labelClassType.text=[self.data objectForKey:@"kemu"];
    
    if ([[self.data objectForKey:@"status"] integerValue]==1||[[self.data objectForKey:@"status"] integerValue]==5)
    {
        self.btn.hidden=NO;
        [self.btn setTitle:@"取消预约" forState:UIControlStateNormal];
    }
    else if (([[self.data objectForKey:@"status"] integerValue]==6||[[self.data objectForKey:@"status"] integerValue]==9)&&[[self.data objectForKey:@"haveComment"] boolValue]==false)
    {
        self.btn.hidden=NO;
        [self.btn setTitle:@"去评价" forState:UIControlStateNormal];
    }
    else
    {
        self.btn.hidden=YES;
    }
}
-(IBAction)btnPressed:(id)sender
{
    if ([[self.data objectForKey:@"status"] integerValue]==1||[[self.data objectForKey:@"status"] integerValue]==5)
    {
        [self.delegate cancelOrderDrive:self.data];
    }
    else if ([[self.data objectForKey:@"status"] integerValue]==6||[[self.data objectForKey:@"status"] integerValue]==9)
    {
        [self.delegate showCommentVC:self.data];
    }
}
@end
