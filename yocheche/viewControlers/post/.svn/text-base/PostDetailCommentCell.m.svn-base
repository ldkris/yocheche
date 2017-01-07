//
//  PostDetailCommentCell.m
//  yocheche
//
//  Created by carcool on 8/17/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "PostDetailCommentCell.h"
#import "OtherCenterVC.h"
#import "PostDeatilVC.h"
@implementation PostDetailCommentCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor clearColor];
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.labelComment removeFromSuperview];
    self.labelComment=nil;
    [self.contentBG removeFromSuperview];
    self.contentBG=nil;
    
    NSString *contentStr=@"";
    if ([[self.data objectForKey:@"type"] integerValue]==1)
    {
        contentStr=[self.data objectForKey:@"content"];
    }
    else if ([[self.data objectForKey:@"type"] integerValue]==2)
    {
        contentStr=[NSString stringWithFormat:@"回复%@:%@",[self.data objectForKey:@"replyNickname"],[self.data objectForKey:@"content"]];
    }
    float contentHeight=[MyFounctions calculateLabelHeightWithString:contentStr Width:230 font:[UIFont systemFontOfSize:14.0]];
    self.labelComment=[[UILabel alloc] initWithFrame:CGRectMake(68, 23, 230, contentHeight)];
    [self.labelComment setTextColor:[UIColor lightGrayColor]];
    [self.labelComment setFont:[UIFont systemFontOfSize:14.0]];
    self.labelComment.numberOfLines=0;
    [self addSubview:self.labelComment];
    self.labelComment.text=contentStr;
    
    self.contentBG=[[TKRoundedView alloc] initWithFrame:CGRectMake(10, 0, 300,23+contentHeight+15)];
    [self.contentBG setBackgroundColor:[UIColor whiteColor]];
    if (self.isLastOne==1)
    {
        [self.contentBG setRoundedCorners:TKRoundedCornerBottomLeft|TKRoundedCornerBottomRight];
        [self.contentBG setCornerRadius:3.0];
    }
    else
    {
        [self.contentBG setRoundedCorners:TKRoundedCornerBottomLeft|TKRoundedCornerBottomRight];
        [self.contentBG setCornerRadius:0];
    }
    [self.contentBG setBorderWidth:0];
    [self.contentView insertSubview:self.contentBG atIndex:0];
    
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"userpic"]]];
    self.labelName.text=[self.data objectForKey:@"nikename"];
    self.labelTime.text=[self.data objectForKey:@"comment_time"];
}
-(IBAction)avatarBtnpressed:(id)sender
{
    OtherCenterVC *vc=[[OtherCenterVC alloc] init];
    vc.preData=[NSDictionary dictionaryWithObject:[self.data objectForKey:@"account"] forKey:@"account"];
    [self.delegate.navigationController pushViewController:vc animated:YES];
}
@end
