//
//  SignInDetailTopCell.m
//  yocheche
//
//  Created by carcool on 11/20/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "SignInDetailTopCell.h"

@implementation SignInDetailTopCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=[UIColor clearColor];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"headImgurl"]]];
    self.labelTime.text=[self.data objectForKey:@"sign_time"];
    NSArray *aryState=[NSArray arrayWithObjects:@"练习中",@"待评价",@"已评价",nil];
    self.labelState.text=[aryState objectAtIndex:[[self.preData objectForKey:@"comment_status"] integerValue]];
    self.labelName.text=[self.data objectForKey:@"coachname"];
    if ([[self.data objectForKey:@"teaching_item"] integerValue]==2)
    {
        self.labelClassType.text=@"科目二";
    }
    else
    {
        self.labelClassType.text=@"科目三";
    }
    
}
-(IBAction)avatarBtnPressed:(id)sender
{
    if (self.delegate)
    {
        [self.delegate showCoachDetailVC:[[self.data objectForKey:@"coachid"] stringValue]];
    }
}

@end
