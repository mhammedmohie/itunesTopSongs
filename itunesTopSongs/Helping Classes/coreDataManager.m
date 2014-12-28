//
//  coreDataManager.m
//  itunesTopSongs
//
//  Created by Mohammed ElGohary on 12/26/14.
//  Copyright (c) 2014 Mohammed ElGohary. All rights reserved.
//

#import "coreDataManager.h"
#import "CoreData+MagicalRecord.h"
#import "Song.h"
@implementation coreDataManager
+ (coreDataManager *)sharedManager {
    static coreDataManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[coreDataManager alloc]init];
    });
    return _sharedClient;
}

- (void)saveSongsToLocalData:(NSArray *)songs{
    
    for (Song *removableSong in [Song MR_findAll]) {
        [removableSong MR_deleteEntity];
    }
    for (NSDictionary *dictionary in songs) {
        
        Song *song = [Song MR_createEntity];
        song.price = [NSNumber numberWithFloat:[[[[dictionary objectForKey:@"im:price"] objectForKey:@"attributes"]objectForKey:@"amount"]floatValue]];
        song.title = [[dictionary objectForKey:@"title"]objectForKey:@"label"];
        song.link = [[[[dictionary objectForKey:@"link"] firstObject]objectForKey:@"attributes"] objectForKey:@"href"];
        song.image = [[[dictionary objectForKey:@"im:image"]lastObject] objectForKey:@"label"];
    }
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];

    NSLog(@"%@",[Song MR_findAll]);
}
@end
