//
//  SchoolCell.m
//  yocheche
//
//  Created by carcool on 11/30/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "SchoolCell.h"

@implementation SchoolCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=YCC_GrayBG;
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.imgZhiying removeFromSuperview];
    self.imgZhiying=nil;
    [self.imgFens removeFromSuperview];
    self.imgFens=nil;
    
    NSInteger imgNum=0;
    if([[self.data objectForKey:@"self_run"] integerValue]==2)
    {
        self.imgZhiying=[[UIImageView alloc] initWithFrame:CGRectMake(78+imgNum*(31+15), 32, 31, 16)];
        [self.imgZhiying setImage:[UIImage imageNamed:@"zhiying"]];
        [self.contentBG addSubview:self.imgZhiying];
        imgNum++;
    }
    if ([[self.data objectForKey:@"timing"] integerValue]==2)
    {
        self.imgFens=[[UIImageView alloc] initWithFrame:CGRectMake(78+imgNum*(31+15), 32, 31, 16)];
        [self.imgFens setImage:[UIImage imageNamed:@"fens"]];
        [self.contentBG addSubview:self.imgFens];
        imgNum++;
    }
    
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"dspic"]]];
    self.labelName.text=[self.data objectForKey:@"dsname"];
    self.labelDistance.text=[self.data objectForKey:@"distance"];
    self.labelGood.text=[self.data objectForKey:@"goodNum"];
    self.labelPeople.text=[self.data objectForKey:@"stuNum"];
    self.labelPrice.text=[NSString stringWithFormat:@"¥%d",[[self.data objectForKey:@"fee"] integerValue]];
    
}
@end
