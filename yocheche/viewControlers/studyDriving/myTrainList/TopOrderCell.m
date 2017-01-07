//
//  TopOrderCell.m
//  yocheche
//
//  Created by carcool on 11/5/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "TopOrderCell.h"

@implementation TopOrderCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
