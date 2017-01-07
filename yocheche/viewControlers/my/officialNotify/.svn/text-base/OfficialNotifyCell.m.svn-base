//
//  OfficialNotifyCell.m
//  yocheche
//
//  Created by carcool on 8/24/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "OfficialNotifyCell.h"

@implementation OfficialNotifyCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.labelContent removeFromSuperview];
    self.labelContent=nil;
    float contentHeight=[MyFounctions calculateLabelHeightWithString:[self.data objectForKey:@"content"] Width:304 font:[UIFont systemFontOfSize:14.0]];
    self.labelContent=[[UILabel alloc] initWithFrame:CGRectMake(8, 30, 304, contentHeight)];
    [self.labelContent setText:[self.data objectForKey:@"content"]];
    self.labelContent.numberOfLines=0;
    [self.labelContent setFont:[UIFont systemFontOfSize:14.0]];
    [self.labelContent setTextColor:[UIColor darkGrayColor]];
    
    self.labelTitle.text=[self.data objectForKey:@"title"];
    self.labelTime.text=[self.data objectForKey:@"datetime"];
    
}

@end
