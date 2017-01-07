//
//  TrainDetailCell3.m
//  yocheche
//
//  Created by carcool on 2/19/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "TrainDetailCell3.h"

@implementation TrainDetailCell3

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=YCC_GrayBG;
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    float contentHight=[MyFounctions calculateLabelHeightWithString:[self.data objectForKey:@"content"] Width:280.0 font:[UIFont systemFontOfSize:14.0]];
    
    self.contentBG=[[UIView alloc] initWithFrame:CGRectMake(10, 0, 300,20+contentHight+20)];
    [self.contentBG setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.contentBG];
    
    self.labelContent=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 280, contentHight)];
    [self.labelContent setText:[self.data objectForKey:@"content"]];
    [self.labelContent setFont:[UIFont systemFontOfSize:14.0]];
    [self.labelContent setTextColor:[UIColor darkGrayColor]];
    [self.contentBG addSubview:self.labelContent];
    
    self.labelCommentTime=[[UILabel alloc] initWithFrame:CGRectMake(10, contentHight+5, 280, 20)];
    [self.labelCommentTime setText:[self.data objectForKey:@"commentDate"]];
    [self.labelCommentTime setFont:[UIFont systemFontOfSize:13.0]];
    [self.labelCommentTime setTextColor:[UIColor lightGrayColor]];
    [self.labelCommentTime setTextAlignment:NSTextAlignmentRight];
    [self.contentBG addSubview:self.labelCommentTime];
}
@end
