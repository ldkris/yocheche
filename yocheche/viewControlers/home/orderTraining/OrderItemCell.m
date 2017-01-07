//
//  OrderItemCell.m
//  yocheche
//
//  Created by carcool on 2/4/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "OrderItemCell.h"
#import "OrderTrainingVC.h"
@implementation OrderItemCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=YCC_GrayBG;
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    self.m_aryAvatars=[NSMutableArray array];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    for (WebImageViewNormal *img in self.m_aryAvatars)
    {
        [img removeFromSuperview];
    }
    [self.m_aryAvatars removeAllObjects];
    NSInteger i=0;
    for (NSDictionary *dic in [self.data objectForKey:@"students"])
    {
        WebImageViewNormal *avatar=[[WebImageViewNormal alloc] initWithFrame:CGRectMake(20+i*(30+3), 7.5, 30, 30)];
        [avatar setWebImageViewWithURL:[NSURL URLWithString:[dic objectForKey:@"headimgurl"]]];
        [avatar setClipsToBounds:YES];
        [avatar.layer setCornerRadius:PARENT_WIDTH(avatar)/2.0];
        [self insertSubview:avatar atIndex:2];
        [self.m_aryAvatars addObject:avatar];
        i++;
    }
    
    [self.labelCount removeFromSuperview];
    self.labelCount=nil;
    self.labelCount=[[UILabel alloc] initWithFrame:CGRectMake(20+i*(30+3),0 , 80, 45)];
    [self.labelCount setFont:[UIFont systemFontOfSize:13.0]];
    [self.labelCount setTextColor:[UIColor darkGrayColor]];
    self.labelCount.text=[NSString stringWithFormat:@"%@/%@",[self.data objectForKey:@"currNum"],[self.data objectForKey:@"maxNum"]];
    [self insertSubview:self.labelCount atIndex:2];
    
    self.labelTime.text=[self.data objectForKey:@"timeRange"];
    
    if ([[self.data objectForKey:@"flag"] integerValue]==0)
    {
        [self.imgSelect setImage:[UIImage imageNamed:@"selectScheme_off"]];
    }
    else
    {
        [self.imgSelect setImage:[UIImage imageNamed:@"selectScheme_on"]];
    }
}
-(IBAction)selectBtnPressed:(id)sender
{
    for (NSDictionary *dic in [self.data objectForKey:@"students"])
    {
        if ([__BASE64([dic objectForKey:@"account"]) isEqualToString:[[MyFounctions getUserInfo] objectForKey:@"account"]])
        {
            [self.delegate showMessage:@"你已预约该时段"];
            return;
        }
    }
    if ([[self.data objectForKey:@"currNum"] integerValue]>=[[self.data objectForKey:@"maxNum"] integerValue])
    {
        [self.delegate showMessage:@"当前时段已约满"];
        return;
    }
    
    if ([[self.data objectForKey:@"flag"] integerValue]==0)
    {
        [self.data setObject:@"1" forKey:@"flag"];
        [self.imgSelect setImage:[UIImage imageNamed:@"selectScheme_on"]];
    }
    else
    {
        [self.data setObject:@"0" forKey:@"flag"];
        [self.imgSelect setImage:[UIImage imageNamed:@"selectScheme_off"]];
    }
}
-(IBAction)showStudentView:(id)sender
{
    if ([(NSArray*)[self.data objectForKey:@"students"] count]>0)
    {
        [self.delegate showAllOrderedStudent:[self.data objectForKey:@"students"]];
    }
    
}
@end
