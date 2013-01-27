//
//  Playlist.h
//  SpotifyRadio
//
//  Created by Max Woolf on 27/01/2013.
//  Copyright (c) 2013 Max Woolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Playlist : NSObject
{
    NSString *seedArtist;
    NSDictionary *playlist;
}

- (id)initWithArtist:(NSString *)anArtist;

@property (assign) NSArray *playlist;
@end
