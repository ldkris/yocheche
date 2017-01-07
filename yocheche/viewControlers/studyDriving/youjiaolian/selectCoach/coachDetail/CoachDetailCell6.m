//
//  CoachDetailCell6.m
//  yocheche
//
//  Created by carcool on 8/4/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "CoachDetailCell6.h"

@implementation CoachDetailCell6

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor whiteColor];
    [self.labelSpace setTextColor:YCC_TextColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViews
{
    //space
    [self.imgSpaceMap setWebImageViewWithURL:[NSURL URLWithString:[self.delegate.spaceData objectForKey:@"mapurl"]]];
    self.labelSpace.text=[NSString stringWithFormat:@"训练场 %@",[self.delegate.spaceData objectForKey:@"name"]];
}
#pragma mark ------- event response
-(IBAction)showSpaceMap:(id)sender
{
    [self.delegate showLookupMapVC];
}

@end
