//
//  SchoolDetailCell2.m
//  yocheche
//
//  Created by carcool on 12/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "SchoolDetailCell2.h"

@implementation SchoolDetailCell2

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=YCC_GrayBG;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    if (self.descriptionExpand==0)
    {
        [self.imgJt setImage:[UIImage imageNamed:@"jt_down"]];
        self.labelExpand.text=@"查看详细介绍";
    }
    else
    {
        [self.imgJt setImage:[UIImage imageNamed:@"jt_up"]];
        self.labelExpand.text=@"收起";
    }
}
@end
