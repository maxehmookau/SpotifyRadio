//
//  Playlist.m
//  SpotifyRadio
//
//  Created by Max Woolf on 27/01/2013.
//  Copyright (c) 2013 Max Woolf. All rights reserved.
//

#import "Playlist.h"

@implementation Playlist

- (id)initWithArtist:(NSString *)anArtist
{
    seedArtist = anArtist;
    return [super init];
}

@end
