//
//  RegisterCellPassword.m
//  yocheche
//
//  Created by carcool on 7/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "RegisterCellPassword.h"

@implementation RegisterCellPassword

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor clearColor];
    [self.btn setColor:YCC_Green];
    self.textFieldPassword1.secureTextEntry=YES;
    self.textFieldPassword2.secureTextEntry=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)btnPressed:(id)sender
{
    if (![self.textFieldPassword1.text isEqualToString:self.textFieldPassword2.text])
    {
        [self.delegate showMessage:@"两次密码输入不同"];
        return;
    }
    [self.delegate btnPressed:self.textFieldPassword1.text];
}
@end
