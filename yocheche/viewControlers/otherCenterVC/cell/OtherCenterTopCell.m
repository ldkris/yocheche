//
//  OtherCenterTopCell.m
//  yocheche
//
//  Created by carcool on 8/17/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "OtherCenterTopCell.h"

@implementation OtherCenterTopCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=YCC_GrayBG;
    [self.topBG.layer setBorderWidth:1];
    [self.topBG.layer setBorderColor:[YCC_BorderColor CGColor]];
    [self.bottomBG.layer setBorderWidth:1];
    [self.bottomBG.layer setBorderColor:[YCC_BorderColor CGColor]];
    [self.labelArea setTextColor:YCC_TextColor];
    [self.labelSign setTextColor:YCC_TextColor];
    [self.labelInfo setTextColor:YCC_TextColor];
    [self.lineView0 setBackgroundColor:YCC_BorderColor];
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    NSString *ageStr=[self.data objectForKey:@"age"];
    NSString *sexStr=@"";
    if ([[self.data objectForKey:@"sex"] integerValue]==1)
    {
        sexStr=@"男";
    }
    else//2:girl
    {
        sexStr=@"女";
    }
    NSString *horoscopeStr=[self.data objectForKey:@"horoscope"];
    NSString *myLiked=[[self.data objectForKey:@"mylikecount"] stringValue];
    
    NSArray *aryMarry=[NSArray arrayWithObjects:@"保密",@"已婚",@"单身", nil];
    NSString *marry=[aryMarry objectAtIndex:[[self.data objectForKey:@"marital"] integerValue]];
    
    self.labelInfo.text=[NSString stringWithFormat:@"%@%@%@%@%@",[sexStr isEqualToString:@""]?@"":sexStr,[ageStr isEqualToString:@""]?@"":[NSString stringWithFormat:@"  %@",ageStr],[horoscopeStr isEqualToString:@""]?@"":[NSString stringWithFormat:@"  %@",horoscopeStr],[NSString stringWithFormat:@"  %@",marry],[NSString stringWithFormat:@"  被赞%@次",myLiked]];
    self.labelArea.text=[[self.data objectForKey:@"area"] isEqualToString:@""]?@"":[NSString stringWithFormat:@"常住地 %@",[self.data objectForKey:@"area"]];
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"userpic"]]];
    self.labelName.text=[self.data objectForKey:@"nickname"];
    self.labelSign.text=[self.data objectForKey:@"description"];
    self.labelPostNum.text=[NSString stringWithFormat:@"%d",[[self.data objectForKey:@"invitationcount"] integerValue]];
    self.labelFollowNum.text=[NSString stringWithFormat:@"%d",[[self.data objectForKey:@"followcount"] integerValue]];
    self.labelFansNum.text=[NSString stringWithFormat:@"%d",[[self.data objectForKey:@"fanscount"] integerValue]];
    self.labelLikeNum.text=[NSString stringWithFormat:@"%d",[[self.data objectForKey:@"likecount"] integerValue]];
    //buttons
    if ([[self.data objectForKey:@"follow"] integerValue]==1)
    {
        [self.btnFollow setTitle:@"已关注" forState:UIControlStateNormal];
    }
    else//2:not follow
    {
        [self.btnFollow setTitle:@"关注TA" forState:UIControlStateNormal];
    }
    //self or other
    if ([__BASE64([self.data objectForKey:@"account"]) isEqualToString:[[MyFounctions getUserInfo] objectForKey:@"account"]])
    {
        self.btnEdit.hidden=NO;
        self.btnFollow.hidden=YES;
    }
    else
    {
        self.btnEdit.hidden=YES;
        self.btnFollow.hidden=NO;
    }
}
-(IBAction)showBigAvatar:(id)sender
{
    [self.delegate createScreenView];
}
-(IBAction)followBtnPressed:(id)sender
{
    [self.delegate followTheUser];
}
-(IBAction)showEditInfoVC:(id)sender
{
    [self.delegate showEditInfoVC];
}
-(IBAction)showMyPostList:(id)sender
{
    self.delegate.pageIndex=1;
    self.delegate.postType=0;
    [self.delegate getPostList];
}
-(IBAction)showMyLikePostList:(id)sender
{
    self.delegate.pageIndex=1;
    self.delegate.postType=1;
    [self.delegate getMyLikePostList];
}
-(IBAction)showFollowListVC:(id)sender
{
    [self.delegate showFollowOtherList];
}
-(IBAction)showFansListVC:(id)sender
{
    [self.delegate showFansList];
}

@end
