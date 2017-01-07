//
//  InviteFriendCell.m
//  yocheche
//
//  Created by carcool on 8/6/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "InviteFriendCell.h"

@implementation InviteFriendCell

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
    self.labelCode.text=[self.data objectForKey:@"coupon"];
    self.labelMoney.text=[NSString stringWithFormat:@"¥%@",[self.data objectForKey:@"invite"]];
    self.labelDesNormal.text=[self.data objectForKey:@"pay"];
    self.labelDesTotalNormal.text=[self.data objectForKey:@"deduction"];
    self.labelDesInvite.text=[self.data objectForKey:@"invite"];
    self.labelDesTotalInvite.text=[self.data objectForKey:@"deduction"];
    self.labelNote.text=[NSString stringWithFormat:@"1. 您只需使用第三方支付平台将最低至¥%@的订金支付到优车车，我们即可为您预订您心仪的教练。",[self.data objectForKey:@"invite"]];
}
-(IBAction)shareInviteCode:(id)sender
{
    [self.delegate shareInviteCode];
}
@end
