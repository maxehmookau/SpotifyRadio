//
//  Playlist.h
//  SpotifyRadio
//
//  Created by Max Woolf on 27/01/2013.
//  Copyright (c) 2013 Max Woolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Playlist : NSObject <NSURLConnectionDataDelegate>
{
    NSString *seedArtist;
    
    // Just an array of strings containing Spotify track IDs
    NSArray *playlist;
    NSURLConnection *echonestConnection;
    NSMutableData *scratchData;
}

- (id)initWithArtist:(NSString *)anArtist;
- (void)startConnection;

@property (assign) NSArray *playlist;
@end
