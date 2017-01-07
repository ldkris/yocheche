//
//  CommentCell.m
//  yocheche
//
//  Created by carcool on 8/6/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=YCC_GrayBG;
    [self.bottomBG setBackgroundColor:YCC_GrayBG];
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
    
    [self addSubview:self.bottomBG];
    self.m_aryBtns=[NSMutableArray array];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    if (self.labelContent)
    {
        [self.labelContent removeFromSuperview];
        self.labelContent=nil;
        [self.commentBG removeFromSuperview];
        self.commentBG=nil;
    }
    //comment
    self.labelContent=[[UILabel alloc] initWithFrame:CGRectMake(20, 70, 280, self.contentHeight)];
    self.labelContent.text=[self.data objectForKey:@"content"];
    [self.labelContent setTextColor:[UIColor darkGrayColor]];
    [self.labelContent setFont:[UIFont systemFontOfSize:14.0]];
    self.labelContent.numberOfLines=0;
    [self addSubview:self.labelContent];
    NSLog(@"self.contentHeight :%f",self.contentHeight);
    self.commentBG=[[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 70+self.contentHeight+10)];
    [self.commentBG setBackgroundColor:[UIColor whiteColor]];
    [self.contentView insertSubview:self.commentBG atIndex:0];
    
    for (UIButton *btn in self.m_aryBtns)
    {
        [btn removeFromSuperview];
    }
    [self.m_aryBtns removeAllObjects];
    [self.tagsBG removeFromSuperview];
    self.tagsBG=nil;
    NSArray *tagsAry=[self.data objectForKey:@"tags"];
    float tagHeight=tagsAry.count>0?((tagsAry.count+2)/3)*(30+5):0;
    self.tagsBG=[[UIView alloc] initWithFrame:CGRectMake(10, 70+self.contentHeight+10, 300, tagHeight)];
    [self.tagsBG setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.tagsBG];
    
    float btnWidth=(300-40)/3.0;
    NSInteger i=0;
    for (NSString *dic in tagsAry)
    {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn.layer setBorderWidth:0.5];
        [btn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [btn setFrame:CGRectMake(10+i%3*(btnWidth+10),0+(i/3)*(30+5), btnWidth, 30)];
        [btn setTitle:dic forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
        btn.tag=i;
        [self.m_aryBtns addObject:btn];
        [self.tagsBG addSubview:btn];
        i++;
    }
    
    [self.bottomBG setFrame:CGRectMake(0, 70+self.contentHeight+10+tagHeight, PARENT_WIDTH(self.bottomBG), PARENT_HEIGHT(self.bottomBG))];
    
    self.labelTime.text=[self.data objectForKey:@"date"];
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"imgurl"]]];
    self.labelName.text=[self.data objectForKey:@"nickname"];
    
    if ([[self.data objectForKey:@"type"] integerValue]==1)
    {
        self.imgGood.hidden=NO;
        self.labelGoodComment.hidden=NO;
        self.labelGoodComment.text=@"好评";
    }
//    else if ([[self.data objectForKey:@"type"] integerValue]==2)
//    {
//        self.imgGood.hidden=NO;
//        self.labelGoodComment.hidden=NO;
//        self.labelGoodComment.text=@"中";
//    }
//    else if ([[self.data objectForKey:@"type"] integerValue]==3)
//    {
//        self.imgGood.hidden=NO;
//        self.labelGoodComment.hidden=NO;
//        self.labelGoodComment.text=@"差";
//    }
    else
    {
        self.imgGood.hidden=YES;
        self.labelGoodComment.hidden=YES;
    }

}
-(void)updateViewForOrderDriveComment
{
    if (self.labelContent)
    {
        [self.labelContent removeFromSuperview];
        self.labelContent=nil;
        [self.commentBG removeFromSuperview];
        self.commentBG=nil;
    }
    self.labelContent=[[UILabel alloc] initWithFrame:CGRectMake(20, 70, 280, self.contentHeight)];
    self.labelContent.text=[[self.data objectForKey:@"student"] objectForKey:@"stu_content"];
    [self.labelContent setTextColor:[UIColor darkGrayColor]];
    [self.labelContent setFont:[UIFont systemFontOfSize:14.0]];
    self.labelContent.numberOfLines=0;
    [self addSubview:self.labelContent];
    
    self.commentBG=[[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 70+self.contentHeight-10)];
    [self.commentBG setBackgroundColor:[UIColor whiteColor]];
    [self.contentView insertSubview:self.commentBG atIndex:0];
    [self.bottomBG setFrame:CGRectMake(0, 70+self.contentHeight, PARENT_WIDTH(self.bottomBG), PARENT_HEIGHT(self.bottomBG))];
    
    self.labelTime.text=[[self.data objectForKey:@"student"] objectForKey:@"stu_createtime"];
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[[self.data objectForKey:@"student"] objectForKey:@"stu_pic"]]];
    self.labelName.text=[[self.data objectForKey:@"student"] objectForKey:@"stu_name"];
    
    if ([[[self.data objectForKey:@"student"] objectForKey:@"stu_comment_type"] integerValue]==1)
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
//-(void)updateViewForSignInComment
//{
//    if (self.labelContent)
//    {
//        [self.labelContent removeFromSuperview];
//        self.labelContent=nil;
//        [self.commentBG removeFromSuperview];
//        self.commentBG=nil;
//    }
//    self.labelContent=[[UILabel alloc] initWithFrame:CGRectMake(83, 70, 224, self.contentHeight)];
//    self.labelContent.text=[self.data objectForKey:@"content"];
//    [self.labelContent setTextColor:[UIColor darkGrayColor]];
//    [self.labelContent setFont:[UIFont systemFontOfSize:14.0]];
//    self.labelContent.numberOfLines=0;
//    [self addSubview:self.labelContent];
//    
//    self.commentBG=[[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 70+self.contentHeight-10)];
//    [self.commentBG setBackgroundColor:[UIColor whiteColor]];
//    [self.contentView insertSubview:self.commentBG atIndex:0];
//    [self.bottomBG setFrame:CGRectMake(0, 70+self.contentHeight, PARENT_WIDTH(self.bottomBG), PARENT_HEIGHT(self.bottomBG))];
//    
//    self.labelTime.text=[self.data objectForKey:@"comment_time"];
//    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"sheadImgurl"]]];
//    self.labelName.text=[self.data objectForKey:@"sname"];
//    
//    
//    if ([[self.data objectForKey:@"isgood"] integerValue]==1)
//    {
//        self.imgGood.hidden=NO;
//        self.labelGoodComment.hidden=NO;
//    }
//    else
//    {
//        self.imgGood.hidden=YES;
//        self.labelGoodComment.hidden=YES;
//    }
    
    
//}

-(IBAction)showUserPersonalVC:(id)sender
{
    if (self.delegate&&[self.data objectForKey:@"account"])
    {
        [self.delegate showOtherCenterVCTappedAvatar:[self.data objectForKey:@"account"]];
    }
    else if (self.delegate&&[[self.data objectForKey:@"student"] objectForKey:@"stu_account"])
    {
        [self.delegate showOtherCenterVCTappedAvatar:[[self.data objectForKey:@"student"] objectForKey:@"stu_account"]];
    }
}
@end
