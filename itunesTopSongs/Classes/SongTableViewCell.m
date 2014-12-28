//
//  SongTableViewCell.m
//  itunesTopSongs
//
//  Created by Mohammed ElGohary on 12/27/14.
//  Copyright (c) 2014 Mohammed ElGohary. All rights reserved.
//

#import "SongTableViewCell.h"

@implementation SongTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        // Initialization code
        [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];

        self.albumImage = [UIImageView new];
        self.albumImage.translatesAutoresizingMaskIntoConstraints = NO;
        [self.albumImage setBackgroundColor:[UIColor redColor]];
        [self.albumImage setFrame:CGRectMake(10, 10, 80, 80)];
        [self addSubview:self.albumImage];
        
        
        self.albumTitle = [UILabel new];
        self.albumTitle.translatesAutoresizingMaskIntoConstraints = NO;
        [self.albumTitle setFrame:CGRectMake(100, 20, self.bounds.size.width - 120, 40)];
        [self.albumTitle setNumberOfLines:2];
        [self.albumTitle setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:self.albumTitle];

        self.songPrice = [UILabel new];
        self.songPrice.translatesAutoresizingMaskIntoConstraints = NO;
        [self.songPrice setFrame:CGRectMake(100, 60, self.bounds.size.width-120, 30)];
        [self.songPrice setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:self.songPrice];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
