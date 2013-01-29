//
//  Playlist.h
//  SpotifyRadio
//
//  Created by Max Woolf on 27/01/2013.
//  Copyright (c) 2013 Max Woolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Playlist;
@protocol PlaylistDelegate <NSObject>

- (void)didFinishGettingPlaylist;

@end

@interface Playlist : NSObject <NSURLConnectionDataDelegate>
{
    NSString *seedArtist;
    
    // Just an array of strings containing Spotify track IDs
    NSMutableArray *_playlist;
    NSMutableArray *_albumCovers;
    NSURLConnection *echonestConnection;
    NSMutableData *scratchData;
    
    id delegate;
}

- (id)initWithArtist:(NSString *)anArtist delegate:(id<PlaylistDelegate>)aDelegate;
- (void)startConnection;
- (void)processResults;

@property (nonatomic) NSMutableArray *playlist;
@property (nonatomic) NSMutableArray *albumCovers;
@property (nonatomic) id delegate;

@end
