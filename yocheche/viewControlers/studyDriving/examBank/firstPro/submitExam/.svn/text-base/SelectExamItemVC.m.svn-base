//
//  SelectExamItemVC.m
//  weixueche
//
//  Created by carcool on 1/15/15.
//  Copyright (c) 2015 carcool. All rights reserved.
//

#import "SelectExamItemVC.h"
#import "TestVC.h"
@interface SelectExamItemVC ()

@end

@implementation SelectExamItemVC
@synthesize m_dicSelected,m_aryTests,btnWWidth,scrollView,delegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"查看试卷";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
    [MobClick beginLogPageView:@"SelectExamItemVC"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"SelectExamItemVC"];
}
-(void)updateViews
{
    self.btnWWidth=(Screen_Width-3)/4.0;
    self.scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [scrollView setBackgroundColor:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1]];
    [scrollView setContentSize:CGSizeMake(Screen_Width,100/4*btnWWidth+24*1)];
    [self.view addSubview:scrollView];
    
    NSInteger i=0;
    while (i<100)
    {
        UIView *btnBG=[[UIView alloc] initWithFrame:CGRectMake(i%4*btnWWidth+i%4*1, i/4*btnWWidth+i/4*1, btnWWidth, btnWWidth)];
        [btnBG setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1]];
        [self.scrollView addSubview:btnBG];
        UILabel *labelNum=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, PARENT_WIDTH(btnBG), PARENT_HEIGHT(btnBG))];
        [labelNum setBackgroundColor:[UIColor clearColor]];
        [labelNum setFont:[UIFont systemFontOfSize:18.0]];
        [labelNum setTextAlignment:NSTextAlignmentCenter];
        [labelNum setTextColor:[UIColor colorWithRed:207/255.0 green:207/255.0 blue:208/255.0 alpha:1]];
        labelNum.text=[NSString stringWithFormat:@"%d",i+1];
        [btnBG addSubview:labelNum];
        UILabel *labelResult=[[UILabel alloc] initWithFrame:CGRectMake(-5, PARENT_HEIGHT(btnBG)-30, btnWWidth, 30)];
        [labelResult setTextAlignment:NSTextAlignmentRight];
        [labelResult setBackgroundColor:[UIColor clearColor]];
        [labelResult setFont:[UIFont systemFontOfSize:12.0]];
        [labelResult setTextColor:[UIColor colorWithRed:207/255.0 green:207/255.0 blue:208/255.0 alpha:1]];
        labelResult.text=@"未做";
        [btnBG addSubview:labelResult];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag=i;
        [btn setFrame:CGRectMake(0, 0, PARENT_WIDTH(btnBG), PARENT_HEIGHT(btnBG))];
        [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [btnBG addSubview:btn];
        
        if ([self.m_dicSelected objectForKey:[NSString stringWithFormat:@"%d",i]]&&[[self.m_dicSelected objectForKey:[NSString stringWithFormat:@"%d",i]] isEqualToString:[[self.m_aryTests objectAtIndex:i] objectForKey:@"answer"]])//right
        {
            [btnBG setBackgroundColor:[UIColor whiteColor]];
            [labelNum setTextColor:[UIColor blackColor]];
            [labelResult setTextColor:[UIColor colorWithRed:109/255.0 green:228/255.0 blue:114/255.0 alpha:1]];
            labelResult.text=@"正确";
        }
        else if ([self.m_dicSelected objectForKey:[NSString stringWithFormat:@"%d",i]]&&![[self.m_dicSelected objectForKey:[NSString stringWithFormat:@"%d",i]] isEqualToString:[[self.m_aryTests objectAtIndex:i] objectForKey:@"answer"]])//error
        {
            [btnBG setBackgroundColor:[UIColor whiteColor]];
            [labelNum setTextColor:[UIColor blackColor]];
            [labelResult setTextColor:[UIColor colorWithRed:220/255.0 green:0/255.0 blue:0/255.0 alpha:1]];
            labelResult.text=@"错误";
        }

        
        i++;
    }
}
-(void)btnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    NSLog(@"%d",btn.tag);
    
    TestVC *testVC=[[TestVC alloc] init];
    testVC.delegateVC=self.delegate.delegateVC;
    testVC.title=@"查看试卷";
    testVC.mytestmodel=[[TestModel alloc] init];
    
    testVC.m_aryTests=self.m_aryTests;
    testVC.m_dicSelected=(NSMutableDictionary*)self.m_dicSelected;
    testVC.mytestmodel.type=@"5";
    testVC.mytestmodel.pageCurrent=[NSString stringWithFormat:@"%d",btn.tag+1];
    testVC.mytestmodel.pageNum=[NSString stringWithFormat:@"%d",testVC.m_aryTests.count];
    testVC.m_loginfo=self.delegate.delegateVC.m_logInfo;
    
    [self.navigationController pushViewController:testVC animated:YES];
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
