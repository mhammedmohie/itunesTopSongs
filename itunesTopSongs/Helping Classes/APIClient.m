//
//  APIClient.m
//  itunesTopSongs
//
//  Created by Mohammed ElGohary on 12/26/14.
//  Copyright (c) 2014 Mohammed ElGohary. All rights reserved.
//

#import "APIClient.h"
#import "Constants.h"
@implementation APIClient

+ (APIClient *)sharedClient {
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIClient alloc]initWithBaseURL:[NSURL URLWithString:ITUNES_URL_BASE]];
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
    });
    return _sharedClient;
}


- (void)getTopSongs:(void (^)(AFHTTPRequestOperation *, id))success
            failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure{
    
    [self GET:ITUNES_URL_TOP_SONGS parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success (operation, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure (operation, error);
    }];
}

@end
