//
//  SongTableViewCell.h
//  itunesTopSongs
//
//  Created by Mohammed ElGohary on 12/27/14.
//  Copyright (c) 2014 Mohammed ElGohary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Song.h"
@interface SongTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *albumImage;
@property (nonatomic, strong) UILabel *albumTitle;
@property (nonatomic, strong) UILabel *songPrice;
@property (nonatomic, strong) Song *song;
@end
