//
//  MyMessageCell.m
//  yocheche
//
//  Created by carcool on 9/5/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyMessageCell.h"

@implementation MyMessageCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
//    if ([[self.data objectForKey:@"from"] integerValue]==0)
//    {
//        [self.imgNotify setImage:[UIImage imageNamed:@"system_message"]];
//    }
//    else
//    {
        [self.imgNotify setImage:[UIImage imageNamed:@"car_message"]];
//    }
    self.labelTitle.text=[self.data objectForKey:@"title"];
    self.labelContent.text=[self.data objectForKey:@"content"];
    self.labelTime.text=[self.data objectForKey:@"datetime"];
}

@end
