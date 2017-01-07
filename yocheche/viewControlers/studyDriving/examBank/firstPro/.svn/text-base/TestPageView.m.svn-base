//
//  TestPageView.m
//  weixueche
//
//  Created by carcool on 12/10/14.
//  Copyright (c) 2014 carcool. All rights reserved.
//

#import "TestPageView.h"
#import "TestCell.h"
#import "TestImageCell.h"
#import "TestButtonCell.h"
#import "WebImageView.h"
#import "TestMovieCell.h"
#import "TestResultCell.h"
#import "ExplainCell.h"
@implementation TestPageView
@synthesize m_tableView,delegate,testDictionary,haveMediaFlag,mutableSelectFlag,answerIndex,m_arySelectCells,haveShowAnswer,shouldShowAnswer,player,pageIndex,imagecell,answerIndexArray,moviePlayerView,MediaType,moviecell,questionHeight,questionCellView,resultcell,explainHeight,explainCell,m_imageView,blackBG,largeImageView,btnDissmissLargeImage;
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.shouldShowAnswer=0;
        self.haveShowAnswer=0;
        self.answerIndex=0;
        self.haveMediaFlag=0;
        self.mutableSelectFlag=0;
        self.pageIndex=0;
        self.testDictionary=[NSDictionary dictionary];
        self.m_arySelectCells=[NSMutableArray array];
        self.answerIndexArray=[NSMutableArray array];
        
        [self setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64-49)];
    }
    return self;
}
-(void)updateViews
{
    //explan height
    self.explainHeight=[MyFounctions calculateLabelHeightWithString:[self.testDictionary objectForKey:@"explain"] Width:Screen_Width-20 font:[UIFont boldSystemFontOfSize:14.0]];
    //judge have media
    if ([[self.testDictionary objectForKey:@"img"] isEqualToString:@""])
    {
        self.haveMediaFlag=0;
    }
    else
    {
        self.haveMediaFlag=1;
    }
    //caculate question height
    self.questionHeight=[MyFounctions calculateLabelHeightWithString:[self.testDictionary objectForKey:@"question"] Width:Screen_Width-20 font:test_text_font];
    //judge media type 0:img 1:movie
    if (![[self.testDictionary objectForKey:@"img"] isEqualToString:@""]&&[[[self.testDictionary objectForKey:@"img"] substringFromIndex:[[self.testDictionary objectForKey:@"img"] length]-3] isEqualToString:@"mp4"])
    {
        self.MediaType=1;
    }
    else
    {
        self.MediaType=0;
    }
    //judge weather mutable select test
    if ([[self.testDictionary objectForKey:@"type"] isEqualToString:@"多选题"])
    {
        self.mutableSelectFlag=1;
    }
    else
    {
        self.mutableSelectFlag=0;
    }
    //answer
    if (self.mutableSelectFlag==0)
    {
        if ([[self.testDictionary objectForKey:@"answer"] isEqualToString:@"A"])
        {
            self.answerIndex=0;
        }
        else if ([[self.testDictionary objectForKey:@"answer"] isEqualToString:@"B"])
        {
            self.answerIndex=1;
        }
        else if ([[self.testDictionary objectForKey:@"answer"] isEqualToString:@"C"])
        {
            self.answerIndex=2;
        }
        else if ([[self.testDictionary objectForKey:@"answer"] isEqualToString:@"D"])
        {
            self.answerIndex=3;
        }
    }
    else
    {
        for(int i =0; i < [[self.testDictionary objectForKey:@"answer"] length]; i++)
        {
            NSString *answerStr = [[self.testDictionary objectForKey:@"answer"] substringWithRange:NSMakeRange(i, 1)];
            NSString *an=@"0";
            if ([answerStr isEqualToString:@"A"])
            {
                an=@"0";
            }
            else if ([answerStr isEqualToString:@"B"])
            {
                an=@"1";
            }
            else if ([answerStr isEqualToString:@"C"])
            {
                an=@"2";
            }
            else if ([answerStr isEqualToString:@"D"])
            {
                an=@"3";
            }
            [self.answerIndexArray addObject:an];
        }
    }

    self.m_tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, PARENT_WIDTH(self), PARENT_HEIGHT(self))];
    [self.m_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    self.m_tableView.scrollEnabled=NO;
    if ([self.delegate.mytestmodel.type integerValue]==5)
    {
        self.m_tableView.scrollEnabled=YES;
    }
    [self addSubview:m_tableView];
    
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return 9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==8)
    {
        [self reSetCellsAfterAllDisplay];
        UITableViewCell *cell=[[UITableViewCell alloc] init];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        return cell;
    }
    else if (indexPath.row==0)
    {
        UITableViewCell *cell=[[UITableViewCell alloc] init];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        self.questionCellView=[[TKRoundedView alloc] initWithFrame:CGRectMake(5, 5, Screen_Width-10, questionHeight+10)];
        if (PARENT_HEIGHT(self.questionCellView)<50&&self.haveMediaFlag==0)
        {
            [self.questionCellView setFrame:CGRectMake(5, 5, Screen_Width-10, 50)];
        }
        if (haveMediaFlag==1) //have media
        {
            [questionCellView setFrame:CGRectMake(PARENT_X(questionCellView), PARENT_Y(questionCellView), PARENT_WIDTH(questionCellView), PARENT_HEIGHT(questionCellView)+105)];
            if (MediaType==0)//img
            {
                self.m_imageView=[[WebImageView alloc] initWithFrame:CGRectMake(10,10+questionHeight, PARENT_WIDTH(questionCellView)-20,100 )];
                NSString *urlStr=[NSString stringWithFormat:@"%@%@",SERVER_URL_PUBLIC,[self.testDictionary objectForKey:@"img"]];
                NSLog(@"testimg :%@",urlStr);
                [m_imageView setWebImageViewWithURL:[NSURL URLWithString:urlStr]];
                [questionCellView addSubview:m_imageView];
            }
            else//movie
            {
                self.moviecell=[[TestMovieCell alloc] initWithFrame:CGRectMake(10,10+questionHeight, PARENT_WIDTH(questionCellView)-20,100 )];
                [questionCellView addSubview:self.moviecell];
            }
        }
        [questionCellView setFillColor:[UIColor whiteColor]];
        questionCellView.roundedCorners=TKRoundedCornerBottomLeft| TKRoundedCornerBottomRight;
        questionCellView.drawnBordersSides =TKDrawnBorderSidesAll;
        questionCellView.borderColor = [UIColor whiteColor];
        questionCellView.borderWidth = 1.0f;
        questionCellView.cornerRadius = 4.0f;
        [cell.contentView addSubview:questionCellView];
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(5, 5, Screen_Width-10-10, self.questionHeight)];
        if (PARENT_HEIGHT(label)<40&&self.haveMediaFlag==0)
        {
            [label setFrame:CGRectMake(5, 5, Screen_Width-10-10, 40)];
        }
        label.numberOfLines=0;
        [label setFont:test_text_font];
        [label setTextColor:[UIColor darkGrayColor]];
        [label setBackgroundColor:[UIColor clearColor]];
        label.text=[self.testDictionary objectForKey:@"question"];
        [questionCellView addSubview:label];
        return cell;
    }
    else if (indexPath.row==5)
    {
        TestButtonCell *cell=[[[NSBundle mainBundle] loadNibNamed:@"TestButtonCell" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
        if (self.mutableSelectFlag==0)
        {
            cell.hidden=YES;
        }
        return cell;
    }
    else if (indexPath.row==6)
    {
        self.resultcell=[[[NSBundle mainBundle] loadNibNamed:@"TestResultCell" owner:nil options:nil] objectAtIndex:0];
       resultcell.hidden=YES;
        return resultcell;
    }
    else if (indexPath.row==7)//explain
    {
        static NSString *cellstr = @"ExplainCell";
        self.explainCell = [tableView dequeueReusableCellWithIdentifier:cellstr];
        if(explainCell == nil)
        {
            self.explainCell=[[[NSBundle mainBundle] loadNibNamed:@"ExplainCell" owner:nil options:nil] objectAtIndex:0];
        }
        [explainCell.textBG.layer setBorderColor: [[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1] CGColor]];
        [explainCell.textBG.layer setBorderWidth:1.0];
        [explainCell.textBG.layer setCornerRadius:4.0];
        explainCell.labelText.text=[self.testDictionary objectForKey:@"explain"];
        [self.explainCell updateViewsWithHeight:self.explainHeight];
        self.explainCell.hidden=YES;
        [self reSetCellsAfterAllDisplay];//some times indexPath.row==8 do not responce.
        return explainCell;
    }
    else if (indexPath.row==1||indexPath.row==2||indexPath.row==3||indexPath.row==4)
    {
        TestCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TestCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"TestCell" owner:nil options:nil] objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.delegate=self;
            cell.indexCell=indexPath.row-1;
            if (indexPath.row==1)
            {
                cell.labelSelect.text=[NSString stringWithFormat:@"A.%@",[self.testDictionary objectForKey:@"a"]];
                cell.cellBG.roundedCorners=TKRoundedCornerTopLeft| TKRoundedCornerTopRight;
                cell.cellBG.drawnBordersSides = TKDrawnBorderSidesLeft | TKDrawnBorderSidesRight|TKDrawnBorderSidesTop;
                cell.cellBG.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
                cell.cellBG.borderWidth = 1.0f;
                cell.cellBG.cornerRadius = 4.0f;
            }
            else if (indexPath.row==2)
            {
                cell.labelSelect.text=[NSString stringWithFormat:@"B.%@",[self.testDictionary objectForKey:@"b"]];
                if ([[self.testDictionary objectForKey:@"c"] isEqualToString:@""])
                {
                    cell.cellBG.roundedCorners=TKRoundedCornerBottomLeft| TKRoundedCornerBottomRight;
                    cell.cellBG.drawnBordersSides = TKDrawnBorderSidesLeft | TKDrawnBorderSidesRight|TKDrawnBorderSidesTop|TKDrawnBorderSidesBottom;
                    cell.cellBG.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
                    cell.cellBG.borderWidth = 1.0f;
                    cell.cellBG.cornerRadius = 4.0f;
                }
                else
                {
                    cell.cellBG.roundedCorners=TKRoundedCornerNone;
                    cell.cellBG.drawnBordersSides = TKDrawnBorderSidesLeft | TKDrawnBorderSidesRight|TKDrawnBorderSidesTop;
                    cell.cellBG.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
                    cell.cellBG.borderWidth = 1.0f;
                    cell.cellBG.cornerRadius = 4.0f;
                }
            }
            else if (indexPath.row==3)
            {
                cell.labelSelect.text=[NSString stringWithFormat:@"C.%@",[self.testDictionary objectForKey:@"c"]];
                cell.cellBG.roundedCorners=TKRoundedCornerNone;
                cell.cellBG.drawnBordersSides = TKDrawnBorderSidesLeft | TKDrawnBorderSidesRight|TKDrawnBorderSidesTop;
                cell.cellBG.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
                cell.cellBG.borderWidth = 1.0f;
                cell.cellBG.cornerRadius = 4.0f;
                if ([[self.testDictionary objectForKey:@"c"] isEqualToString:@""])
                {
                    cell.hidden=YES;
                }
            }
            else if (indexPath.row==4)
            {
                cell.labelSelect.text=[NSString stringWithFormat:@"D.%@",[self.testDictionary objectForKey:@"d"]];
                cell.cellBG.roundedCorners=TKRoundedCornerBottomLeft|TKRoundedCornerBottomRight;
                cell.cellBG.drawnBordersSides = TKDrawnBorderSidesLeft | TKDrawnBorderSidesRight|TKDrawnBorderSidesBottom|TKDrawnBorderSidesTop;
                cell.cellBG.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
                cell.cellBG.borderWidth = 1.0f;
                cell.cellBG.cornerRadius = 4.0f;
                if ([[self.testDictionary objectForKey:@"c"] isEqualToString:@""])
                {
                    cell.hidden=YES;
                }
            }
            if ([cell.labelSelect.text isEqualToString:@""])
            {
                cell.hidden=YES;
            }
            [self.m_arySelectCells addObject:cell];
            //set mutable select img
            if (self.mutableSelectFlag==1)
            {
                [cell.selectImage setImage:[UIImage imageNamed:@"select_fang"]];
                [cell.selectRight setImage:[UIImage imageNamed:@"select_right_fang"]];
            }
            
        }
        return cell;
        
    }
    else
    {
        return [[UITableViewCell alloc] init];
    }
}
-(void)reSetCellsAfterAllDisplay
{
    //after all return
    
    //set selected answer
    if (self.mutableSelectFlag==0)
    {
        if(pageIndex!=0&&[[self.delegate m_dicSelected] objectForKey:[NSString stringWithFormat:@"%d",pageIndex-1]])
        {
            NSInteger selectIndex=0;
            if ([[[self.delegate m_dicSelected] objectForKey:[NSString stringWithFormat:@"%d",pageIndex-1]] isEqualToString:@"A"])
            {
                selectIndex=0;
            }
            else if ([[[self.delegate m_dicSelected] objectForKey:[NSString stringWithFormat:@"%d",pageIndex-1]] isEqualToString:@"B"])
            {
                selectIndex=1;
            }
            else if ([[[self.delegate m_dicSelected] objectForKey:[NSString stringWithFormat:@"%d",pageIndex-1]] isEqualToString:@"C"])
            {
                selectIndex=2;
            }
            else if ([[[self.delegate m_dicSelected] objectForKey:[NSString stringWithFormat:@"%d",pageIndex-1]] isEqualToString:@"D"])
            {
                selectIndex=3;
            }
            [self showCurrentPageAnswerIfHaveSelected:selectIndex];
        }
    }
    else
    {
        if(pageIndex!=0&&[[self.delegate m_dicSelected] objectForKey:[NSString stringWithFormat:@"%d",pageIndex-1]])
        {
            NSMutableArray *selectedArray=[NSMutableArray array];
            for(int i =0; i < [[[self.delegate m_dicSelected] objectForKey:[NSString stringWithFormat:@"%d",pageIndex-1]] length]; i++)
            {
                NSString *answerStr = [[[self.delegate m_dicSelected] objectForKey:[NSString stringWithFormat:@"%d",pageIndex-1]] substringWithRange:NSMakeRange(i, 1)];
                NSString *an=@"0";
                if ([answerStr isEqualToString:@"A"])
                {
                    an=@"0";
                }
                else if ([answerStr isEqualToString:@"B"])
                {
                    an=@"1";
                }
                else if ([answerStr isEqualToString:@"C"])
                {
                    an=@"2";
                }
                else if ([answerStr isEqualToString:@"D"])
                {
                    an=@"3";
                }
                [selectedArray addObject:an];
            }
            
            [self showCurrentPageAnswerIfHaveSelectedForMutableSelect:selectedArray];
        }
        
    }
    
    //show all aswer
    if (self.shouldShowAnswer==1&&self.m_arySelectCells.count==4)
    {
        [self showCurrentPageAnswer];
    }
    if ([self.delegate.mytestmodel.type integerValue]==5)
    {
        self.explainCell.hidden=NO;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heigh=45;
    if (indexPath.row==0)
    {
        if (self.haveMediaFlag==0)
        {
            heigh=self.questionHeight+10+10;
            if (heigh<60)
            {
                heigh=60;
            }
        }
        else
        {
            heigh=self.questionHeight+10+10+105;
        }
        
    }
    else if (indexPath.row==5)//mutable select done button
    {
        if (mutableSelectFlag==1)
        {
             heigh=50;
        }
        else
        {
            heigh=0;
        }
    }
    else if (indexPath.row==6)//result cell
    {
        heigh=45;
    }
    else if (indexPath.row==7)
    {
        heigh=75-26+self.explainHeight;
    }
    else if (indexPath.row==8)
    {
        heigh=10;
    }
    else
    {
        heigh=45;
        if (indexPath.row==3&&[[self.testDictionary objectForKey:@"c"] isEqualToString:@""])
        {
            heigh=0;
        }
        else if (indexPath.row==4&&[[self.testDictionary objectForKey:@"d"] isEqualToString:@""])
        {
            heigh=0;
        }
    }
    
    return heigh;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row>0&&indexPath.row<5)
    {
        [self showCurrentPageAnswer:indexPath.row-1];
    }
    else if (indexPath.row==0&&self.haveMediaFlag==1&&self.MediaType==0)
    {
        [self amplifyImage];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark---------- actions
-(void)showCurrentPageAnswer:(NSInteger)indexSelected//do select
{
    if([self.delegate.mytestmodel.type integerValue]==5)//exam result
    {
        return;
    }
    if (haveShowAnswer==1)
    {
        return;
    }
    if (self.mutableSelectFlag==0)//single select
    {
        TestCell *cell=[self.m_arySelectCells objectAtIndex:indexSelected];
        cell.selectRight.hidden=NO;
        cell.selectImage.hidden=YES;
        if ([self.delegate.mytestmodel.type integerValue]!=2)//no exam
        {
            if (self.haveShowAnswer==0)
            {
                for (TestCell *cell in self.m_arySelectCells)
                {
                    if (cell.indexCell==self.answerIndex)
                    {
                        cell.selectGou.hidden=NO;
                    }
                }
                if (indexSelected!=self.answerIndex)
                {
                    [self soundError];
                    [self showErrorQuestionBG];
                }
                else
                {
                    [self soundRight];
                    [self autoScroll];
                    [self showRightQuestionBG];
                }
                //set selected dictionary
                NSString *item=@"";
                switch (indexSelected)
                {
                    case 0:
                        item=@"A";
                        break;
                    case 1:
                        item=@"B";
                        break;
                    case 2:
                        item=@"C";
                        break;
                    case 3:
                        item=@"D";
                        break;
                    default:
                        break;
                }
                [self.delegate setSelectedArrayIndex:@"0" selectedItem:item];
                self.haveShowAnswer++;
            }
        }
        else//exam
        {
            for (TestCell *cell in self.m_arySelectCells)
            {
                cell.selectRight.hidden=YES;
            }
            TestCell *cell=[self.m_arySelectCells objectAtIndex:indexSelected];
            cell.selectRight.hidden=NO;
            
            NSString *item=@"";
            switch (indexSelected)
            {
                case 0:
                    item=@"A";
                    break;
                case 1:
                    item=@"B";
                    break;
                case 2:
                    item=@"C";
                    break;
                case 3:
                    item=@"D";
                    break;
                default:
                    break;
            }
            [self.delegate setSelectedArrayIndex:@"0" selectedItem:item];
            //exam aoto scroll
            [self.delegate autoScroll];
        }
    }
    else//mitable select
    {
        if (haveShowAnswer==0)
        {
            TestCell *cell=[self.m_arySelectCells objectAtIndex:indexSelected];
            [cell cellPressedForMutableSelect];
        }
    }
}
-(void)showCurrentPageAnswer//answer setting
{
    
        if (self.haveShowAnswer==0)
        {
            if (self.mutableSelectFlag==0)//single select
            {
                for (TestCell *cell in self.m_arySelectCells)
                {
                    if (cell.indexCell==self.answerIndex)
                    {
                        cell.selectGou.hidden=NO;
                    }
                }
            }
            else//mutable select
            {
                for (TestCell *cell in self.m_arySelectCells)
                {
                    for (NSString *answer in answerIndexArray)
                    {
                        if (cell.indexCell==[answer integerValue])
                        {
                            cell.selectGou.hidden=NO;
                        }
                    }
                }
            }
            //result cell
            self.resultcell.hidden=NO;
            [resultcell.textBG setBackgroundColor:[UIColor colorWithRed:140/255.0 green:208/255.0 blue:155/255.0 alpha:1]];
            resultcell.label.text=[NSString stringWithFormat:@"标准答案是：%@",[self.testDictionary objectForKey:@"answer"]];
            self.haveShowAnswer++;
        }

}
-(void)showCurrentPageAnswerIfHaveSelected:(NSInteger)indexSelected//single select
{
    if (self.mutableSelectFlag==0)//single select
    {
        if ([self.delegate.mytestmodel.type integerValue]!=2)//no exam
        {
            if (self.haveShowAnswer==0)
            {
                for (TestCell *cell in self.m_arySelectCells)
                {
                    if (cell.indexCell==self.answerIndex)
                    {
                        cell.selectGou.hidden=NO;
//                        cell.selectRight.hidden=NO;
                    }
                }
                TestCell *cell=[self.m_arySelectCells objectAtIndex:indexSelected];
                cell.selectRight.hidden=NO;
                cell.selectImage.hidden=YES;
                
                if (indexSelected!=self.answerIndex)
                {
                    [self showErrorQuestionBG];
                }
                else
                {
                    [self showRightQuestionBG];
                }
                haveShowAnswer++;
            }
        }
        else//exam
        {
            for (TestCell *cell in self.m_arySelectCells)
            {
                cell.selectRight.hidden=YES;
            }
            TestCell *cell=[self.m_arySelectCells objectAtIndex:indexSelected];
            cell.selectRight.hidden=NO;
            
        }
    }
}
-(void)showCurrentPageAnswerIfHaveSelectedForMutableSelect:(NSMutableArray*)selectedArray//mutable select
{
    NSLog(@"selectedArray :%@",selectedArray);
    if ([self.delegate.mytestmodel.type integerValue]!=2)//no exam
    {
        if (self.haveShowAnswer==0)
        {
            NSInteger haveErrorFlag=0;
            //ui show all right
            for (TestCell *cell in self.m_arySelectCells)
            {
                for (NSString *anser in self.answerIndexArray)
                {
                    if (cell.indexCell==[anser integerValue])
                    {
                        cell.selectGou.hidden=NO;
//                        cell.selectRight.hidden=NO;
                    }
                }
            }
            //ui judge right error
            for (NSString *selectStr in selectedArray)
            {
                NSInteger rightFlag=0;
                for (NSString *anser in self.answerIndexArray)
                {
                    if ([anser isEqualToString:selectStr])
                    {
                        rightFlag++;
                    }
                }
                if (rightFlag==1)//right
                {
                    //do noting
                }
                else//error show error img
                {
                    haveErrorFlag++;
                }
                TestCell *cell = [self.m_arySelectCells objectAtIndex:[selectStr integerValue]];
                cell.selectImage.hidden=YES;
                cell.selectRight.hidden=NO;
            }
            if (haveErrorFlag>0||selectedArray.count<self.answerIndexArray.count)
            {
                [self showErrorQuestionBG];
            }
            else
            {
                [self showRightQuestionBG];
            }
            self.haveShowAnswer++;
        }
    }
    
    else//exam
    {
        for (TestCell *cell in self.m_arySelectCells)
        {
            for (NSString *selectIndex in selectedArray)
            {
                if ([selectIndex integerValue]==cell.indexCell)
                {
                    [cell cellPressedForMutableSelect];
                }
            }
        }
    }

}

-(void)hideCurrentPageAnswer
{
    if (self.mutableSelectFlag==0)//single select
    {
        if (haveShowAnswer!=0)
        {
            for (TestCell *cell in self.m_arySelectCells)
            {
//                if (cell.indexCell==self.answerIndex)
//                {
                    cell.selectGou.hidden=YES;
                    cell.selectRight.hidden=YES;
                    cell.selectImage.hidden=NO;
//                }
            }
            haveShowAnswer=0;
        }
    }
    else//mutable select
    {
        if (haveShowAnswer!=0)
        {
            for (TestCell *cell in self.m_arySelectCells)
            {
//                for (NSString *answer in self.answerIndexArray)
//                {
//                    if (cell.indexCell==[answer integerValue])
//                    {
                        cell.selectGou.hidden=YES;
                        cell.selectRight.hidden=YES;
                        cell.selectImage.hidden=NO;
//                    }
//                }
                
            }
            haveShowAnswer=0;
        }
    }
    //result cell
    self.resultcell.hidden=YES;
    
}
-(void)soundRight
{
    if ([[self.delegate.m_loginfo.settingDictionary objectForKey:@"sound"] integerValue]==1)
    {
        NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"right" ofType:@"mp3"];
        NSURL *audioUrl = [NSURL fileURLWithPath:audioPath];
        self.player=nil;
        self.player = [[AVPlayer alloc] initWithURL:audioUrl];
        [self.player setVolume:1];
        [self.player play];
    }
}
-(void)soundError
{
    if ([[self.delegate.m_loginfo.settingDictionary objectForKey:@"sound"] integerValue]==1)
    {
        NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"error" ofType:@"mp3"];
        NSURL *audioUrl = [NSURL fileURLWithPath:audioPath];
        self.player=nil;
        self.player = [[AVPlayer alloc] initWithURL:audioUrl];
        [self.player setVolume:1];
        [self.player play];
    }
}
-(void)showErrorQuestionBG
{
    [questionCellView setFillColor:YCC_LightRed];
    questionCellView.borderColor=YCC_LightRed;
    self.resultcell.hidden=NO;
    [resultcell setErrorView:[self.testDictionary objectForKey:@"answer"]];
    
    self.explainCell.hidden=NO;
    self.m_tableView.scrollEnabled=YES;
}
-(void)showRightQuestionBG
{
    [questionCellView setFillColor:YCC_LightGreen];
    questionCellView.borderColor=YCC_LightGreen;
    self.resultcell.hidden=NO;
    [resultcell setRightView];
    
    self.explainCell.hidden=NO;
    self.m_tableView.scrollEnabled=YES;
}
-(void)autoScroll
{
    if ([[self.delegate.m_loginfo.settingDictionary objectForKey:@"autoScroll"] integerValue]==1)
    {
        [self.delegate autoScroll];
    }
}

