//
//  APIClient.h
//  itunesTopSongs
//
//  Created by Mohammed ElGohary on 12/26/14.
//  Copyright (c) 2014 Mohammed ElGohary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface APIClient : AFHTTPRequestOperationManager

+ (APIClient *)sharedClient;
- (void)getTopSongs:(void (^)(AFHTTPRequestOperation *operation, id responseObject)) success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
