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

- (void)startConnection
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://developer.echonest.com/api/v4/playlist/basic?api_key=FILDTEOIK2HBORODV&artist=%@&limit=true&format=json&results=100&bucket=id:spotify-WW&bucket=tracks&type=artist-radio", seedArtist]]];
    echonestConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    scratchData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [scratchData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"%@", [[NSString alloc] initWithData:scratchData encoding:NSUTF8StringEncoding]);
    NSLog(@"Finished connection");
}

@end
