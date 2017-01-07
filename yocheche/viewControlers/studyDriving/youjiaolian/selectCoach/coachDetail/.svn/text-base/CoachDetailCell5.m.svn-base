//
//  CoachDetailCell5.m
//  yocheche
//
//  Created by carcool on 8/4/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "CoachDetailCell5.h"

@implementation CoachDetailCell5

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor whiteColor];
    [self.bottomBG setFrame:CGRectMake(0, PARENT_Y(self.labelCommentContent)+self.delegate.contentHeight+5, PARENT_WIDTH(self.bottomBG), PARENT_HEIGHT(self.bottomBG))];
    [self addSubview:self.bottomBG];
    
    [self.labelCommentName setTextColor:YCC_TextColor];
    [self.labelCommentTime setTextColor:YCC_TextColor];
    [self.labelGoodComment setTextColor:YCC_TextColor];
    [self.labelLookUpAll setTextColor:YCC_TextColor];
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    
    self.bottomBG.hidden=YES;
    self.hidden=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViews
{
    if ([[self.delegate.commentData objectForKey:@"date"] isEqualToString:@""]||![self.delegate.commentData objectForKey:@"date"])
    {
        return;
    }
    self.bottomBG.hidden=NO;
    self.hidden=NO;
    //comment
    self.labelCommentTime.text=[self.delegate.commentData objectForKey:@"date"];
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.delegate.commentData objectForKey:@"headimgurl"]]];
    self.labelCommentName.text=[self.delegate.commentData objectForKey:@"nickname"];
//    if ([[self.delegate.commentData objectForKey:@"nickname"] isEqualToString:@""]||![self.delegate.commentData objectForKey:@"nickname"])
//    {
//        self.labelCommentName.text=@"暂无评价";
//    }
    if (self.labelCommentContent)
    {
        [self.labelCommentContent removeFromSuperview];
        self.labelCommentContent=nil;
    }
    
    self.labelCommentContent=[[UILabel alloc] initWithFrame:CGRectMake(10, 60, 300, self.delegate.contentHeight)];
    self.labelCommentContent.text=[self.delegate.commentData objectForKey:@"content"];
    [self.labelCommentContent setTextColor:[UIColor darkGrayColor]];
    [self.labelCommentContent setFont:[UIFont systemFontOfSize:14.0]];
    self.labelCommentContent.numberOfLines=0;
    [self addSubview:self.labelCommentContent];
    
    
    [self.bottomBG setFrame:CGRectMake(0, PARENT_Y(self.labelCommentContent)+self.delegate.contentHeight+5, PARENT_WIDTH(self.bottomBG), PARENT_HEIGHT(self.bottomBG))];
    if ([[self.delegate.commentData objectForKey:@"type"] integerValue]==1)
    {
        self.imgGood.hidden=NO;
        self.labelGoodComment.hidden=NO;
    }
    else
    {
        self.imgGood.hidden=YES;
        self.labelGoodComment.hidden=YES;
    }
    
}
#pragma mark ------- event response
-(IBAction)showCommentVC:(id)sender
{
    [self.delegate showCommentVC];
}

@end
