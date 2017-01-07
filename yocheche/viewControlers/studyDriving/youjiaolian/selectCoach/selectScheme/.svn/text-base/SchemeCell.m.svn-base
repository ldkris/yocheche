//
//  SchemeCell.m
//  yocheche
//
//  Created by carcool on 8/6/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "SchemeCell.h"
#import "CoachDetailVC.h"
@implementation SchemeCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    if(self.index==self.delegate.selectedIndex)
    {
        [self.imgSelect setImage:[UIImage imageNamed:@"selectScheme_on"]];
    }
    else
    {
        [self.imgSelect setImage:[UIImage imageNamed:@"selectScheme_off"]];
    }
    
    self.data=[self.delegate.delegate.feeArray objectAtIndex:self.index];
    
    self.labelPrice.text=[NSString stringWithFormat:@"¥%d",[[self.data objectForKey:@"fee"] integerValue]];
    self.labelName.text=[self.data objectForKey:@"name"];
    
    self.labelPerson.text=[self.data objectForKey:@"person"];
    self.labelFee.text=[self.data objectForKey:@"feeinclude"];
    self.labelCoupon.text=[self.data objectForKey:@"deduction"];
    self.labelCouponCode.text=[self.data objectForKey:@"coupon"];
    self.labelStudyPickup.text=[self.data objectForKey:@"xcjs"];
    self.labelExamPickup.text=[self.data objectForKey:@"ksjs"];
    self.labelExplain.text=[NSString stringWithFormat:@"%@",[self.data objectForKey:@"description"]];
}
#pragma mark -------- event response
-(IBAction)selectBtnPressed:(id)sender
{
    [self.delegate setSelectedScheme:self.index];
}

@end
