//
//  WebImageView.m
//  banjiayao
//
//  Created by shimai on 10/30/14.
//  Copyright (c) 2014 ideasky. All rights reserved.
//

#import "WebImageView.h"
//picture http://120.24.214.23:9999/carcool/exam.action?filename=1/1_1_1_29.png
//pro4 picture http://120.24.214.23:9999/carcool/exam.action?filename=4/40001.jpg
@implementation WebImageView
@synthesize imageview;
-(void)setWebImageViewWithURL:(NSURL *)url
{
    NSString *strUrl=[url absoluteString];
    strUrl=[strUrl substringFromIndex:strUrl.length-9];

    if (url==nil)
    {
        [self setImage:[UIImage imageNamed:nil]];
        return;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES ) objectAtIndex: 0],strUrl]])
    {
        NSData *myData= [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES ) objectAtIndex: 0],strUrl]];
        //set frame
        if (myData.length>0)
        {
            self.imageview=[[UIImageView alloc] initWithImage:[UIImage imageWithData:myData]];
            [imageview setFrame:CGRectMake((PARENT_WIDTH(self)-PARENT_WIDTH(imageview)*100/PARENT_HEIGHT(imageview))/2.0, 0, PARENT_WIDTH(imageview)*100/PARENT_HEIGHT(imageview), 100)];
            if (PARENT_WIDTH(self.imageview)>Screen_Width-20-20)
            {
                [imageview setFrame:CGRectMake(0, 0, Screen_Width-20-20, 100/PARENT_WIDTH(self.imageview)*(Screen_Width-20-20))];
            }
            [self addSubview:imageview];
        }
//        self.image = [UIImage imageWithData:myData];
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            dispatch_async(dispatch_get_main_queue(), ^{
                //set frame
                // Update the UI
//                self.image = [UIImage imageWithData:imageData];
                if (imageData.length>0)
                {
                    self.imageview=[[UIImageView alloc] initWithImage:[UIImage imageWithData:imageData]];
                    //if image height ==0 return.
                    if (PARENT_HEIGHT(imageview)<=0)
                    {
                        return ;
                    }
                    [imageview setFrame:CGRectMake((PARENT_WIDTH(self)-PARENT_WIDTH(imageview)*100/PARENT_HEIGHT(imageview))/2.0, 0, PARENT_WIDTH(imageview)*100/PARENT_HEIGHT(imageview), 100)];
                    if (PARENT_WIDTH(self.imageview)>Screen_Width-20-20)
                    {
                        [imageview setFrame:CGRectMake(0, 0, Screen_Width-20-20, 100/PARENT_WIDTH(self.imageview)*(Screen_Width-20-20))];
                    }
                    
                    [self addSubview:imageview];
                }

                //save
                if ([imageData writeToFile:[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES ) objectAtIndex: 0],strUrl] atomically:YES])
                {
                    NSLog(@"saved");
                }
                
            });
        });
        
        //        NSData *myData= UIImageJPEGRepresentation(self.image, 1.0);
        
    }
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
