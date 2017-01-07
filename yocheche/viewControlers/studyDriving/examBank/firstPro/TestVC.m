//
//  TestVC.m
//  weixueche
//
//  Created by carcool on 12/6/14.
//  Copyright (c) 2014 carcool. All rights reserved.
//

#import "TestVC.h"
#import "TestCell.h"
#import "TestImageCell.h"
#import "TestPageView.h"
#import "TestModel.h"
#import "SavedTabView.h"
#import "ExamTabView.h"
#import "SubmitExamVC.h"
#import "TestMovieCell.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface TestVC ()

@end

@implementation TestVC
@synthesize mytestmodel,oldPoint,newPoint,m_scrollView,oldOffset,labelPage,car,m_aryPages,showAllAnswersFlag,m_loginfo,delegateVC,examTab,examTime,m_dicSelected,m_actionSheet,blackBG,pageButtons,btnPageCancel,btnPageDone,scrollSelectPage,whiteBG,help,help_l,help_r,imganswer,imgexplain,imgfavor;
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.m_aryTests=[NSMutableArray array];
        self.m_dicSelected=[NSMutableDictionary dictionary];
        self.showAllAnswersFlag=0;
        self.examTime=60*45;
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated
{
    [self checkMoviePlayerAndReset];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *testBG=[[UIView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [testBG setBackgroundColor:[UIColor colorWithRed:251/255.0 green:251/255.0 blue:251/255.0 alpha:1]];
    [self.bg insertSubview:testBG atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(quitTheTest) forControlEvents:UIControlEventTouchUpInside];
    
    self.m_scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-49)];
    m_scrollView.scrollEnabled=YES;
    m_scrollView.showsHorizontalScrollIndicator=NO;
    m_scrollView.delegate=self;
    [m_scrollView setBackgroundColor:[UIColor clearColor]];
    [m_scrollView setPagingEnabled:YES];
    [m_scrollView setContentSize:CGSizeMake(Screen_Width*[self.mytestmodel.pageNum integerValue], PARENT_HEIGHT(m_scrollView))];
    
    self.m_aryPages=[NSMutableArray array];
    if ([self.mytestmodel.type integerValue]==0||[self.mytestmodel.type integerValue]==1)//sequence and rand
    {
        [self scrollToCurrentPage];
        [self.view addSubview:m_scrollView];
        self.oldOffset=m_scrollView.contentOffset;
        [self creatTabView];
    }
    else if ([self.mytestmodel.type integerValue]==4) //error
    {
        [self scrollToPage1ForSaved];
        [self.view addSubview:m_scrollView];
        self.oldOffset=m_scrollView.contentOffset;
        [self creatTabView];
    }
    else if ([self.mytestmodel.type integerValue]==3)//saved
    {
        [self scrollToPage1ForSaved];
        [self.view addSubview:m_scrollView];
        self.oldOffset=m_scrollView.contentOffset;
        [self creatTabViewForSaved];
    }
    else if ([self.mytestmodel.type integerValue]==2)//exam
    {
        [self scrollToPage1ForSaved];
        [self.view addSubview:m_scrollView];
        self.oldOffset=m_scrollView.contentOffset;
        [self creatTabViewForExam];
    }
    else if ([self.mytestmodel.type integerValue]==5)//exam result
    {
        [self scrollToCurrentPage];
        [self.view addSubview:m_scrollView];
        self.oldOffset=m_scrollView.contentOffset;
        [self creatTabViewForExamResult];
    }
    
    [self screatCarAndSetPosition];
    
    
    //guide new
//    if (![[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/testguide",[NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES ) objectAtIndex: 0]]])
//    {
//        [self showHelp];
//    }
}
-(void)showHelp
{
    self.blackBG=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    self.blackBG.alpha=0.7;
    [self.blackBG setBackgroundColor:[UIColor blackColor]];
    [[UIApplication sharedApplication].keyWindow addSubview:self.blackBG];
    
    self.help=[[UIImageView alloc] initWithFrame:CGRectMake((Screen_Width-228)/2.0, (Screen_Height-163)/2.0, 228, 163)];
    [help setImage:[UIImage imageNamed:@"test_guide"]];
    [[UIApplication sharedApplication].keyWindow addSubview:help];
    self.help_l=[[UIImageView alloc] initWithFrame:CGRectMake(10, (Screen_Height-70)/2.0, 14, 70)];
    [help_l setImage:[UIImage imageNamed:@"help_test_l"]];
    [[UIApplication sharedApplication].keyWindow addSubview:help_l];
    self.help_r=[[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width-10-14, (Screen_Height-70)/2.0, 14, 70)];
    [help_r setImage:[UIImage imageNamed:@"help_test_r"]];
    [[UIApplication sharedApplication].keyWindow addSubview:help_r];
    
    UIButton *cancel=[UIButton buttonWithType:UIButtonTypeCustom];
    [cancel setFrame:CGRectMake(0, 0,Screen_Width, Screen_Height)];
    [cancel addTarget:self action:@selector(dismissHelp) forControlEvents:UIControlEventTouchUpInside];
    [self.blackBG addSubview:cancel];
}
-(void)dismissHelp
{
    [self.blackBG removeFromSuperview];
    self.blackBG=nil;
    [self.help removeFromSuperview];
    self.help=nil;
    [self.help_l removeFromSuperview];
    self.help_l=nil;
    [self.help_r removeFromSuperview];
    self.help_r=nil;
    
    //save  data
    NSData *mydata=[[NSData alloc] init];
    NSArray *array = NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES );
    NSString *path = [NSString stringWithFormat:@"%@/testguide",[array objectAtIndex: 0]];
    [mydata writeToFile:path atomically:NO];
}

