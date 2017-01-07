//
//  InputInviteCodeCell0.m
//  yocheche
//
//  Created by carcool on 8/6/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "InputInviteCodeCell0.h"

@implementation InputInviteCodeCell0

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor clearColor];
    self.textFieldCode.delegate=self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.delegate inputDone:textField.text];
    return YES;
}
@end
