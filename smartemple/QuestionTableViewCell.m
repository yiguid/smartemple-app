//
//  QuestionTableViewCell.m
//  smartemple
//
//  Created by wang on 16/3/7.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "QuestionTableViewCell.h"
#import "smartemple.pch"
@implementation QuestionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.answerlabel = [[UILabel alloc]init];
    self.answerlabel.textColor = [UIColor colorWithRed:159/255.0 green:14/255.0 blue:31/255.0 alpha:1.0];
    [self.contentView addSubview:self.answerlabel];
    
    self.answer = [[UILabel alloc]init];
    self.answer.textColor = [UIColor colorWithRed:159/255.0 green:14/255.0 blue:31/255.0 alpha:1.0];
    self.answer.font = TextFont;
    self.answer.numberOfLines = 0;
    [self.contentView addSubview:self.answer];

    self.questionlabel = [[UILabel alloc]init];
    self.questionlabel.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    [self.contentView addSubview:self.questionlabel];

    self.question = [[UILabel alloc]init];
    self.question.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    self.question.font = TextFont;
    self.question.numberOfLines = 0;
    [self.contentView addSubview:self.question];
    
    self.fengexian = [[UIView alloc]init];
    self.fengexian.backgroundColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    [self.contentView addSubview:self.fengexian];

    
    
    
    return self;
    
}

- (void)layoutSubviews{
    
    CGSize textquestionSize = [self sizeWithText:self.question.text font:TextFont maxSize:CGSizeMake(wScreen-40, MAXFLOAT)];
    [self.question setFrame:CGRectMake(35,18, wScreen-40,textquestionSize.height)];
    
    CGSize textanswerSize = [self sizeWithText:self.answer.text font:TextFont maxSize:CGSizeMake(wScreen-40, MAXFLOAT)];
    [self.answer setFrame:CGRectMake(35,textquestionSize.height+18, wScreen-40,textanswerSize.height+10)];
    
    self.questionlabel.frame = CGRectMake(10,15, 30, 20);
    self.answerlabel.frame = CGRectMake(10,textquestionSize.height+20, 30, 20);
    
   
    self.fengexian.frame = CGRectMake(10,textanswerSize.height+textquestionSize.height+30, wScreen-20,0.5);
    

    
    
}

- (void)setup:(Questionmodel *)model{
    
  self.questionlabel.text = @"问:";
  self.question.text = model.question;
    
  self.answerlabel.text = @"答:";
  self.answer.text = model.answer;
    
    
}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}



@end
