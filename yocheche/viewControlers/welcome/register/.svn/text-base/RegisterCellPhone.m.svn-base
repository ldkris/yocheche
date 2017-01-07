//
//  RegisterCellPhone.m
//  yocheche
//
//  Created by carcool on 7/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "RegisterCellPhone.h"

@implementation RegisterCellPhone

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor clearColor];
    [self.btn setColor:YCC_Green];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)btnPressed:(id)sender
{
    [self.delegate btnPressed:self.textFieldPhone.text];
}
@end
