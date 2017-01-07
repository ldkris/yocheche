//
//  SchoolDetailCell1.m
//  yocheche
//
//  Created by carcool on 12/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "SchoolDetailCell1.h"

@implementation SchoolDetailCell1

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=YCC_GrayBG;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.labelDescription removeFromSuperview];
    self.labelDescription=nil;
    [self.contentBG removeFromSuperview];
    self.contentBG=nil;
    float contentHeiht=[MyFounctions calculateLabelHeightWithString:[self.data objectForKey:@"description"] Width:280 font:[UIFont systemFontOfSize:14]];
    
    self.contentBG=[[UIView alloc] initWithFrame:CGRectMake(10, 0, 300, 33+contentHeiht+16)];
    [self.contentBG setBackgroundColor:[UIColor whiteColor]];
    [self.contentView insertSubview:self.contentBG atIndex:0];
    
    self.labelDescription=[[UILabel alloc] initWithFrame:CGRectMake(20, 33, 280, 51)];
    [self.labelDescription setTextColor:[UIColor blackColor]];
    [self.labelDescription setFont:[UIFont systemFontOfSize:14.0]];
    self.labelDescription.numberOfLines=0;
    self.labelDescription.text=[self.data objectForKey:@"description"];
    if (self.descriptionExpand==0)
    {
        [self.labelDescription setFrame:CGRectMake(20, 33, 280, 51)];
        [self.contentBG setFrame:CGRectMake(PARENT_X(self.contentBG), PARENT_Y(self.contentBG), PARENT_WIDTH(self.contentBG), 33+51+16)];
    }
    else
    {
        [self.labelDescription setFrame:CGRectMake(20, 33, 280, contentHeiht)];
        [self.contentBG setFrame:CGRectMake(PARENT_X(self.contentBG), PARENT_Y(self.contentBG), PARENT_WIDTH(self.contentBG), 33+contentHeiht+16)];
    }
    self.labelDescription.text=[self.data objectForKey:@"description"];
    [self addSubview:self.labelDescription];
}
@end
