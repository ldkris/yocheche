//
//  PaySuccessCell.m
//  yocheche
//
//  Created by carcool on 8/23/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "PaySuccessCell.h"

@implementation PaySuccessCell

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
    self.labelSchoolAndCoach.text=[NSString stringWithFormat:@"      你已经预定%@%@。",[self.data objectForKey:@"drivingschoolname"],[self.data objectForKey:@"coachname"]];
    self.labelNewFee.text=[NSString stringWithFormat:@"¥%d",[[self.data objectForKey:@"actualfee"] integerValue]];
    self.labelOldFee.text=[NSString stringWithFormat:@"¥%d",[[self.data objectForKey:@"fee"] integerValue]];
}
@end
