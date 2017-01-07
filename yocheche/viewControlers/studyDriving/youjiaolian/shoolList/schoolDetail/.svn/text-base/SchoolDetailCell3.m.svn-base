//
//  SchoolDetailCell3.m
//  yocheche
//
//  Created by carcool on 12/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "SchoolDetailCell3.h"

@implementation SchoolDetailCell3

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=YCC_GrayBG;
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [self.lineView2 setBackgroundColor:YCC_GrayBG];
    self.m_aryAvatar=[NSMutableArray arrayWithObjects:self.avatar1,self.avatar2,self.avatar3, nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    self.labelTotal.text=[NSString stringWithFormat:@"本校教练（共%d位）",[[self.data objectForKey:@"coachNum"] integerValue]];
    self.labelLook.text=[NSString stringWithFormat:@"查看全部%d位教练",[[self.data objectForKey:@"coachNum"] integerValue]];
    
    NSInteger i=0;
    while (i<[(NSArray*)[self.data objectForKey:@"coachList"] count]&&i<3)
    {
        WebImageViewNormal *avatar=[self.m_aryAvatar objectAtIndex:i];
        [avatar setWebImageViewWithURL:[NSURL URLWithString:[[[self.data objectForKey:@"coachList"] objectAtIndex:i] objectForKey:@"headUrl"]]];
        i++;
    }
}
@end