-(void)scrollToPage1ForSaved
{
    NSInteger i=0;
    while (i<((7<[self.mytestmodel.pageNum integerValue])?7:[self.mytestmodel.pageNum integerValue]))
    {
        TestPageView *page=[[TestPageView alloc] init];
        page.testDictionary=[self.m_aryTests objectAtIndex:i];
        [page setFrame:CGRectMake(i*Screen_Width, 0, PARENT_WIDTH(page), PARENT_HEIGHT(page))];
        page.delegate=self;
        [page updateViews];
        [m_scrollView addSubview:page];
        [self.m_aryPages addObject:page];
        i++;
    }

}
-(void)scrollToCurrentPage
{
    NSInteger startIndex=0;
    NSInteger currentIndex=0;
    NSInteger i=[self.mytestmodel.pageCurrent integerValue];
    if (i<=[self.mytestmodel.pageNum integerValue]-3)
    {
        if (i-3>0)
        {
            startIndex=i-3;
            currentIndex=i;
        }
        else
        {
            startIndex=1;
            currentIndex=i;
        }
    }
    else
    {
        startIndex=[self.mytestmodel.pageNum integerValue]-6;
        currentIndex=i;
    }
    NSInteger pageIndex=0;
    while (pageIndex<7)
    {
        TestPageView *page=[[TestPageView alloc] init];
        page.testDictionary=[self.m_aryTests objectAtIndex:startIndex-1];
        if ([self.mytestmodel.type integerValue]==5)
        {
            page.pageIndex=startIndex;
            page.shouldShowAnswer=1;
        }
        [page setFrame:CGRectMake((startIndex-1)*Screen_Width, 0, PARENT_WIDTH(page), PARENT_HEIGHT(page))];
        page.delegate=self;
        [page updateViews];
        [m_scrollView addSubview:page];
        [self.m_aryPages addObject:page];
        pageIndex++;
        startIndex++;
    }
    [self.m_scrollView setContentOffset:CGPointMake((currentIndex-1)*Screen_Width, self.m_scrollView.contentOffset.y)];
}
-(void)quitTheTest
{
    //index page save
    if ([self.mytestmodel.type integerValue]==0)
    {
        self.m_loginfo.pro1Index=self.mytestmodel.pageCurrent;
    }
    //error save
    if ([self.mytestmodel.type integerValue]!=3)//favor don't save to error bank
    {
        for (NSString *index in [self.m_dicSelected allKeys])
        {
            NSString *anwser=[[self.m_aryTests objectAtIndex:[index integerValue]] objectForKey:@"answer"];
            if ([[self.m_dicSelected objectForKey:index] isEqualToString:anwser])
            {
                //right ,remove the right test from error bank
                if ([self.mytestmodel.type integerValue]==4) //error
                {
                    NSDictionary *dic= [self.m_aryTests objectAtIndex:[index integerValue]];
                    NSString *indexString=[dic objectForKey:@"index"];
                    [self.m_loginfo.pro1ErrorArray removeObject:indexString];
                }
            }
            else//save to my error
            {
                NSDictionary *dic= [self.m_aryTests objectAtIndex:[index integerValue]];
                NSString *indexString=[dic objectForKey:@"index"];
                NSInteger haveErrorBefore=0;
                for (NSString *page in self.m_loginfo.pro1ErrorArray)
                {
                    if ([page isEqualToString:indexString])
                    {
                        haveErrorBefore=1;
                        break;
                    }
                }
                if (haveErrorBefore==0)
                {
                    [self.m_loginfo.pro1ErrorArray addObject:indexString];
                }
                
            }
        }

    }
    
    if(self.delegateVC.progressIndex==1)
    {
        [MyFounctions saveLogInfo:[LogInfo returnToDictionary:self.m_loginfo]];
    }
    else if (self.delegateVC.progressIndex==4)
    {
        [MyFounctions saveLogInfoPro4:[LogInfo returnToDictionary:self.m_loginfo]];
    }
    [self popSelfViewContriller];
}
-(void)viewWillAppear:(BOOL)animated
{
//    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
//    YRSideViewController *sideViewController=[delegate sideViewController];
//    sideViewController.needSwipeShowMenu=NO;
    [MobClick beginLogPageView:@"TestVC"];
}
-(void)viewWillDisappear:(BOOL)animated
{
//    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
//    YRSideViewController *sideViewController=[delegate sideViewController];
//    sideViewController.needSwipeShowMenu=YES;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [MobClick endLogPageView:@"TestVC"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)creatTabView
{
    UIView *tabbg=[[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height-49, Screen_Width, 49)];
    [tabbg setBackgroundColor:[UIColor whiteColor]];
    [tabbg.layer setBorderWidth:1.0];
    [tabbg.layer setBorderColor:[Test_LightGray_Border CGColor]];
    [tabbg.layer setShadowColor:[[UIColor lightGrayColor] CGColor]];
    [tabbg.layer setShadowOffset:CGSizeMake(0, 0)];
    [tabbg.layer setShadowRadius:2.0];
    [tabbg.layer setShadowOpacity:0.5];
    [self.view addSubview:tabbg];
    
    UIImageView *imgPage=[[UIImageView alloc] initWithFrame:CGRectMake(10, (49-16)/2.0, 16, 16)];
    [imgPage setImage:[UIImage imageNamed:@"page"]];
    [tabbg addSubview:imgPage];
    self.labelPage=[[UILabel alloc] initWithFrame:CGRectMake(26+5, 0, 100, 49)];
    [labelPage setTextColor:[UIColor lightGrayColor]];
    [labelPage setFont:[UIFont systemFontOfSize:12.0]];
    labelPage.text=[NSString stringWithFormat:@"%@/%@",self.mytestmodel.pageCurrent,self.mytestmodel.pageNum];
    [tabbg addSubview:labelPage];
    UIButton *btnPage=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnPage setFrame:CGRectMake(PARENT_X(imgPage)-10, 0,70, 49)];
    [btnPage addTarget:self action:@selector(scrollPage) forControlEvents:UIControlEventTouchUpInside];
    [tabbg addSubview:btnPage];
    
    UIImageView *imgsetting=[[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width-10-22, (49-21)/2.0, 22, 21)];
    [imgsetting setImage:[UIImage imageNamed:@"setting"]];
    [tabbg addSubview:imgsetting];
    UIButton *btnSetting=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnSetting setFrame:CGRectMake(PARENT_X(imgsetting)-10, 0,50, 49)];
    [btnSetting addTarget:self action:@selector(setTheSettings) forControlEvents:UIControlEventTouchUpInside];
    [tabbg addSubview:btnSetting];
    
    self.imgfavor=[[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width-10-22-40-18, (49-17)/2.0, 18, 17)];
    [imgfavor setImage:[UIImage imageNamed:@"favor"]];
    [tabbg addSubview:imgfavor];
    UILabel *labelfavor=[[UILabel alloc] initWithFrame:CGRectMake(Screen_Width-10-22-40+5, 0, 40, 49)];
    [labelfavor setTextColor:[UIColor lightGrayColor]];
    [labelfavor setFont:[UIFont systemFontOfSize:12.0]];
    labelfavor.text=@"收藏";
    [tabbg addSubview:labelfavor];
    UIButton *btnSave=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnSave setFrame:CGRectMake(PARENT_X(imgfavor), 0, PARENT_WIDTH(imgfavor)+PARENT_WIDTH(labelfavor)+5, 49)];
    [btnSave addTarget:self action:@selector(saveTheTest) forControlEvents:UIControlEventTouchUpInside];
    [tabbg addSubview:btnSave];
    
    self.imganswer=[[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width-10-22-40-18-40-20, (49-20)/2.0, 20, 20)];
    [imganswer setImage:[UIImage imageNamed:@"answer"]];
    [tabbg addSubview:imganswer];
    UILabel *labelanswer=[[UILabel alloc] initWithFrame:CGRectMake(Screen_Width-10-22-40-18-40+5, 0, 40, 49)];
    [labelanswer setTextColor:[UIColor lightGrayColor]];
    [labelanswer setFont:[UIFont systemFontOfSize:12.0]];
    labelanswer.text=@"答案";
    [tabbg addSubview:labelanswer];
    UIButton *btnAnswer=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnAnswer setFrame:CGRectMake(PARENT_X(imganswer), 0, PARENT_WIDTH(imganswer)+PARENT_WIDTH(labelanswer)+5, 49)];
    [btnAnswer addTarget:self action:@selector(showAllAnswers) forControlEvents:UIControlEventTouchUpInside];
    [tabbg addSubview:btnAnswer];
    
    self.imgexplain=[[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width-10-22-40-18-40-20-40-20, (49-20)/2.0, 20, 20)];
    [imgexplain setImage:[UIImage imageNamed:@"explain"]];
    [tabbg addSubview:imgexplain];
    UILabel *labelexplain=[[UILabel alloc] initWithFrame:CGRectMake(Screen_Width-10-22-40-18-40-20-40+5, 0, 40, 49)];
    [labelexplain setTextColor:[UIColor lightGrayColor]];
    [labelexplain setFont:[UIFont systemFontOfSize:12.0]];
    labelexplain.text=@"解释";
    [tabbg addSubview:labelexplain];
    UIButton *btnexplain=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnexplain setFrame:CGRectMake(PARENT_X(imgexplain), 0, PARENT_WIDTH(imgexplain)+PARENT_WIDTH(imgexplain)+5, 49)];
    [btnexplain addTarget:self action:@selector(showExplain) forControlEvents:UIControlEventTouchUpInside];
    [tabbg addSubview:btnexplain];
    
}
-(void)creatTabViewForSaved
{
    SavedTabView *tab=[[[NSBundle mainBundle] loadNibNamed:@"SavedTabView" owner:nil options:nil] objectAtIndex:0];
    tab.delegate=self;
    self.imganswer=tab.imganswer;
    self.imgexplain=tab.imgexplain;
    [tab setFrame:CGRectMake(0, Screen_Height-49, Screen_Width, 49)];
    [tab.layer setBorderWidth:1.0];
    [tab.layer setBorderColor:[Test_LightGray_Border CGColor]];
    [tab.layer setShadowColor:[[UIColor lightGrayColor] CGColor]];
    [tab.layer setShadowOffset:CGSizeMake(0, 0)];
    [tab.layer setShadowRadius:2.0];
    [self.view addSubview:tab];
    
    self.labelPage=tab.labelPage;
    self.labelPage.text=[NSString stringWithFormat:@"%@/%@",self.mytestmodel.pageCurrent,self.mytestmodel.pageNum];
}
-(void)creatTabViewForExam
{
    self.examTab=[[[NSBundle mainBundle] loadNibNamed:@"ExamTabView" owner:nil options:nil] objectAtIndex:0];
    examTab.delegate=self;
    [examTab setFrame:CGRectMake(0, Screen_Height-49, Screen_Width, 49)];
    [examTab.layer setBorderWidth:1.0];
    [examTab.layer setBorderColor:[Test_LightGray_Border CGColor]];
    [examTab.layer setShadowColor:[[UIColor lightGrayColor] CGColor]];
    [examTab.layer setShadowOffset:CGSizeMake(0, 0)];
    [examTab.layer setShadowRadius:2.0];
    [self.view addSubview:examTab];
    
    self.labelPage=examTab.labelPage;
    self.labelPage.text=[NSString stringWithFormat:@"%@/%@",self.mytestmodel.pageCurrent,self.mytestmodel.pageNum];
    
    [self refreshExamTime];
}
-(void)creatTabViewForExamResult
{
    UIView *tabbg=[[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height-49, Screen_Width, 49)];
    [tabbg setBackgroundColor:[UIColor whiteColor]];
    [tabbg.layer setBorderWidth:1.0];
    [tabbg.layer setBorderColor:[Test_LightGray_Border CGColor]];
    [tabbg.layer setShadowColor:[[UIColor lightGrayColor] CGColor]];
    [tabbg.layer setShadowOffset:CGSizeMake(0, 0)];
    [tabbg.layer setShadowRadius:2.0];
    [tabbg.layer setShadowOpacity:0.5];
    [self.view addSubview:tabbg];
    
    UIImageView *imgPage=[[UIImageView alloc] initWithFrame:CGRectMake(10, (49-16)/2.0, 16, 16)];
    [imgPage setImage:[UIImage imageNamed:@"page"]];
    [tabbg addSubview:imgPage];
    self.labelPage=[[UILabel alloc] initWithFrame:CGRectMake(26+5, 0, 100, 49)];
    [labelPage setTextColor:[UIColor lightGrayColor]];
    [labelPage setFont:[UIFont systemFontOfSize:12.0]];
    labelPage.text=[NSString stringWithFormat:@"%@/%@",self.mytestmodel.pageCurrent,self.mytestmodel.pageNum];
    [tabbg addSubview:labelPage];
    
}

