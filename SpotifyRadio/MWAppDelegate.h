//
//  MWAppDelegate.h
//  SpotifyRadio
//
//  Created by Max Woolf on 27/01/2013.
//  Copyright (c) 2013 Max Woolf. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Playlist.h"
#import "CocoaLibSpotify/CocoaLibSpotify.h"

@interface MWAppDelegate : NSObject <NSApplicationDelegate, SPSessionDelegate, SPSessionPlaybackDelegate, NSAlertDelegate, PlaylistDelegate> {
    SPSession *_mainSession;
    IBOutlet NSTextField *usernameInput;
    IBOutlet NSTextField *passwordInput;
    IBOutlet NSProgressIndicator *progressIndicator;
    IBOutlet NSButton *loginButton;
    
    IBOutlet NSTextField *getStartedLabel;
    IBOutlet NSTextField *artistInput;
    IBOutlet NSButton *letsGoButton;
    
    IBOutlet NSButton *nextTrackButton;
    IBOutlet NSButton *prevTrackButton;
    
    IBOutlet NSImageView *albumArt;
    IBOutlet NSTextField *artistLabel;
    IBOutlet NSTextField *titleLabel;

    Playlist *_sharedPlaylist;
    
    SPPlaybackManager *_manager;
    
    int currentTrack;
}

- (IBAction)didPressLoginButton:(id)sender;
- (IBAction)didPressSearchButton:(id)sender;

- (IBAction)didPressPrevTrack:(id)sender;
- (IBAction)didPressNextTrack:(id)sender;

- (void)alertDidEnd:(NSAlert *)alert returnCode:(NSInteger)returnCode;

- (void)hideAllLoginElements;
- (void)showAllLoginElements;

- (void)showArtistInputElements;
- (void)hideArtistInputElements;

- (void)hideTrackControls;
- (void)showTrackControls;

- (void)updateAlbumCover;

@property (assign) IBOutlet NSWindow *window;

@end
