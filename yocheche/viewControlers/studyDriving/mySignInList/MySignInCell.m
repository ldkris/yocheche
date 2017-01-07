//
//  MySignInCell.m
//  yocheche
//
//  Created by carcool on 11/20/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MySignInCell.h"

@implementation MySignInCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=YCC_GrayBG;
    [self.btn setColor:YCC_Green];
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"headImgurl"]]];
    self.labelTime.text=[self.data objectForKey:@"sign_time"];
    NSArray *aryState=[NSArray arrayWithObjects:@"练车中",@"待评价",@"已评价",nil];
    self.labelState.text=[aryState objectAtIndex:[[self.data objectForKey:@"comment_status"] integerValue]];
    self.labelName.text=[self.data objectForKey:@"coachname"];
    self.labelClassType.text=[[self.data objectForKey:@"teaching_item"] integerValue]==2?@"科目二":@"科目三";
    
    if ([[self.data objectForKey:@"comment_status"] integerValue]==1)
    {
        self.btn.hidden=NO;
    }
    else
    {
        self.btn.hidden=YES;
    }
}
-(IBAction)btnPressed:(id)sender
{
    [self.delegate showCommentVC:self.data];
}

@end
