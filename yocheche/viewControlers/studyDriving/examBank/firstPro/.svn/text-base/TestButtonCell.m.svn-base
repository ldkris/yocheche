//
//  TestButtonCell.m
//  weixueche
//
//  Created by carcool on 12/14/14.
//  Copyright (c) 2014 carcool. All rights reserved.
//

#import "TestButtonCell.h"

@implementation TestButtonCell
@synthesize button,delegate;
- (void)awakeFromNib {
    // Initialization code
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    [self setBackgroundColor:[UIColor clearColor]];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [button setColor:[UIColor whiteColor]];
    [button.layer setCornerRadius:4.0];
    [button.layer setBorderWidth:1.0];
    [button.layer setBorderColor:[[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1] CGColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)buttonPressed:(id)sender
{
    [self.delegate selectDoneForMutableSelect];
}
@end
