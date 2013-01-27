//
//  MWAppDelegate.m
//  SpotifyRadio
//
//  Created by Max Woolf on 27/01/2013.
//  Copyright (c) 2013 Max Woolf. All rights reserved.
//

#import "MWAppDelegate.h"
#include "appkey.h"

@implementation MWAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSError *mainError = nil;
    
    if([SPSession initializeSharedSessionWithApplicationKey:[NSData dataWithBytes:&g_appkey length:g_appkey_size] userAgent:@"MaxWoolf.SpotifyRadio" loadingPolicy:SPAsyncLoadingManual error:&mainError])
    {
        NSLog(@"Created fine");
    }else{
        NSLog(@"Everything is not ok");
    }
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

- (void)session:(SPSession *)aSession didGenerateLoginCredentials:(NSString *)credential forUserName:(NSString *)userName
{
    NSLog(@"CREDENTIALS: %@", credential);
}

- (void)sessionDidLoginSuccessfully:(SPSession *)aSession
{
    [progressIndicator setHidden:YES];
    [progressIndicator stopAnimation:self];
    [usernameInput setHidden:YES];
    [passwordInput setHidden:YES];
    [loginButton setHidden:YES];
    NSLog(@"Logged in successfully");
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
