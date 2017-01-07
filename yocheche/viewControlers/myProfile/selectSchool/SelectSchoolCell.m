//
//  SelectSchoolCell.m
//  yocheche
//
//  Created by carcool on 8/14/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "SelectSchoolCell.h"

@implementation SelectSchoolCell

- (void)awakeFromNib {
    // Initialization code
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [MyFounctions setLineViewMoreThin:self.lineView0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
