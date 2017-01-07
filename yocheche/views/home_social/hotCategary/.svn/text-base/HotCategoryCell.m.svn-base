//
//  HotCategoryCell.m
//  yocheche
//
//  Created by carcool on 6/26/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "HotCategoryCell.h"

@implementation HotCategoryCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor clearColor];
    self.m_aryImgs=[NSMutableArray arrayWithObjects:self.img1,self.img2,self.img3,self.img4, nil];
    [self.bgView.layer setBorderWidth:0.5];
    [self.bgView.layer setBorderColor:[YCC_BorderColor CGColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    self.labelDescription.text=[self.data objectForKey:@"desc"];
    self.labelThemeName.text=[self.data objectForKey:@"themeName"];
    [self.themeBG setBackgroundColor:[MyFounctions getColor:[self.data objectForKey:@"color"]]];
    NSInteger i=0;
    for (NSDictionary *dic in [self.data objectForKey:@"photos"])
    {
        if (i<=2)
        {
            WebImageViewNormal *img=[self.m_aryImgs objectAtIndex:i];
            [img setContentMode:UIViewContentModeScaleAspectFill];
            [img setClipsToBounds:YES];
            [img setWebImageViewWithURL:[NSURL URLWithString:[dic objectForKey:@"imgurl"]]];
        }
        else
        {
            break;
        }
        i++;
    }
    [self.img4 setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"iconurl"]]];
}

@end
