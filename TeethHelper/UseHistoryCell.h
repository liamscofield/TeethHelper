//
//  UseHistoryCell.h
//  TeethHelper
//
//  Created by AlienLi on 15/8/19.
//  Copyright (c) 2015年 MarcoLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UseHistoryCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *topLine;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *useTimesLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;

@end
