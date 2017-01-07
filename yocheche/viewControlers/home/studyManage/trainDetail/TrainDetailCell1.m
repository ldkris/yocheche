//
//  TrainDetailCell1.m
//  yocheche
//
//  Created by carcool on 2/19/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "TrainDetailCell1.h"

@implementation TrainDetailCell1

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=YCC_GrayBG;
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [self.lineView1 setBackgroundColor:YCC_GrayBG];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    NSInteger grade=[[self.data objectForKey:@"star"] integerValue];
    switch (grade)
    {
        case 1:
            [self.imgStar1 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar2 setImage:[UIImage imageNamed:@"star_off"]];
            [self.imgStar3 setImage:[UIImage imageNamed:@"star_off"]];
            [self.imgStar4 setImage:[UIImage imageNamed:@"star_off"]];
            [self.imgStar5 setImage:[UIImage imageNamed:@"star_off"]];
            break;
        case 2:
            [self.imgStar1 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar2 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar3 setImage:[UIImage imageNamed:@"star_off"]];
            [self.imgStar4 setImage:[UIImage imageNamed:@"star_off"]];
            [self.imgStar5 setImage:[UIImage imageNamed:@"star_off"]];
            break;
        case 3:
            [self.imgStar1 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar2 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar3 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar4 setImage:[UIImage imageNamed:@"star_off"]];
            [self.imgStar5 setImage:[UIImage imageNamed:@"star_off"]];
            break;
        case 4:
            [self.imgStar1 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar2 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar3 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar4 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar5 setImage:[UIImage imageNamed:@"star_off"]];
            break;
        case 5:
            [self.imgStar1 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar2 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar3 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar4 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar5 setImage:[UIImage imageNamed:@"star_on"]];
            break;
            
        default:
            break;
    }
    if (grade<=2)
    {
        self.labelGrade.text=@"差评";
    }
    else if (grade>=4)
    {
        self.labelGrade.text=@"好评";
    }
    else
    {
        self.labelGrade.text=@"中评";
    }
}
@end
