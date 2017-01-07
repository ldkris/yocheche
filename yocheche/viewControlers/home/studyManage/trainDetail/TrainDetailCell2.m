//
//  TrainDetailCell2.m
//  yocheche
//
//  Created by carcool on 2/19/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "TrainDetailCell2.h"

@implementation TrainDetailCell2

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=YCC_GrayBG;
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.m_aryBtns=[NSMutableArray array];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    if (self.m_aryData.count>0)
    {
        self.contentBG=[[UIView alloc] initWithFrame:CGRectMake(10, 0, 300,20+(self.m_aryData.count/3+1)*(30+10))];
        [self.contentBG setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.contentBG];
        
        [self.m_aryBtns removeAllObjects];
        float btnWidth=(300-40)/3.0;
        NSInteger i=0;
        for (NSDictionary *dic in self.m_aryData)
        {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btn.layer setBorderWidth:1.0];
            [btn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
            [btn setFrame:CGRectMake(10+i%3*(btnWidth+10),10+(i/3)*(30+10), btnWidth, 30)];
            [btn setTitle:[dic objectForKey:@"tagname"] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
            btn.tag=i;
            [self.m_aryBtns addObject:btn];
            [self.contentBG addSubview:btn];
            i++;
        }
    }
}
@end
