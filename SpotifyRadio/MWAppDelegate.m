//
//  MWAppDelegate.m
//  SpotifyRadio
//
//  Created by Max Woolf on 27/01/2013.
//  Copyright (c) 2013 Max Woolf. All rights reserved.
//

#import "MWAppDelegate.h"
#include "appkey.h"
#import "Playlist.h"

@implementation MWAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSError *mainError = nil;
    [self hideTrackControls];
    if([SPSession initializeSharedSessionWithApplicationKey:[NSData dataWithBytes:&g_appkey length:g_appkey_size] userAgent:@"MaxWoolf.SpotifyRadio" loadingPolicy:SPAsyncLoadingManual error:&mainError])
    {
        NSLog(@"Created fine");
    }else{
        NSLog(@"Everything is not ok");
    }
}


- (void)didPressSearchButton:(id)sender
{
    [progressIndicator setHidden:NO];
    [progressIndicator startAnimation:self];
    _sharedPlaylist = [[Playlist alloc] initWithArtist:[artistInput stringValue] delegate:self];
    [_sharedPlaylist startConnection];
    
}

- (void)didFinishGettingPlaylist
{
    currentTrack = 0;
    [progressIndicator setHidden:YES];
    [progressIndicator stopAnimation:self];
    [self showTrackControls];
    NSLog(@"Got playlist");
    NSLog(@"%@", [_sharedPlaylist playlist]);
    [self hideArtistInputElements];
    [albumArt setHidden:NO];
    
    _manager = [[SPPlaybackManager alloc] initWithPlaybackSession:[SPSession sharedSession]];
    [_manager playTrack:[[_sharedPlaylist playlist] objectAtIndex:currentTrack] callback:nil];
    [self updateAlbumCover];
    
}

- (void)showTrackControls
{
    [nextTrackButton setHidden:NO];
    [prevTrackButton setHidden:NO];
    [artistLabel setHidden:NO];
    [titleLabel setHidden:NO];
}

- (void)hideTrackControls
{
    [nextTrackButton setHidden:YES];
    [nextTrackButton setHidden:YES];
    [artistLabel setHidden:YES];
    [titleLabel setHidden:YES];
}

- (void)updateAlbumCover
{
    SPAlbum *currentAlbum = [(SPTrack *)[[_sharedPlaylist playlist] objectAtIndex:currentTrack]album];
    [SPAsyncLoading waitUntilLoaded:[currentAlbum cover] timeout:kSPAsyncLoadingDefaultTimeout then:^(NSArray *loadedItems, NSArray *notLoadedItems) {
        [albumArt setImage:[[currentAlbum cover] image]];
    }];
    
    SPTrack *track = (SPTrack *)[[_sharedPlaylist playlist] objectAtIndex:currentTrack];
    [titleLabel setStringValue:[track name]];
    [artistLabel setStringValue:[(SPArtist *)[[track artists] objectAtIndex:0] name]];
}

- (void)didPressNextTrack:(id)sender
{
    currentTrack += 1;
    [self updateAlbumCover];
    [_manager playTrack:[[_sharedPlaylist playlist] objectAtIndex:currentTrack+1] callback:nil];
}

- (void)didPressPrevTrack:(id)sender
{
    currentTrack -= 1;
    [self updateAlbumCover];
    [_manager playTrack:[[_sharedPlaylist playlist] objectAtIndex:currentTrack-1] callback:nil];
}

- (void)didPressLoginButton:(id)sender
{
    [progressIndicator setHidden:NO];
    [progressIndicator startAnimation:self];
    NSString *username = [usernameInput stringValue];
    NSString *password = [passwordInput stringValue];
    
    // Initialise Spotify Session
    
    [[SPSession sharedSession] setMaximumCacheSizeMB:100];
    [[SPSession sharedSession] setDelegate:self];
    [[SPSession sharedSession] attemptLoginWithUserName:username password:password];
    
    
    [[SPSession sharedSession] setPlaybackDelegate:self];

}

- (void)hideAllLoginElements
{
    [progressIndicator setHidden:YES];
    [progressIndicator stopAnimation:self];
    [usernameInput setHidden:YES];
    [passwordInput setHidden:YES];
    [loginButton setHidden:YES];
}

- (void)showAllLoginElements
{
    [progressIndicator setHidden:NO];
    [usernameInput setHidden:NO];
    [passwordInput setHidden:NO];
    [loginButton setHidden:NO];
}

- (void)showArtistInputElements
{
    [getStartedLabel setHidden:NO];
    [artistInput setHidden:NO];
    [letsGoButton setHidden:NO];
}

- (void)hideArtistInputElements
{
    [getStartedLabel setHidden:YES];
    [artistInput setHidden:YES];
    [letsGoButton setHidden:YES];
}

- (void)session:(SPSession *)aSession didGenerateLoginCredentials:(NSString *)credential forUserName:(NSString *)userName
{
    NSLog(@"CREDENTIALS: %@", credential);
    [[NSUserDefaults standardUserDefaults] setValue:credential forKey:@"credential"];
    [[NSUserDefaults standardUserDefaults] setValue:[usernameInput stringValue] forKey:@"username"];
}

- (void)sessionDidLoginSuccessfully:(SPSession *)aSession
{
    
    [self hideAllLoginElements];
    NSLog(@"Logged in successfully");
    [self showArtistInputElements];
}

- (void)session:(SPSession *)aSession didFailToLoginWithError:(NSError *)error
{
    [progressIndicator setHidden:YES];
    [progressIndicator stopAnimation:self];
    NSLog(@"%@", [[error userInfo] description]);
    
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setDelegate:self];
    [alert setAlertStyle:NSWarningAlertStyle];
    [alert addButtonWithTitle:@"OK"];
    [alert setMessageText:@"Error"];
    [alert setInformativeText:[error localizedDescription]];
    [alert beginSheetModalForWindow:_window modalDelegate:self didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:) contextInfo:nil];
}

- (void)alertDidEnd:(NSAlert *)alert returnCode:(NSInteger)returnCode
        contextInfo:(void *)contextInfo
{
    
}

- (void)session:(SPSession *)aSession didEncounterNetworkError:(NSError *)error
{
    NSLog(@"%@", [error localizedDescription]);
}

@end
