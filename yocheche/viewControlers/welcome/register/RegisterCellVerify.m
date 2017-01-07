//
//  RegisterCellVerify.m
//  yocheche
//
//  Created by carcool on 7/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "RegisterCellVerify.h"

@implementation RegisterCellVerify
@synthesize time;
- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor clearColor];
    [self.btn setColor:YCC_Green];
    self.time=60;
    [self updateTime];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateTime
{
    if (time>0)
    {
        [self.labelSendVerify setText:[NSString stringWithFormat:@"重发验证码(%d)",time]];
        [self.labelSendVerify setTextColor:[UIColor lightGrayColor]];
        time--;
        [self performSelector:@selector(updateTime) withObject:nil afterDelay:1.0];
    }
    else
    {
        [self.labelSendVerify setTextColor:YCC_Green];
        [self.labelSendVerify setText:[NSString stringWithFormat:@"重发"]];
        self.time=60;
    }
}
-(IBAction)resendVerifyCode:(id)sender
{
    if (self.time>=60)
    {
        [self.delegate sendVerifyCode];
    }
}
-(IBAction)btnPressed:(id)sender
{
    if([self.textFieldVerify.text isEqualToString:@""])
    {
        [self.delegate showMessage:@"请输入验证码"];
        return;
    }
    [self.delegate btnPressed:self.textFieldVerify.text];
}
@end
