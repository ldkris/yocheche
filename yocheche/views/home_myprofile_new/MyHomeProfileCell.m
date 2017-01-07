//
//  MyHomeProfileCell.m
//  yocheche
//
//  Created by carcool on 9/4/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyHomeProfileCell.h"
#import "MyCenterVC.h"
@implementation MyHomeProfileCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=YCC_GrayBG;
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.infoBg.layer setBorderWidth:0.5];
    [self.infoBg.layer setBorderColor:[[UIColor lightTextColor] CGColor]];
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [self.lineView1 setBackgroundColor:YCC_GrayBG];
    [self.lineView2 setBackgroundColor:YCC_GrayBG];
    
    [self.topView.layer setBorderColor:[YCC_BorderColor CGColor]];
    [self.topView.layer setBorderWidth:0.5];
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
    
    [self.notifyMessage.layer setCornerRadius:3.0];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"userpic"]]];
    self.labelName.text=[self.data objectForKey:@"nickname"];
    self.labelMobile.text=[[self.data objectForKey:@"phone"] isEqualToString:@""]?@"未绑定手机":[self.data objectForKey:@"phone"];
    self.labelMoney.text=[[self.data objectForKey:@"balance"] stringValue];
    
    //new message
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    if ([[userDefaults objectForKey:@"orderMessage"] integerValue]==1||[[userDefaults objectForKey:@"signInNum"] integerValue]>0)//have new
    {
        self.notifyMessage.hidden=NO;
    }
    else
    {
        self.notifyMessage.hidden=YES;
    }
}
-(IBAction)showMyInfoVC:(id)sender
{
    [self.delegate.delegate showMySocialCenterVC];
}
-(IBAction)showMyMessageVC:(id)sender
{
    [self.delegate.delegate showMyMessagesVC];
}
-(IBAction)showMyFollowVC:(id)sender
{
    [self.delegate.delegate showMyFollowVC];
}
-(IBAction)showMyFansListVC:(id)sender
{
    [self.delegate.delegate showMyFansListVC];
}

-(IBAction)showMyStudyDriveVC:(id)sender
{
    [self.delegate.delegate showMyStudyDriveVC];
}
-(IBAction)showMyIntegral:(id)sender
{
    [self.delegate.delegate showMyIntegralVC];
}
-(IBAction)showAboutYocheche:(id)sender
{
    [self.delegate.delegate showAboutYocheche];
}
-(IBAction)showMySettingVC:(id)sender
{
    [self.delegate.delegate showMyinfoVC:self.data];
}
@end
