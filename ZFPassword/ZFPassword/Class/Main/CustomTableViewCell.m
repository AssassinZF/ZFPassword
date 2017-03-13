//
//  CustomTableViewCell.m
//  ZFPassword
//
//  Created by LZF on 2017/3/10.
//  Copyright © 2017年 zf.com. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconImageView.layer.cornerRadius = 25;
    self.iconImageView.clipsToBounds = YES;
    self.titleLabel.textColor = [UIColor textColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
