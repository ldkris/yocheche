//
//  TestCell.m
//  weixueche
//
//  Created by carcool on 12/6/14.
//  Copyright (c) 2014 carcool. All rights reserved.
//

#import "TestCell.h"
#import "TestPageView.h"
@implementation TestCell
@synthesize selectImage,selectRight,labelSelect,labelRightAnswer,indexCell,delegate,cellBG,selectGou;
- (void)awakeFromNib {
    // Initialization code
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIColor clearColor]];

//    self.cellBG.roundedCorners=TKRoundedCornerTopLeft| TKRoundedCornerTopRight;
//    self.cellBG.drawnBordersSides = TKDrawnBorderSidesLeft | TKDrawnBorderSidesBottom | TKDrawnBorderSidesRight|TKDrawnBorderSidesTop;
//    self.cellBG.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
//    self.cellBG.borderWidth = 1.0f;
//    self.cellBG.cornerRadius = 4.0f;
    
    self.indexCell=0;
    self.labelRightAnswer.hidden=YES;
    [self.labelSelect setFont:[UIFont boldSystemFontOfSize:14.0]];
    [self.labelSelect setTextColor:Gray_Text];
    [self.labelSelect setNumberOfLines:0];
    
    self.selectImage.hidden=NO;
    self.selectRight.hidden=YES;
    self.selectGou.hidden=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)cellPressedForMutableSelect
{
    if (self.selectRight.hidden==NO)
    {
        self.selectImage.hidden=NO;
        self.selectRight.hidden=YES;
    }
    else
    {
        self.selectImage.hidden=YES;
        self.selectRight.hidden=NO;
    }
}

@end
