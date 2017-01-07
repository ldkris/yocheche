//
//  TrainRecordWithFeeCell.m
//  yocheche
//
//  Created by carcool on 3/9/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "TrainRecordWithFeeCell.h"

@implementation TrainRecordWithFeeCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=YCC_GrayBG;
    [self.btn setColor:[UIColor whiteColor]];
    [self.btn.layer setBorderWidth:1.0];
    [self.btn.layer setBorderColor:[YCC_Green CGColor]];
    [self.btn setTitleColor:YCC_Green forState:UIControlStateNormal];
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)updateView
{
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"headimgurl"]]];
    self.labelTime.text=[self.data objectForKey:@"date"];
    NSArray *aryState=[NSArray arrayWithObjects:@"待评价",@"已评价",nil];
    self.labelState.text=[aryState objectAtIndex:[[self.data objectForKey:@"status"] integerValue]-1];
    
    self.labelName.text=[self.data objectForKey:@"coachname"];
    self.labelSchool.text=[self.data objectForKey:@"dsname"];
    
    if ([[self.data objectForKey:@"status"] integerValue]==1)
    {
        self.btn.hidden=NO;
        [self.btn setTitle:@"去评价" forState:UIControlStateNormal];
    }
    else
    {
        self.btn.hidden=YES;
    }
    
    self.labelFee.text=[NSString stringWithFormat:@"¥%d",[[self.data objectForKey:@"fee"] integerValue]];
}
-(IBAction)btnPressed:(id)sender
{
    if ([[self.data objectForKey:@"status"] integerValue]==1)
    {
        [self.delegate showCommentVC:self.data];
    }
}

@end
