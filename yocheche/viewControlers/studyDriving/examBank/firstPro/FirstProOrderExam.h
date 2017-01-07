//
//  FirstProOrderExam.h
//  weixueche
//
//  Created by carcool on 12/12/14.
//  Copyright (c) 2014 carcool. All rights reserved.
//

#import "YCCViewController.h"

@interface FirstProOrderExam : YCCViewController<UIAlertViewDelegate>
@property(nonatomic,retain)IBOutlet MyButton *btnTrainAgain;
@property(nonatomic,retain)IBOutlet MyButton *btnSubmit;
@property(nonatomic,assign)NSInteger progressIndex;
@end
