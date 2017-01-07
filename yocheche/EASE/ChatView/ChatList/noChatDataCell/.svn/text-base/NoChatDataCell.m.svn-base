//
//  NoChatDataCell.m
//  yocheche
//
//  Created by carcool on 1/8/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "NoChatDataCell.h"
#import "SocialHomeVC.h"
@implementation NoChatDataCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.btn setColor:YCC_Green];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)btnPressed:(id)sender
{
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [delegate.tabBarController btn2Pressed];
    UIButton *btnSender=[UIButton buttonWithType:UIButtonTypeCustom];
    btnSender.tag=1;
    [delegate.m_socialHomeVC topMenuBtnPressed:btnSender];
}
@end
