//
//  FirstProgressCell.m
//  yocheche
//
//  Created by carcool on 7/24/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "FirstProgressCell.h"

@implementation FirstProgressCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=[UIColor clearColor];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.itemBG0 setClipsToBounds:YES];
    [self.itemBG0.layer setCornerRadius:3.0];
    [self.itemBG1 setClipsToBounds:YES];
    [self.itemBG1.layer setCornerRadius:3.0];
    [self.itemBG2 setClipsToBounds:YES];
    [self.itemBG2.layer setCornerRadius:3.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)btnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    [self.delegate testBtnPressed:btn.tag];
}
@end
