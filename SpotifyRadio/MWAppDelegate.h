//
//  MWAppDelegate.h
//  SpotifyRadio
//
//  Created by Max Woolf on 27/01/2013.
//  Copyright (c) 2013 Max Woolf. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CocoaLibSpotify/CocoaLibSpotify.h"

@interface MWAppDelegate : NSObject <NSApplicationDelegate, SPSessionDelegate, SPSessionPlaybackDelegate, NSAlertDelegate> {
    SPSession *_mainSession;
    IBOutlet NSTextField *usernameInput;
    IBOutlet NSTextField *passwordInput;
    IBOutlet NSProgressIndicator *progressIndicator;
    IBOutlet NSButton *loginButton;
    
    IBOutlet NSTextField *getStartedLabel;
    IBOutlet NSTextField *artistInput;
    IBOutlet NSButton *letsGoButton;
}

- (IBAction)didPressLoginButton:(id)sender;
- (void)alertDidEnd:(NSAlert *)alert returnCode:(NSInteger)returnCode;

- (void)hideAllLoginElements;
- (void)showAllLoginElements;

- (void)showArtistInputElements;

@property (assign) IBOutlet NSWindow *window;

@end