-(void)selectDoneForMutableSelect
{
    //get selected array
    NSMutableArray *selectedArray=[NSMutableArray array];
    for (TestCell *cell in self.m_arySelectCells)
    {
        if (cell.selectRight.hidden==NO)
        {
            [selectedArray addObject:[NSString stringWithFormat:@"%d",cell.indexCell]];
        }
    }
    
    if ([self.delegate.mytestmodel.type integerValue]!=2)//no exam
    {
        if (self.haveShowAnswer==0)
        {
            NSInteger haveErrorFlag=0;
            //ui show all right
            for (TestCell *cell in self.m_arySelectCells)
            {
                for (NSString *anser in self.answerIndexArray)
                {
                    if (cell.indexCell==[anser integerValue])
                    {
                        cell.selectGou.hidden=NO;
                    }
                }
            }
            //ui judge right error
            for (NSString *selectStr in selectedArray)
            {
                NSInteger rightFlag=0;
                for (NSString *anser in self.answerIndexArray)
                {
                    if ([anser isEqualToString:selectStr])
                    {
                        rightFlag++;
                    }
                }
                if (rightFlag==1)//right
                {
                    //do noting
                }
                else//error show error img
                {
//                    TestCell *cell = [self.m_arySelectCells objectAtIndex:[selectStr integerValue]];
//                    cell.selectImage.hidden=YES;
                    haveErrorFlag++;
                }
            }
            //sound
            if (haveErrorFlag>0||selectedArray.count<self.answerIndexArray.count)
            {
                [self soundError];
                [self showErrorQuestionBG];
            }
            else
            {
                [self soundRight];
                [self autoScroll];
                [self showRightQuestionBG];
            }
            //set selected dictionary
            NSMutableString *item=[NSMutableString string];
            for (NSString *str in selectedArray)
            {
                NSString *addStr=@"";
                switch ([str integerValue])
                {
                    case 0:
                        addStr=@"A";
                        break;
                    case 1:
                        addStr=@"B";
                        break;
                    case 2:
                        addStr=@"C";
                        break;
                    case 3:
                        addStr=@"D";
                        break;
                    default:
                        break;
                }
                [item appendString:addStr];
            }
            [self.delegate setSelectedArrayIndex:@"0" selectedItem:item];
            self.haveShowAnswer++;
        }
    }
    
    else//exam
    {
        
        //set selected dictionary
        NSMutableString *item=[NSMutableString string];
        for (NSString *str in selectedArray)
        {
            NSString *addStr=@"";
            switch ([str integerValue])
            {
                case 0:
                    addStr=@"A";
                    break;
                case 1:
                    addStr=@"B";
                    break;
                case 2:
                    addStr=@"C";
                    break;
                case 3:
                    addStr=@"D";
                    break;
                default:
                    break;
            }
            [item appendString:addStr];
        }
        [self.delegate setSelectedArrayIndex:@"0" selectedItem:item];
        //exam aoto scroll
        [self.delegate autoScroll];

    }

}
#pragma mark ========= amplify image
-(void)amplifyImage
{
    self.blackBG=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    [blackBG setBackgroundColor:[UIColor blackColor]];
    blackBG.alpha=0.85;
    [[UIApplication sharedApplication].keyWindow addSubview:self.blackBG];
    
    self.largeImageView=[[UIImageView alloc] initWithImage:self.m_imageView.imageview.image];
    if (Screen_Width/PARENT_WIDTH(self.m_imageView.imageview)*PARENT_HEIGHT(self.m_imageView.imageview)<Screen_Height)
    {
        [largeImageView setFrame:CGRectMake(0,( Screen_Height-Screen_Width/PARENT_WIDTH(self.m_imageView.imageview)*PARENT_HEIGHT(self.m_imageView.imageview))/2.0, Screen_Width, Screen_Width/PARENT_WIDTH(self.m_imageView.imageview)*PARENT_HEIGHT(self.m_imageView.imageview))];
    }
    else
    {
        [largeImageView setFrame:CGRectMake((Screen_Width-PARENT_WIDTH(self.m_imageView.imageview)*Screen_Height/PARENT_HEIGHT(self.m_imageView.imageview))/2.0,0, PARENT_WIDTH(self.m_imageView.imageview)*Screen_Height/PARENT_HEIGHT(self.m_imageView.imageview), Screen_Height)];
    }
    [[UIApplication sharedApplication].keyWindow addSubview:self.largeImageView];
    
    self.btnDissmissLargeImage=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnDissmissLargeImage setFrame: CGRectMake(0, 0, Screen_Width, Screen_Height)];
    [btnDissmissLargeImage addTarget:self action:@selector(dismissLargeImage) forControlEvents:UIControlEventTouchUpInside];
     [[UIApplication sharedApplication].keyWindow addSubview:self.btnDissmissLargeImage];
    
}
-(void)dismissLargeImage
{
    [self.blackBG removeFromSuperview];
    self.blackBG=nil;
    [self.largeImageView removeFromSuperview];
    self.largeImageView=nil;
    [self.btnDissmissLargeImage removeFromSuperview];
    self.btnDissmissLargeImage=nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
