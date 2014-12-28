//
//  ViewController.m
//  itunesTopSongs
//
//  Created by Mohammed ElGohary on 12/26/14.
//  Copyright (c) 2014 Mohammed ElGohary. All rights reserved.
//

#import "ViewController.h"
#import "APIClient.h"
#import "coreDataManager.h"
#import "Song.h"
#import "CoreData+MagicalRecord.h"
#import "SongTableViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <FSImageViewer/FSImageViewerViewController.h>
#import <FSImageViewer/FSBasicImage.h>
#import <FSImageViewer/FSBasicImageSource.h>


@interface ViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *songsArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.tableView];

    
//    [self getTopSongs];
    [self reloadTableDataFromLocal];

}

- (void)getTopSongs{
    [[APIClient sharedClient]getTopSongs:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        [[coreDataManager sharedManager]saveSongsToLocalData:[[responseObject objectForKey:@"feed"] objectForKey:@"entry"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadTableDataFromLocal];
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *tableViewCellIdentifier = @"IDENTIFIER";
    SongTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    if (cell == nil) {
        cell = [[SongTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    }
    Song *song = [self.songsArray objectAtIndex:indexPath.row];
    cell.albumTitle.text = song.title;
    cell.songPrice.text = [NSString stringWithFormat:@"%@ $", song.price ];
    [cell.albumImage setImageWithURL:[NSURL URLWithString:song.image]];
//    [cell.albumImage setupImageViewerWithDatasource:self initialIndex:indexPath.row onOpen:^{
//        NSLog(@"OPEN!");
//    } onClose:^{
//        NSLog(@"CLOSE!");
//    }];

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.songsArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Song *song = [self.songsArray objectAtIndex:indexPath.row];
    FSBasicImage *firstPhoto = [[FSBasicImage alloc] initWithImageURL:[NSURL URLWithString:song.image] name:song.title];
    FSBasicImageSource *photoSource = [[FSBasicImageSource alloc] initWithImages:@[firstPhoto]];
    FSImageViewerViewController *imageViewController = [[FSImageViewerViewController alloc] initWithImageSource:photoSource];
    imageViewController.songURL = song.link;

    [self.navigationController pushViewController:imageViewController animated:YES];
}
- (void)reloadTableDataFromLocal{
    self.songsArray = [[NSArray alloc]initWithArray:[Song MR_findAll]];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (NSInteger) numberImagesForImageViewer:(MHFacebookImageViewer*) imageViewer{
//    return 1;
//}
//- (NSURL*) imageURLAtIndex:(NSInteger)index imageViewer:(MHFacebookImageViewer*) imageViewer{
//    Song *song = [self.songsArray objectAtIndex:index];
//    NSLog(@"%@",song.image);
//    return [NSURL URLWithString:song.image];
//}
//- (UIImage*) imageDefaultAtIndex:(NSInteger)index imageViewer:(MHFacebookImageViewer*) imageViewer{
//    return nil;
//}

@end
