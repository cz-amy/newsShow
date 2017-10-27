//
//  MineIconCell.m
//  CZNews
//
//  Created by tarena on 17/10/26.
//  Copyright © 2017年 Caizhi. All rights reserved.
//

#import "MineIconCell.h"


@implementation MineIconCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        if (self)
        {
            [self crecateMyCell];
        }
    }
    return self;
}

- (void)crecateMyCell
{
    self.nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLabel];
    
    self.iconImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImage];
    
}

- (void)layoutSubviews
{   [super layoutSubviews];
    
    self.iconImage.backgroundColor = [UIColor purpleColor];
    self.iconImage.layer.masksToBounds = YES;
    self.iconImage.layer.cornerRadius = 40.0f;
    
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.size.mas_equalTo(CGSizeMake(80, 80));
         make.left.mas_equalTo(10);
         make.top.mas_equalTo(10);
     }];

    
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.size.mas_equalTo(CGSizeMake(200, 30));
         make.left.equalTo(self.iconImage.mas_right).mas_offset(10);
         make.centerY.mas_equalTo(self.iconImage.mas_centerY);
     }];
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
