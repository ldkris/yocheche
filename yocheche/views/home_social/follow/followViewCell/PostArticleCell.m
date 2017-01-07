//
//  PostArticleCell.m
//  yocheche
//
//  Created by carcool on 3/7/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "PostArticleCell.h"

@implementation PostArticleCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:YCC_GrayBG];
    [self.articleBG setBackgroundColor:YCC_GrayBG];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.articlePic setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"imgurl"]]];
    self.labelTitle.text=[self.data objectForKey:@"title"];
}
-(IBAction)btnPressed:(id)sender
{
    [self.delegate showArticleVC:self.data];
}
@end
