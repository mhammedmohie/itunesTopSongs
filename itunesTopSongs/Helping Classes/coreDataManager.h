//
//  coreDataManager.h
//  itunesTopSongs
//
//  Created by Mohammed ElGohary on 12/26/14.
//  Copyright (c) 2014 Mohammed ElGohary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface coreDataManager : NSObject

+ (coreDataManager *)sharedManager;

- (void)saveSongsToLocalData:(NSArray *)songs;

@end