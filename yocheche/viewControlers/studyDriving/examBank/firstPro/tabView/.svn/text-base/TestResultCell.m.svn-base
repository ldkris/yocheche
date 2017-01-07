//
//  TestResultCell.m
//  weixueche
//
//  Created by carcool on 12/27/14.
//  Copyright (c) 2014 carcool. All rights reserved.
//

#import "TestResultCell.h"

@implementation TestResultCell
@synthesize textBG,label;
- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setErrorView:(NSString*)answer
{
    [self.textBG setBackgroundColor:[UIColor colorWithRed:236/255.0 green:150/255.0 blue:56/255.0 alpha:1]];
    self.label.text=[NSString stringWithFormat:@"回答错误！标准答案是：%@",answer];
}
-(void)setRightView
{
    [self.textBG setBackgroundColor:[UIColor colorWithRed:140/255.0 green:208/255.0 blue:155/255.0 alpha:1]];
    self.label.text=@"恭喜你，答对了！";
}

@end
