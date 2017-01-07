//
//  PostNameCell.m
//  yocheche
//
//  Created by carcool on 8/21/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "PostNameCell.h"
#import "OtherCenterVC.h"
@implementation PostNameCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:YCC_GrayBG];
    [self.contentBG setRoundedCorners:TKRoundedCornerTopRight|TKRoundedCornerTopLeft];
    [self.contentBG setCornerRadius:3.0];
    [self.contentBG setBorderWidth:0];
    self.btnMore.hidden=YES;
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"userpic"]]];
    self.laeblName.text=[self.data objectForKey:@"nikename"];
}
-(IBAction)showOtherCenterVCTappedNameCell
{
    [self.vcDelegate showOtherCenterVCTappedNameCell:[self.data objectForKey:@"account"]];
}
-(IBAction)moreBtnPressed:(id)sender
{
    [self.vcDelegate showMoreOperationMenuSheet];
}
@end
