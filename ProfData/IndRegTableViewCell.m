//
//  IndRegTableViewCell.m
//  ProfData
//
//  Created by Grigor Karapetyan on 10/17/16.
//  Copyright © 2016 Grigor Karapetyan. All rights reserved.
//

#import "IndRegTableViewCell.h"

@implementation IndRegTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)prepareForReuse {
    [self.infoTextField setText:@""];
    self.infoTextField.secureTextEntry = NO;
}

@end
