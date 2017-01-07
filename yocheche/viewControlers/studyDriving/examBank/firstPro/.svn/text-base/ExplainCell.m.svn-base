//
//  ExplainCell.m
//  weixueche
//
//  Created by carcool on 12/30/14.
//  Copyright (c) 2014 carcool. All rights reserved.
//

#import "ExplainCell.h"

@implementation ExplainCell
@synthesize textBG,labelText;
- (void)awakeFromNib {
    // Initialization code
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.labelText setNumberOfLines:0];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViewsWithHeight:(float)height
{
    //reset explain cell
    [self.textBG setFrame:CGRectMake(PARENT_X(self.textBG), PARENT_Y(self.textBG), PARENT_WIDTH(self.textBG), 68-26+height)];
    [self.labelText setFrame:CGRectMake(PARENT_X(self.labelText), PARENT_Y(self.labelText), PARENT_WIDTH(self.labelText), height)];
}
@end
