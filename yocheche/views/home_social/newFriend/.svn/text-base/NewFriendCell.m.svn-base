//
//  NewFriendCell.m
//  yocheche
//
//  Created by carcool on 1/7/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "NewFriendCell.h"

@implementation NewFriendCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:YCC_GrayBG];
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
    [self.contentBG setClipsToBounds:YES];
    [self.contentBG.layer setCornerRadius:3.0];
    [self.contentBG.layer setShadowColor:[[UIColor lightGrayColor] CGColor]];
    [self.contentBG.layer setShadowOffset:CGSizeMake(0, 0)];
    [self.contentBG.layer setShadowOpacity:0.5];
    [self.contentBG.layer setShadowRadius:1.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.imgSex removeFromSuperview];
    self.imgSex=nil;
    [self.labelTag removeFromSuperview];
    self.labelTag=nil;
    
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"headImgUrl"]]];
    self.labelDistance.text=[NSString stringWithFormat:@"距离：%@",[self.data objectForKey:@"distance"]];
    self.labelName.text=[self.data objectForKey:@"nickname"];
    self.labelSign.text=[self.data objectForKey:@"resume"];
    if ([self.labelSign.text isEqualToString:@""])
    {
        self.labelSign.text=@"这家伙很懒，啥都没有说";
    }
    
    float nameWidth=[MyFounctions calculateTextWidth:[self.data objectForKey:@"nickname"] font:[UIFont systemFontOfSize:14.0]];
    self.imgSex=[[UIImageView alloc] initWithFrame:CGRectMake(PARENT_X(self.labelName)+nameWidth+10, 12, 11, 11)];
    self.imgSex.contentMode = UIViewContentModeScaleAspectFit;
    if ([[self.data objectForKey:@"sex"] integerValue]==1)
    {
        [self.imgSex setImage:[UIImage imageNamed:@"boy"]];
    }
    else
    {
        [self.imgSex setImage:[UIImage imageNamed:@"girl"]];
    }
    [self.contentBG addSubview:self.imgSex];
    
    self.labelTag=[[UILabel alloc] initWithFrame:CGRectMake(PARENT_X(self.labelName)+nameWidth+31, PARENT_Y(self.labelName), 80, PARENT_HEIGHT(self.labelName))];
    [self.labelTag setTextColor:YCC_Green];
    [self.labelTag setFont:[UIFont systemFontOfSize:14.0]];
    self.labelTag.text=@"同校师兄妹";
    [self.contentBG addSubview:self.labelTag];
    if ([[self.data objectForKey:@"same_school"] integerValue]==1)
    {
        self.labelTag.hidden=NO;
    }
    else
    {
        self.labelTag.hidden=YES;
    }
}
-(IBAction)chatBtnPressed:(id)sender
{
    [self.delegate chatWithUserChatID:[self.data objectForKey:@"chatAccount"] username:[self.data objectForKey:@"nickname"] userAvatar:[self.data objectForKey:@"headImgUrl"] account:[self.data objectForKey:@"account"]];
}
@end
