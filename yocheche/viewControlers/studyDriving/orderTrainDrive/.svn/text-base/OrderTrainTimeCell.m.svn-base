//
//  OrderTrainTimeCell.m
//  yocheche
//
//  Created by carcool on 9/4/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "OrderTrainTimeCell.h"

@implementation OrderTrainTimeCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [MyFounctions setLineViewMoreThin:self.lineView0];
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    self.m_aryAvatar=[NSMutableArray array];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    for (WebImageViewNormal *avatar in self.m_aryAvatar)
    {
        [avatar removeFromSuperview];
    }
    [self.m_aryAvatar removeAllObjects];
    
    NSArray *arrayTimesInDay=[self.delegate.m_arySelectedTime objectAtIndex:self.dayIndex];
    [self.gou setImage:[UIImage imageNamed:@"selectScheme_off"]];
    for (NSString *str in arrayTimesInDay)
    {
        if ([str isEqualToString:[[self.data objectForKey:@"time_id"] stringValue]])
        {
            [self.gou setImage:[UIImage imageNamed:@"selectScheme_on"]];
            break;
        }
    }
    self.labelTime.text=[NSString stringWithFormat:@"%@-%@",[self.data objectForKey:@"begin_time"],[self.data objectForKey:@"end_time"]];
    
    //show students
    NSInteger i=0;
    for (NSDictionary *dic in [self.data objectForKey:@"students"])
    {
        if (i<3)
        {
            WebImageViewNormal *avatar=[[WebImageViewNormal alloc] initWithFrame:CGRectMake(10+i*40, 15, 30, 30)];
            [avatar setClipsToBounds:YES];
            [avatar.layer setCornerRadius:PARENT_WIDTH(avatar)/2.0];
            [avatar setWebImageViewWithURL:[NSURL URLWithString:[dic objectForKey:@"userpic"]]];
            [self addSubview:avatar];
            [self.m_aryAvatar addObject:avatar];
            i++;
        }
    }
    
    if (self.labelNum)
    {
        [self.labelNum removeFromSuperview];
        self.labelNum=nil;
    }
    self.labelNum=[[UILabel alloc] initWithFrame:CGRectMake(10+i*40,19 , 60, 21)];
    [self.labelNum setTextColor:[UIColor darkGrayColor]];
    [self.labelNum setFont:[UIFont systemFontOfSize:15.0]];
    self.labelNum.text=[NSString stringWithFormat:@"%@/%@",[self.data objectForKey:@"cur_num"],[self.data objectForKey:@"max_num"]];
    [self addSubview:self.labelNum];
    
    if (self.btnShowStudent)
    {
        [self.btnShowStudent removeFromSuperview];
        self.btnShowStudent=nil;
    }
    if (i>0)
    {
        self.btnShowStudent=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.btnShowStudent setFrame:CGRectMake(0, 0, 10+i*40, PARENT_HEIGHT(self))];
        [self.btnShowStudent addTarget:self action:@selector(showAllStudent) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnShowStudent];
    }
    
}
-(void)showAllStudent
{
    [self.delegate showAllOrderedStudent:[self.data objectForKey:@"students"]];
}
@end
