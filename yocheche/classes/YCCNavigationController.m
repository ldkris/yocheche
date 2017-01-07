//
//  JERNavigationController.m
//  jinerong
//
//  Created by carcool on 5/25/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCNavigationController.h"

@interface YCCNavigationController ()

@end

@implementation YCCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//     Do any additional setup after loading the view.

    UIImageView *bg= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 64)];
    [bg setBackgroundColor:YCC_BlackColor];
//    [bg.layer setBorderWidth:0.5];
//    [bg.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.navigationBar setBackgroundImage:[self imageWithUIView:bg] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationBar.barStyle = UIBarStyleDefault;//设置bar的风格，控制字体颜色
    self.navigationBar.clipsToBounds = NO;
    self.navigationBar.translucent = YES;//viewcontroller'view'y 偏移修改
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:17],NSFontAttributeName,nil]];
    
    //bottom shadow
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
//    
//    UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, PARENT_HEIGHT(self.navigationBar)-1, Screen_Width, 1)];
//    [lineView setBackgroundColor:[UIColor colorWithRed:165/255.0 green:160/255.0 blue:168/255.0 alpha:0.7]];
//    [self.navigationBar addSubview:lineView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//view to image
- (UIImage*) imageWithUIView:(UIView*) view{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    //[view.layer drawInContext:currnetContext];
    [view.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
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
