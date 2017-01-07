//
//  PayGuaranteeSuccessCell.m
//  yocheche
//
//  Created by carcool on 5/9/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "PayGuaranteeSuccessCell.h"
#import "PayGuaranteeSuccessVC.h"
@implementation PayGuaranteeSuccessCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=YCC_GrayBG;
    [self.contentBG setClipsToBounds:YES];
    [self.contentBG.layer setCornerRadius:4.0];
    [self.btnShare setColor:YCC_Green];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    self.labelCoach.text=[self.data objectForKey:@"coachname"];
    self.labelLicenseType.text=[self.data objectForKey:@"drivetype"];
    self.labelOrderID.text=[self.data objectForKey:@"orderNo"];
    self.labelTime.text=[self.data objectForKey:@"paytime"];
    
    [self.webView removeFromSuperview];
    self.webView=nil;
    self.webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, PARENT_WIDTH(self.webViewBG), PARENT_HEIGHT(self.webViewBG))];
    self.webView.userInteractionEnabled=NO;
    NSURL* url = [NSURL URLWithString:[self.delegate.data objectForKey:@"embedHtmlUrl"]];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self.webViewBG addSubview:self.webView];
}
-(IBAction)shareBtnPressed:(id)sender
{
    [self.delegate sharePaySuccess];
}
@end
