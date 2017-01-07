//
//  InputInviteCodeCell1.m
//  yocheche
//
//  Created by carcool on 8/6/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "InputInviteCodeCell1.h"

@implementation InputInviteCodeCell1

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
    self.labelName.text=[self.data objectForKey:@"nickname"];
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"userpic"]]];
}
@end