-(void)refreshExamTime
{
    examTime--;
    NSInteger fen=examTime/60;
    NSString *fenstr=fen>9?[NSString stringWithFormat:@"%d",fen]:[NSString stringWithFormat:@"0%d",fen];
    NSInteger miao=examTime%60;
    NSString *miaostr=miao>9?[NSString stringWithFormat:@"%d",miao]:[NSString stringWithFormat:@"0%d",miao];
    self.examTab.labelTime.text=[NSString stringWithFormat:@"%@:%@",fenstr,miaostr];
    if (examTime>0)
    {
        [self performSelector:@selector(refreshExamTime) withObject:nil afterDelay:1.0];
    }
    else
    {
        [self examTimeOut];
    }
}
-(void)screatCarAndSetPosition
{
    //progress car
    if ([self.mytestmodel.pageNum integerValue]>[self.mytestmodel.pageCurrent integerValue])
    {
        self.car=[[UIImageView alloc] initWithFrame:CGRectMake(([self.mytestmodel.pageNum integerValue]-1)>0?(Screen_Width-28)*([self.mytestmodel.pageCurrent integerValue]-1)/(float)([self.mytestmodel.pageNum integerValue]-1):0, Screen_Height-49-12.5, 28, 12.5)];
        [car setImage:[UIImage imageNamed:@"car_progress"]];
        [self.view addSubview:car];
        self.car.hidden=YES;//hide for youcheche.
    }
}
-(void)resetCarPosition
{
     [self.car setFrame:CGRectMake(([self.mytestmodel.pageNum integerValue]-1)>0?(Screen_Width-28)*([self.mytestmodel.pageCurrent integerValue]-1)/(float)([self.mytestmodel.pageNum integerValue]-1):0, Screen_Height-49-12.5, 28, 12.5)];
}
#pragma mark ----------- scrollview delegate
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.m_scrollView.scrollEnabled=NO;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x>self.oldOffset.x)//nest
    {
        self.oldOffset=scrollView.contentOffset;
        [self setPages:1];
    }
    else if(scrollView.contentOffset.x<self.oldOffset.x)//last
    {
        self.oldOffset=scrollView.contentOffset;
        [self setPages:0];
    }
    self.m_scrollView.scrollEnabled=YES;
}
-(void)manulScroll:(NSInteger)nextOrLast//force scroll
{
    if (nextOrLast==1)//next
    {
        [self.m_scrollView setContentOffset:CGPointMake(self.m_scrollView.contentOffset.x+Screen_Width,self.m_scrollView.contentOffset.y )];
        self.oldOffset=self.m_scrollView.contentOffset;
        [self setPages:1];
    }
    else//last
    {
        [self.m_scrollView setContentOffset:CGPointMake(self.m_scrollView.contentOffset.x-Screen_Width,self.m_scrollView.contentOffset.y )];
        self.oldOffset=self.m_scrollView.contentOffset;
        [self setPages:0];
    }
}
#pragma mark ---------actions
#pragma mark =============== scroll page
-(void)setPages:(NSInteger)next
{
    if (next==0)//last page
    {
        self.mytestmodel.pageCurrent=[NSString stringWithFormat:@"%d",[self.mytestmodel.pageCurrent integerValue]-1];
        [self.labelPage setText:[NSString stringWithFormat: @"%@/%@",self.mytestmodel.pageCurrent,self.mytestmodel.pageNum]];
        [self resetScrollViewContentLast];
    }
    else if (next==1)//next page
    {
        self.mytestmodel.pageCurrent=[NSString stringWithFormat:@"%d",[self.mytestmodel.pageCurrent integerValue]+1];
        [self.labelPage setText:[NSString stringWithFormat: @"%@/%@",self.mytestmodel.pageCurrent,self.mytestmodel.pageNum]];
        [self resetScrollViewContentNext];
    }
    if ([self.mytestmodel.pageNum integerValue]==1)
    {
        [self.car setFrame:CGRectMake(Screen_Width-28, Screen_Height-49-12.5, 28, 12.5)];
    }
    else
    {
        [self.car setFrame:CGRectMake((Screen_Width-28)*([self.mytestmodel.pageCurrent integerValue]-1)/(float)([self.mytestmodel.pageNum integerValue]-1), Screen_Height-49-12.5, 28, 12.5)];
    } 

}
-(void)resetScrollViewContentNext
{
    [self checkAnswerExplainAndSaveShow];
    [self checkMoviePlayerAndReset];
    
    if ([self.mytestmodel.pageCurrent integerValue]>=[self.mytestmodel.pageNum integerValue]-2)
    {
        return;
    }
    TestPageView *pageviewlast=[self.m_aryPages lastObject];
    if (PARENT_X(pageviewlast)-2*PARENT_WIDTH(self.m_scrollView)<=self.m_scrollView.contentOffset.x)
    {
        //remove and add new
        TestPageView *pageviewfirst=[self.m_aryPages objectAtIndex:0];
        [pageviewfirst removeFromSuperview];
        [self.m_aryPages removeObjectAtIndex:0];
        
        TestPageView *newpage=[[TestPageView alloc] init];
        newpage.pageIndex=[self.mytestmodel.pageCurrent integerValue]+3;
        newpage.testDictionary=[self.m_aryTests objectAtIndex:[self.mytestmodel.pageCurrent integerValue]+3-1];
        [newpage setFrame:CGRectMake(PARENT_X(pageviewlast)+PARENT_WIDTH(self.m_scrollView), PARENT_Y(pageviewlast), PARENT_WIDTH(pageviewlast), PARENT_HEIGHT(pageviewlast))];
        newpage.delegate=self;
        [newpage updateViews];
        [m_scrollView addSubview:newpage];
        [self.m_aryPages addObject:newpage];
        if (showAllAnswersFlag==1||[self.mytestmodel.type integerValue]==5)
        {
            newpage.shouldShowAnswer=1;
        }
    }
    
}
-(void)resetScrollViewContentLast
{
    [self checkAnswerExplainAndSaveShow];
    [self checkMoviePlayerAndReset];
    
    if ([self.mytestmodel.pageCurrent integerValue]<=1+2)
    {
        return;
    }
    TestPageView *pageviewfirst=[self.m_aryPages objectAtIndex:0];
    if (PARENT_X(pageviewfirst)+2*PARENT_WIDTH(self.m_scrollView)>=self.m_scrollView.contentOffset.x)
    {
        //remove and add new
        TestPageView *pageviewlast=[self.m_aryPages lastObject];
        [pageviewlast removeFromSuperview];
        [self.m_aryPages removeLastObject];
        
        TestPageView *newpage=[[TestPageView alloc] init];
        newpage.pageIndex=[self.mytestmodel.pageCurrent integerValue]-3;
        newpage.testDictionary=[self.m_aryTests objectAtIndex:[self.mytestmodel.pageCurrent integerValue]-3-1];
        [newpage setFrame:CGRectMake(PARENT_X(pageviewfirst)-PARENT_WIDTH(self.m_scrollView), PARENT_Y(pageviewfirst), PARENT_WIDTH(pageviewfirst), PARENT_HEIGHT(pageviewfirst))];
        newpage.delegate=self;
        [newpage updateViews];
        [m_scrollView addSubview:newpage];
        [self.m_aryPages insertObject:newpage atIndex:0];
        if (showAllAnswersFlag==1||[self.mytestmodel.type integerValue]==5)
        {
            newpage.shouldShowAnswer=1;
        }
    }
    
}
-(void)checkAnswerExplainAndSaveShow
{
    for (TestPageView *pageview in self.m_aryPages)
    {
        //index 7.1.1.23
        if ([[pageview.testDictionary objectForKey:@"index"] isEqualToString:[[self.m_aryTests objectAtIndex:[self.mytestmodel.pageCurrent integerValue]-1] objectForKey:@"index"]])
        {
            if (pageview.explainCell.hidden==YES)
            {
                [self.imgexplain setImage:[UIImage imageNamed:@"explain"]];
            }
            else
            {
                [self.imgexplain setImage:[UIImage imageNamed:@"explain2"]];
            }
            if (pageview.haveShowAnswer==1)
            {
                [self.imganswer setImage:[UIImage imageNamed:@"answer2"]];
            }
            else
            {
                [self.imganswer setImage:[UIImage imageNamed:@"answer"]];
            }
            
            [self.imgfavor setImage:[UIImage imageNamed:@"favor"]];
            NSDictionary  *currentTestDic=[self.m_aryTests objectAtIndex:[self.mytestmodel.pageCurrent integerValue]-1];
            for (NSString *page in self.m_loginfo.pro1SavedArray)
            {
                if ([page isEqualToString:[currentTestDic objectForKey:@"index"]])
                {
                    [self.imgfavor setImage:[UIImage imageNamed:@"save2"]];
                    break;
                }
            }
        }
    }
}
-(void)checkMoviePlayerAndReset
{
    for (TestPageView *pageview in self.m_aryPages)
    {
        //index 7.1.1.23
        if (pageview.haveMediaFlag==1&&pageview.MediaType==1&&![[pageview.testDictionary objectForKey:@"index"] isEqualToString:[[self.m_aryTests objectAtIndex:[self.mytestmodel.pageCurrent integerValue]-1] objectForKey:@"index"]])
        {
            [pageview.moviecell removeMyMoviePlayer];
        }
    }
    for (TestPageView *pageview in self.m_aryPages)
    {
        if (pageview.haveMediaFlag==1&&pageview.MediaType==1&&[[pageview.testDictionary objectForKey:@"index"] isEqualToString:[[self.m_aryTests objectAtIndex:[self.mytestmodel.pageCurrent integerValue]-1] objectForKey:@"index"]])
        {
//            NSString *strImg=[pageview.testDictionary objectForKey:@"img"];
//            NSString *strUrl=[ NSString stringWithFormat:@"%@exam%@",SERVER_URL_PUBLIC,strImg];
            NSString *strUrl=[NSString stringWithFormat:@"%@%@",SERVER_URL_PUBLIC,[pageview.testDictionary objectForKey:@"img"]];
            NSLog(@"testmp4 :%@",strUrl);
            NSString *savedUrl=[strUrl substringFromIndex:strUrl.length-6];
            //check the movie have saved
            if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES ) objectAtIndex: 0],savedUrl]])
            {
                [pageview.moviecell setMovieSource:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES ) objectAtIndex: 0],savedUrl]]];
            }
            else//need download the movie
            {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:strUrl]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //save
                        if ([imageData writeToFile:[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES ) objectAtIndex: 0],savedUrl] atomically:YES])
                        {
                            NSLog(@"saved");
                            [pageview.moviecell setMovieSource:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES ) objectAtIndex: 0],savedUrl]]];
                        }
                        
                    });
                });

            }
        }
    }
}
-(void)autoScroll
{
    if (self.m_scrollView.contentOffset.x+Screen_Width<self.m_scrollView.contentSize.width)
    {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [self.m_scrollView setContentOffset:CGPointMake(self.m_scrollView.contentOffset.x+Screen_Width, self.m_scrollView.contentOffset.y)];
        } completion:^(BOOL finished) {
            self.oldOffset=self.m_scrollView.contentOffset;
            [self setPages:1];
        }];
    }
}
#pragma mark ===============sequence test setting
-(void)showAllAnswers
{
    if (self.showAllAnswersFlag==0)
    {
        self.showAllAnswersFlag=1;
        for (TestPageView *pageview in self.m_aryPages)
        {
            [pageview showCurrentPageAnswer];
        }
        [self.imganswer setImage:[UIImage imageNamed:@"answer2"]];
    }
    else
    {
        self.showAllAnswersFlag=0;
        for (TestPageView *pageview in self.m_aryPages)
        {
            [pageview hideCurrentPageAnswer];
        }
        [self.imganswer setImage:[UIImage imageNamed:@"answer"]];
    }
}
-(void)saveTheTest
{
    NSDictionary  *currentTestDic=[self.m_aryTests objectAtIndex:[self.mytestmodel.pageCurrent integerValue]-1];
    
    NSInteger haveSavedBefore=0;
    for (NSString *page in self.m_loginfo.pro1SavedArray)
    {
        if ([page isEqualToString:[currentTestDic objectForKey:@"index"]])
        {
            [self.m_loginfo.pro1SavedArray removeObject:page];
            haveSavedBefore=1;
        }
    }
    if (haveSavedBefore==0)
    {
        [self.m_loginfo.pro1SavedArray addObject:[currentTestDic objectForKey:@"index"]];
        [self showMessage:@"已添加到收藏"];
        [self.imgfavor setImage:[UIImage imageNamed:@"save2"]];
    }
    else
    {
        [self showMessage:@"已移除收藏"];
        [self.imgfavor setImage:[UIImage imageNamed:@"favor"]];
    }
    
    
}
-(void)setTheSettings
{
    self.m_actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                          otherButtonTitles:[[self.m_loginfo.settingDictionary objectForKey:@"sound"] isEqualToString:@"1"]?@"关闭声音":@"开启声音", [[self.m_loginfo.settingDictionary objectForKey:@"autoScroll"] isEqualToString:@"1"]?@"取消正确自动翻页":@"开启正确自动翻页",nil];
    self.m_actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [self.m_actionSheet showInView:self.view];
}
-(void)showExplain
{
    for (TestPageView *pageview in self.m_aryPages)
    {
        NSDictionary *dic= [self.m_aryTests objectAtIndex:[self.mytestmodel.pageCurrent integerValue]-1];
        if ([[dic objectForKey:@"index"] isEqualToString:[pageview.testDictionary objectForKey:@"index"]])
        {
            if (pageview.explainCell.hidden==YES)
            {
                pageview.explainCell.hidden=NO;
                pageview.m_tableView.scrollEnabled=YES;
                [self.imgexplain setImage:[UIImage imageNamed:@"explain2"]];
            }
            else
            {
                pageview.explainCell.hidden=YES;
                [pageview.m_tableView setContentOffset:CGPointMake(0, 0)];
                pageview.m_tableView.scrollEnabled=NO;
                [self.imgexplain setImage:[UIImage imageNamed:@"explain"]];
            }
        }
    }
}
-(void)scrollPage
{
    self.blackBG=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    self.blackBG.alpha=0.7;
    [self.blackBG setBackgroundColor:[UIColor blackColor]];
    [[UIApplication sharedApplication].keyWindow addSubview:self.blackBG];
    
    self.whiteBG=[[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height-350, Screen_Width, 350)];
    [self.whiteBG setBackgroundColor:[UIColor whiteColor]];
    [[UIApplication sharedApplication].keyWindow addSubview:self.whiteBG];
    
    UILabel *labelPageC=[[UILabel alloc] initWithFrame:CGRectMake(20, 5, 80, 30)];
    [labelPageC setTextColor:[UIColor whiteColor]];
    [labelPageC setTextAlignment:NSTextAlignmentCenter];
    [labelPageC setFont:[UIFont systemFontOfSize:14.0]];
    [labelPageC setBackgroundColor:[UIColor colorWithRed:37/255.0 green:157/255.0 blue:240/255.0 alpha:1]];
    [labelPageC.layer setCornerRadius:6.0];
    labelPageC.text=self.labelPage.text;
    [self.whiteBG addSubview:labelPageC];
    
    UIImageView *cancelImg=[[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width-46, 7, 26, 26)];
    [cancelImg setImage:[UIImage imageNamed:@"error"]];
    [self.whiteBG addSubview:cancelImg];
    UIButton *cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setFrame: CGRectMake(Screen_Width-66, 0, 66, 40)];
    [cancelBtn addTarget:self action:@selector(removeSelectPageMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteBG addSubview:cancelBtn];
    
    self.scrollSelectPage=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, Screen_Width, PARENT_HEIGHT(self.whiteBG)-40)];
    [self.whiteBG addSubview:self.scrollSelectPage];
    NSInteger i=0;
    float btnWidth=(Screen_Width-8*3)/7.0;
    while (i<self.m_aryTests.count)
    {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag=i+1;
        [btn setFrame: CGRectMake((i%7+1)*3+i%7*btnWidth, (i/7+1)*3+i/7*btnWidth, btnWidth, btnWidth)];
        [btn setBackgroundColor:[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [btn.layer setCornerRadius:4.0];
        [btn addTarget:self action:@selector(scrollPageeTo:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollSelectPage addSubview:btn];

        if([self.mytestmodel.type integerValue]!=2)// no exam
        {
            if ([self.m_dicSelected objectForKey:[NSString stringWithFormat:@"%d",i]]&&[[self.m_dicSelected objectForKey:[NSString stringWithFormat:@"%d",i]] isEqualToString:[[self.m_aryTests objectAtIndex:i] objectForKey:@"answer"]])
            {
                [btn setBackgroundColor:[UIColor colorWithRed:120/255.0 green:212/255.0 blue:190/255.0 alpha:1]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            else if ([self.m_dicSelected objectForKey:[NSString stringWithFormat:@"%d",i]]&&![[self.m_dicSelected objectForKey:[NSString stringWithFormat:@"%d",i]] isEqualToString:[[self.m_aryTests objectAtIndex:i] objectForKey:@"answer"]])
            {
                [btn setBackgroundColor:[UIColor colorWithRed:255/255.0 green:132/255.0 blue:73/255.0 alpha:1]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }

        }
        i++;
    }
    [self.scrollSelectPage setContentSize:CGSizeMake(Screen_Width, (i/7+1)*btnWidth+(i/7+2)*3)];
    
}
-(void)removeSelectPageMenu
{
    [self.scrollSelectPage removeFromSuperview];
    self.scrollSelectPage=nil;
    [self.whiteBG removeFromSuperview];
    self.whiteBG=nil;
    [self.blackBG removeFromSuperview];
    self.blackBG=nil;
}
-(void)scrollPageeTo:(id)sender
{
    [self removeSelectPageMenu];
    
    UIButton *btn=sender;
    [self startLoading];
    NSInteger toPage=btn.tag;
    NSInteger pageNum=[self.mytestmodel.pageCurrent integerValue];
    if (pageNum<toPage)
    {
        while (pageNum<toPage)
        {
            [self manulScroll:1];
            pageNum=[self.mytestmodel.pageCurrent integerValue];
        }
    }
    else
    {
        while (pageNum>toPage)
        {
            [self manulScroll:0];
            pageNum=[self.mytestmodel.pageCurrent integerValue];
        }
    }
    [self stopLoading];
}
#pragma mark ===============saved test setting
-(void)deleteSavedTest
{
    if([self.m_loginfo.pro1SavedArray count]<=0)
    {
        [self showMessage:@"已无收藏！"];
        return;
    }
    
    NSInteger currentpage=[self.mytestmodel.pageCurrent integerValue]-1;
    
    [self.m_loginfo.pro1SavedArray removeObjectAtIndex:[self.mytestmodel.pageCurrent integerValue]-1];
    [MyFounctions saveLogInfo:[LogInfo returnToDictionary:self.m_loginfo]];
    
    //clear array
    [self.m_aryTests removeAllObjects];
    [self.m_aryPages removeAllObjects];
    
    for (NSString *pagenum in self.m_loginfo.pro1SavedArray)
    {
        [self.m_aryTests addObject:[self.delegateVC.m_aryTestsPro1 objectAtIndex:[pagenum integerValue]-1]];
    }
    self.mytestmodel.type=@"3";  //收藏
    self.mytestmodel.pageCurrent=@"1";
    self.mytestmodel.pageNum=[NSString stringWithFormat:@"%d",self.m_aryTests.count];
    
    [self.m_scrollView removeFromSuperview];
    self.m_scrollView=nil;
    self.m_scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-49)];
    m_scrollView.scrollEnabled=YES;
    m_scrollView.showsHorizontalScrollIndicator=NO;
    m_scrollView.delegate=self;
    [m_scrollView setBackgroundColor:[UIColor clearColor]];
    [m_scrollView setPagingEnabled:YES];
    [m_scrollView setContentSize:CGSizeMake(Screen_Width*[self.mytestmodel.pageNum integerValue], PARENT_HEIGHT(m_scrollView))];
    [self scrollToPage1ForSaved];
    [self.view addSubview:m_scrollView];
    
    NSLog(@"%d",currentpage);
    if (currentpage>1)
    {
        NSInteger indexpage=1;
        while (indexpage<currentpage)
        {
            [self manulScroll:1];
            indexpage++;
        }
    }
    
    [self.labelPage setText:[NSString stringWithFormat: @"%@/%@",self.mytestmodel.pageCurrent,self.mytestmodel.pageNum]];
    [self showMessage:@"已删除"];
    self.oldOffset=m_scrollView.contentOffset;
    if ([self.mytestmodel.pageNum integerValue]==1)
    {
        [self.car setFrame:CGRectMake(Screen_Width-28, Screen_Height-49-12.5, 28, 12.5)];
    }
    else
    {
        [self.car setFrame:CGRectMake((Screen_Width-28)*([self.mytestmodel.pageCurrent integerValue]-1)/(float)([self.mytestmodel.pageNum integerValue]-1), Screen_Height-49-12.5, 28, 12.5)];
    }
    
}
#pragma mark ===============exam test setting
-(void)noteSubmitExam
{
    if([self.mytestmodel.pageCurrent integerValue]==100)
    {
        [self submitExamScore];
    }
    else
    {
        [self showAlertViewWithTitle:nil message:@"还没做完试题，现在就交卷？" cancelButton:@"取消" others:@"交卷"];
        self.alertView.tag=19;
        self.alertView.delegate=self;
    }
}
-(void)submitExamScore
{
    //calculate scroe
    NSInteger score=0;
    for (NSString *index in [self.m_dicSelected allKeys])
    {
        NSString *anwser=[[self.m_aryTests objectAtIndex:[index integerValue]] objectForKey:@"answer"];
        if ([[self.m_dicSelected objectForKey:index] isEqualToString:anwser])
        {
            score++;
        }
        else//save to my error
        {
            NSDictionary *dic= [self.m_aryTests objectAtIndex:[index integerValue]];
            NSString *indexString=[dic objectForKey:@"index"];
            NSString *havePage=@"";
            for (NSString *page in self.m_loginfo.pro1ErrorArray)
            {
                if ([page isEqualToString:indexString])
                {
                    havePage=page;
                }
            }
            if ([havePage isEqualToString:@""])
            {
                [self.m_loginfo.pro1ErrorArray addObject:indexString];
            }
        }
    }
    //calculate use time
    NSString *useTime=@"";
    NSInteger usedTimeInt=60*45-examTime;
    NSInteger fen=usedTimeInt/60;
    NSString *fenstr=fen>9?[NSString stringWithFormat:@"%d",fen]:[NSString stringWithFormat:@"0%d",fen];
    NSInteger miao=usedTimeInt%60;
    NSString *miaostr=miao>9?[NSString stringWithFormat:@"%d",miao]:[NSString stringWithFormat:@"0%d",miao];
    useTime=[NSString stringWithFormat:@"%@:%@",fenstr,miaostr];
    
    //save the exam score and time
    NSString *allTime=[MyFounctions timeStampToNormalTime:[MyFounctions getTimeStamp]];
    NSString *savedtime=[allTime substringWithRange:NSMakeRange(5,11)];
    [self.m_loginfo.scoreWithTimeArray insertObject:[NSDictionary dictionaryWithObjects:@[[NSString stringWithFormat:@"%d",score],savedtime] forKeys:@[@"score",@"time"]] atIndex:0];
    if (self.delegateVC.progressIndex==1)//pro1
    {
        [MyFounctions saveLogInfo:[LogInfo returnToDictionary:self.m_loginfo]];
    }
    else if (self.delegateVC.progressIndex==4)//pro4
    {
        [MyFounctions saveLogInfoPro4:[LogInfo returnToDictionary:self.m_loginfo]];
    }
    
    //upload paased time and totle times
    NSInteger passedThreeTimes=0;
    NSInteger maxTimes=0;
    for (NSDictionary *dic in self.m_loginfo.scoreWithTimeArray)
    {
        if ([[dic objectForKey:@"score"] integerValue]>89)
        {
            passedThreeTimes++;
            if (maxTimes<passedThreeTimes)
            {
                maxTimes=passedThreeTimes;
            }
        }
        else if ([[dic objectForKey:@"score"] integerValue]<=89)
        {
            passedThreeTimes=0;
        }
    }
    if ([[[MyFounctions getUserInfo] objectForKey:@"account"] length]>0)//have log in
    {
        //wheather pass the exam
        if (score>89)
        {
            SubmitExamVC *vc=[[SubmitExamVC alloc] init];
            vc.passFlag=1;
            vc.score=score;
            vc.time=useTime;
            vc.delegate=self;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            SubmitExamVC *vc=[[SubmitExamVC alloc] init];
            vc.passFlag=0;
            vc.score=score;
            vc.time=useTime;
            vc.delegate=self;
            [self.navigationController pushViewController:vc animated:YES];
        }

    }
    else//log out
    {
        //wheather pass the exam
        if (score>89)
        {
            SubmitExamVC *vc=[[SubmitExamVC alloc] init];
            vc.passFlag=1;
            vc.score=score;
            vc.time=useTime;
            vc.delegate=self;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            SubmitExamVC *vc=[[SubmitExamVC alloc] init];
            vc.passFlag=0;
            vc.score=score;
            vc.time=useTime;
            vc.delegate=self;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
-(void)examTimeOut
{
    [self showAlertViewWithTitle:nil message:@"考试时间已到，是否交卷？" cancelButton:@"重新开始" others:@"交卷"];
    self.alertView.tag=1;
}
-(void)restartExam
{
    //clear array
    [self.m_aryTests removeAllObjects];
    [self.m_aryPages removeAllObjects];
    
    NSMutableArray *array=[NSMutableArray arrayWithArray:self.delegateVC.m_aryTestsPro1];
    srand(time(0));
    NSInteger indexRand=0;
    NSInteger i=0;
    while (i<100)
    {
        indexRand=rand()%array.count;
        [self.m_aryTests addObject:[array objectAtIndex:indexRand]];
        [array removeObjectAtIndex:indexRand];
        i++;
    }
    self.mytestmodel.type=@"2";  //模拟考试
    self.mytestmodel.pageCurrent=@"1";
    self.mytestmodel.pageNum=[NSString stringWithFormat:@"%d",self.m_aryTests.count];
    
    [self.m_scrollView removeFromSuperview];
    self.m_scrollView=nil;
    self.m_scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-49)];
    m_scrollView.scrollEnabled=YES;
    m_scrollView.showsHorizontalScrollIndicator=NO;
    m_scrollView.delegate=self;
    [m_scrollView setBackgroundColor:[UIColor clearColor]];
    [m_scrollView setPagingEnabled:YES];
    [m_scrollView setContentSize:CGSizeMake(Screen_Width*[self.mytestmodel.pageNum integerValue], PARENT_HEIGHT(m_scrollView))];
    [self scrollToPage1ForSaved];
    [self.view addSubview:m_scrollView];
    
    
    [self.labelPage setText:[NSString stringWithFormat: @"%@/%@",self.mytestmodel.pageCurrent,self.mytestmodel.pageNum]];
    self.oldOffset=m_scrollView.contentOffset;
    [self.car setFrame:CGRectMake(([self.mytestmodel.pageNum integerValue]-1)>0?(Screen_Width-28)*([self.mytestmodel.pageCurrent integerValue]-1)/(float)([self.mytestmodel.pageNum integerValue]-1):0, Screen_Height-49-12.5, 28, 12.5)];
    
    //reset time
    self.examTime=60*45;
    [self refreshExamTime];
}
-(void)setSelectedArrayIndex:(NSString*)index selectedItem:(NSString*)item
{
    [self.m_dicSelected setObject:item forKey:[NSString stringWithFormat:@"%d",[self.mytestmodel.pageCurrent integerValue]-1]];
}
#pragma mark ---------------uialert view delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1)//time out
    {
        if (buttonIndex==0)
        {
            [self restartExam];//have test
        }
        else if (buttonIndex==1)
        {
            [self submitExamScore];
        }
    }
    else if (self.alertView.tag==19)//提示是否交卷
    {
        if (buttonIndex==0)
        {
            
        }
        else if (buttonIndex==1)
        {
            [self submitExamScore];
        }
    }
}
#pragma mark ---------------uiactionsheet  delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        if ([[self.m_loginfo.settingDictionary objectForKey:@"sound"] integerValue]==1)
        {
            [self.m_loginfo.settingDictionary setObject:@"0" forKey:@"sound"];
        }
        else
        {
             [self.m_loginfo.settingDictionary setObject:@"1" forKey:@"sound"];
        }
    }
    else if (buttonIndex==1)
    {
        if ([[self.m_loginfo.settingDictionary objectForKey:@"autoScroll"] integerValue]==1)
        {
            [self.m_loginfo.settingDictionary setObject:@"0" forKey:@"autoScroll"];
        }
        else
        {
            [self.m_loginfo.settingDictionary setObject:@"1" forKey:@"autoScroll"];
        }

    }
}
#pragma mark ------------ share
-(void)share
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    appdelegate.handleURLtype=0;//set appdelegate handle type
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
    
    //构造分享内容

    
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"91学车"
                                     images:@[[UIImage imageNamed:@"ShareSDK"]]
                                        url:[NSURL URLWithString:@"http://mob.com"]
                                      title:@"91学车"
                                       type:SSDKContentTypeAuto];
    //2、分享（可以弹出我们的分享菜单和编辑界面）
    [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                       case SSDKResponseStateSuccess:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                           message:[NSString stringWithFormat:@"%@",error]
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"OK"
                                                                 otherButtonTitles:nil, nil];
                           [alert show];
                           break;
                       }
                       default:
                           break;
                   }
               }
     ];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
