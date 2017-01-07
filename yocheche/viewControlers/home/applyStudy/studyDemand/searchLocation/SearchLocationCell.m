//
//  SearchLocationCell.m
//  yocheche
//
//  Created by carcool on 3/17/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "SearchLocationCell.h"
#import "SearchLocationVC.h"
@implementation SearchLocationCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=YCC_GrayBG;
    [self.imgSelect setImage:[UIImage imageNamed:@"selectScheme_off"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    NSLog(@"self.index :%d",self.index);
    NSLog(@"self.delegate.index :%d",self.delegate.index);
    self.labelAddress.text=[self.data objectForKey:@"address"];
    self.labelArea.text=[NSString stringWithFormat:@"%@ %@",[self.data objectForKey:@"province"],[self.data objectForKey:@"district"]];
    if (self.index==self.delegate.index)
    {
        [self.imgSelect setImage:[UIImage imageNamed:@"selectScheme_on"]];
    }
    else
    {
        [self.imgSelect setImage:[UIImage imageNamed:@"selectScheme_off"]];
    }
}
-(IBAction)selectBtnPressed:(id)sender
{
    self.delegate.index=self.index;
    [self.delegate.m_tableView reloadData];
}
@end
