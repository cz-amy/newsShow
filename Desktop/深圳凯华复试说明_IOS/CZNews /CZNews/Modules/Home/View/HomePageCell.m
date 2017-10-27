//
//  HomePageCell.m
//  CZNews
//
//  Created by tarena on 17/10/25.
//  Copyright © 2017年 Caizhi. All rights reserved.
//

#import "HomePageCell.h"

@interface HomePageCell()
@property (weak, nonatomic) IBOutlet UILabel *newsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet UIView *separatorLine;

@end

@implementation HomePageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.separatorLine.backgroundColor = RGBCOLOR(85, 85, 85, 1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    self.newsTitleLabel.text = titleText;
}

-(void)setContentText:(NSString *)contentText {
    _contentText = contentText;
    self.contentLabel.text  = contentText;
}
-(void)setCommentCount:(NSString *)commentCount{
    _commentCount = commentCount;
    _commentCountLabel.text = commentCount;
    
}


@end
