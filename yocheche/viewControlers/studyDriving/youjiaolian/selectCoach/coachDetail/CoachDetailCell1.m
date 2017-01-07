//
//  CoachDetailCell1.m
//  yocheche
//
//  Created by carcool on 8/4/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "CoachDetailCell1.h"

@implementation CoachDetailCell1

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor whiteColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViews
{
    self.labelPrice.text=[NSString stringWithFormat:@"¥%d/%@",[[self.data objectForKey:@"fee"] integerValue],[[self.data objectForKey:@"type"] integerValue]==1?@"全款":@"学时"];
    self.labelName.text=[self.data objectForKey:@"name"];
}
#pragma mark -------- event response
//-(IBAction)selectSchemeBtnPressed:(id)sender
//{
//    self.delegate.selectedScheme=self.feeIndex;
//    [self.delegate.m_tableView reloadData];
//}
@end
