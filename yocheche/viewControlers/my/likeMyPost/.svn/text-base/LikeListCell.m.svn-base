//
//  LikeListCell.m
//  yocheche
//
//  Created by carcool on 8/24/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "LikeListCell.h"

@implementation LikeListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.avatat setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"userpic"]]];
    [self.postImg setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"imgurl"]]];
    self.labelName.text=[self.data objectForKey:@"nikename"];
    self.labelTime.text=[self.data objectForKey:@"liketime"];
}
@end
