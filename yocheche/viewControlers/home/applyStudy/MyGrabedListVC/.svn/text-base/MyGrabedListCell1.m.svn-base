//
//  MyGrabedListCell1.m
//  yocheche
//
//  Created by carcool on 3/18/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "MyGrabedListCell1.h"
#import "MyGrabedListVC.h"
#import "CoachDetailVC.h"
@implementation MyGrabedListCell1

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=YCC_GrayBG;
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
    [self.btnSign setColor:YCC_Green];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"headimgurl"]]];
    self.labelName.text=[self.data objectForKey:@"coachname"];
    self.labelDescrip.text=[NSString stringWithFormat:@"%d年教龄 %d人正在学习",[[self.data objectForKey:@"jl"] integerValue],[[self.data objectForKey:@"stuNum"] integerValue]];
    self.labelAddress.text=[self.data objectForKey:@"space"];
    self.labelDistance.text=[self.data objectForKey:@"distance"];
    self.labelPrice.text=[NSString stringWithFormat:@"%d",[[self.data objectForKey:@"minFee"] integerValue]];
}
-(IBAction)callBtnPressed:(id)sender
{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[self.data objectForKey:@"mobile"]]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self addSubview:callWebview];
    
    [self.delegate submitCallEvent:[[self.delegate.data objectForKey:@"did"] stringValue] coachId:[[self.data objectForKey:@"coachid"] stringValue]];
}
-(IBAction)showCoachDetailVC:(id)sender
{
    self.delegate.navigationController.navigationBar.hidden=NO;
    CoachDetailVC *vc=[[CoachDetailVC alloc] init];
    vc.preData=[NSDictionary dictionaryWithObjects:@[[[self.data objectForKey:@"coachid"] stringValue]] forKeys:@[@"coachId"]];
    [self.delegate.navigationController pushViewController:vc animated:YES];
}
-(IBAction)signInBtnPressed:(id)sender
{
    [self.delegate showSignInNoteAlert:[[self.delegate.data objectForKey:@"did"] stringValue] coachId:[[self.data objectForKey:@"coachid"] stringValue]];
}
@end
