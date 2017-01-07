//
//  ManageOrderCell.m
//  yocheche
//
//  Created by carcool on 2/1/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "ManageOrderCell.h"
#import "OrderCardView.h"
#import "StudyManageVC.h"
@implementation ManageOrderCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=YCC_GrayBG;
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.m_aryOrderViews=[NSMutableArray array];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    for (OrderCardView *orderView in self.m_aryOrderViews)
    {
        [orderView removeFromSuperview];
    }
    [self.m_aryOrderViews removeAllObjects];
    
    [self.m_scrollView removeFromSuperview];
    self.m_scrollView=nil;
    self.m_scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(30, 35, 260, 210)];
    [self.m_scrollView setBackgroundColor:YCC_GrayBG];
    [self.m_scrollView setContentSize:CGSizeMake(self.m_aryData.count*260, 210)];
    self.m_scrollView.clipsToBounds=NO;
    self.m_scrollView.pagingEnabled=YES;
    self.m_scrollView.showsHorizontalScrollIndicator=NO;
    [self addSubview:self.m_scrollView];
    
    NSInteger i=0;
    for (NSDictionary *dic in self.m_aryData)
    {
        OrderCardView *order=[[[NSBundle mainBundle] loadNibNamed:@"OrderCardView" owner:nil options:nil] objectAtIndex:0];
        [order setFrame:CGRectMake(10+i*260, 0, 240, 210)];
        order.manageVCDelegate=self.delegate;
        order.orderCellDelegate=self;
        order.data=dic;
        [order updateView];
        [self.m_scrollView addSubview:order];
        [self.m_aryOrderViews addObject:order];
        i++;
    }
    
}
@end
