//
//  CommentCoachCell.m
//  yocheche
//
//  Created by carcool on 2/16/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "CommentCoachCell.h"

@implementation CommentCoachCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=YCC_GrayBG;
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.textViewContent.delegate=self;
    self.textViewContent.returnKeyType=UIReturnKeyDone;
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [self.lineView1 setBackgroundColor:YCC_GrayBG];
    self.starNum=5;
    [self setStarGrade:self.starNum];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark ---------------  textview delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    { //判断输入的字是否是回车，即按下return
        
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        if ([self.textViewContent.text isEqualToString:@""])
        {
            self.labelContentDefault.hidden=NO;
            self.textViewContent.text=@"";
        }
        else
        {
            self.labelContentDefault.hidden=YES;
        }
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}

-(IBAction)contentBtnPressed:(id)sender
{
    if (![self.textViewContent isFirstResponder])
    {
        [self.textViewContent becomeFirstResponder];
        self.labelContentDefault.hidden=YES;
    }
    else
    {
        [self.textViewContent resignFirstResponder];
        if ([self.textViewContent.text isEqualToString:@""])
        {
            self.labelContentDefault.hidden=NO;
        }
        else
        {
            self.labelContentDefault.hidden=YES;
        }
    }
}
-(IBAction)starBtnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    self.starNum=btn.tag;
    [self setStarGrade:self.starNum];
}
-(void)setStarGrade:(NSInteger)num
{
    switch (num)
    {
        case 1:
            [self.imgStar1 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar2 setImage:[UIImage imageNamed:@"star_off"]];
            [self.imgStar3 setImage:[UIImage imageNamed:@"star_off"]];
            [self.imgStar4 setImage:[UIImage imageNamed:@"star_off"]];
            [self.imgStar5 setImage:[UIImage imageNamed:@"star_off"]];
            self.labelGrade.text=@"差评";
            break;
        case 2:
            [self.imgStar1 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar2 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar3 setImage:[UIImage imageNamed:@"star_off"]];
            [self.imgStar4 setImage:[UIImage imageNamed:@"star_off"]];
            [self.imgStar5 setImage:[UIImage imageNamed:@"star_off"]];
            self.labelGrade.text=@"差评";
            break;
        case 3:
            [self.imgStar1 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar2 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar3 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar4 setImage:[UIImage imageNamed:@"star_off"]];
            [self.imgStar5 setImage:[UIImage imageNamed:@"star_off"]];
            self.labelGrade.text=@"中评";
            break;
        case 4:
            [self.imgStar1 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar2 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar3 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar4 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar5 setImage:[UIImage imageNamed:@"star_off"]];
            self.labelGrade.text=@"好评";
            break;
        case 5:
            [self.imgStar1 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar2 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar3 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar4 setImage:[UIImage imageNamed:@"star_on"]];
            [self.imgStar5 setImage:[UIImage imageNamed:@"star_on"]];
            self.labelGrade.text=@"好评";
            break;
            
        default:
            break;
    }
}
@end
