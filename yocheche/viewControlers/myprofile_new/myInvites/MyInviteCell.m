//
//  MyInviteCell.m
//  yocheche
//
//  Created by carcool on 9/5/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyInviteCell.h"

@implementation MyInviteCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"userpic"]]];
    self.labelName.text=[self.data objectForKey:@"nickname"];
    self.labelTime.text=@"";
}
@end
