//
//  MyCenterTopCell.m
//  yocheche
//
//  Created by carcool on 6/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyCenterTopCell.h"
#import "MyCenterView.h"
#import "MySocialCenterVC.h"
@implementation MyCenterTopCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor clearColor];
    [self.btnEdit setColor:YCC_Green];
    [self.topBG.layer setBorderWidth:0.5];
    [self.topBG.layer setBorderColor:[YCC_BorderColor CGColor]];
    [self.bottomBG.layer setBorderWidth:0.5];
    [self.bottomBG.layer setBorderColor:[YCC_BorderColor CGColor]];
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
    self.labelInfo.text=[NSString stringWithFormat:@"%@%@%@%@",[sexStr isEqualToString:@""]?@"":sexStr,[ageStr isEqualToString:@""]?@"":[NSString stringWithFormat:@" %@",ageStr],[horoscopeStr isEqualToString:@""]?@"":[NSString stringWithFormat:@" %@",horoscopeStr],[NSString stringWithFormat:@" 被赞%@次",myLiked]];
    self.labelArea.text=[[self.data objectForKey:@"area"] isEqualToString:@""]?@"":[NSString stringWithFormat:@"常住地 %@",[self.data objectForKey:@"area"]];
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"userpic"]]];
    self.labelName.text=[self.data objectForKey:@"nickname"];
    self.labelSign.text=[self.data objectForKey:@"description"];
    self.labelPostNum.text=[NSString stringWithFormat:@"%d",[[self.data objectForKey:@"invitationcount"] integerValue]];
    self.labelFollowNum.text=[NSString stringWithFormat:@"%d",[[self.data objectForKey:@"followcount"] integerValue]];
    self.labelFansNum.text=[NSString stringWithFormat:@"%d",[[self.data objectForKey:@"fanscount"] integerValue]];
    self.labelLikeNum.text=[NSString stringWithFormat:@"%d",[[self.data objectForKey:@"likecount"] integerValue]];
    //button
}
-(IBAction)showMyPostList:(id)sender
{
    self.delegate.pageIndex=1;
    self.delegate.postType=0;
    [self.delegate.delegate getMyPostListPageIndex:[NSString stringWithFormat:@"%d",self.delegate.pageIndex] PageCount:[NSString stringWithFormat:@"%d",self.delegate.pageCount]];
}
-(IBAction)showMyLikePostList:(id)sender
{
    self.delegate.pageIndex=1;
    self.delegate.postType=1;
    [self.delegate.delegate getMyLikePostListPageIndex:[NSString stringWithFormat:@"%d",self.delegate.pageIndex] PageCount:[NSString stringWithFormat:@"%d",self.delegate.pageCount]];
}
-(IBAction)showEditInfoVC:(id)sender
{
    [self.delegate showEditInfoVC];
}
-(IBAction)showFollowList:(id)sender
{
    [self.delegate.delegate showFollowOtherList];
}
-(IBAction)showFansListVC:(id)sender
{
    [self.delegate.delegate showFansList];
}
@end
