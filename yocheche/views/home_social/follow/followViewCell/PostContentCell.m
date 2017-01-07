//
//  PostContentCell.m
//  yocheche
//
//  Created by carcool on 8/21/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "PostContentCell.h"

@implementation PostContentCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:YCC_GrayBG];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.labelContent removeFromSuperview];
    self.labelContent=nil;
    [self.contentBG removeFromSuperview];
    self.contentBG=nil;
    //height
    float contentHeight=[MyFounctions calculateLabelHeightWithString:[self.data objectForKey:@"content"] Width:240 font:[UIFont systemFontOfSize:14]];
    if (![[self.data objectForKey:@"content"] isEqualToString:@""])
    {
        self.labelContent=[[UILabel alloc] initWithFrame:CGRectMake(50,0,240, contentHeight)];
        [self.labelContent setNumberOfLines:0];
        [self.labelContent setTextColor:[UIColor darkGrayColor]];
        [self.labelContent setFont:[UIFont systemFontOfSize:14.0]];
        self.labelContent.text=[self.data objectForKey:@"content"];
        
        self.contentBG=[[UIView alloc] initWithFrame:CGRectMake(10, 0,300, contentHeight+10)];
        [self.contentBG setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.contentBG];
        [self.contentBG addSubview:self.labelContent];
    }
}
@end
