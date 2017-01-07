//
//  CoachDetailCell2.m
//  yocheche
//
//  Created by carcool on 8/4/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "CoachDetailCell2.h"

@implementation CoachDetailCell2

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViews
{
    self.labelPerson.text=[self.data objectForKey:@"person"];
    self.labelFee.text=[self.data objectForKey:@"feeinclude"];
    self.labelCoupon.text=[self.data objectForKey:@"deduction"];
    self.labelCouponCode.text=[self.data objectForKey:@"coupon"];
    self.labelStudyPickup.text=[self.data objectForKey:@"xcjs"];
    self.labelExamPickup.text=[self.data objectForKey:@"ksjs"];
}
@end
