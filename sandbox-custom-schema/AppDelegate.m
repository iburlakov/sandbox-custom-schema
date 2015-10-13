//
//  AppDelegate.m
//  sandbox-custom-schema
//
//  Created by Ivan Burlakov on 13/10/15.
//  Copyright © 2015 Ivan Burlakov. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

-(void)applicationWillFinishLaunching:(NSNotification *)notification {
    // subscribe
    [[NSAppleEventManager sharedAppleEventManager] setEventHandler:self
                                                       andSelector:@selector(handleGetURLEvent:withReplyEvent:)
                                                     forEventClass:kInternetEventClass
                                                        andEventID:kAEGetURL];
    isSubscribed = true;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // show schemas in window's title
    NSArray *urlTypes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
    NSArray *schemas = [[urlTypes firstObject] objectForKey:@"CFBundleURLSchemes"];
    NSString *schemasStr = [schemas componentsJoinedByString:@", "];
    
    if (isSubscribed) {
        self.window.title = [NSString stringWithFormat:@"%@ (%@)", self.window.title, schemasStr];

        NSRange r = NSMakeRange(self.logTextView.string.length, 0);
        [self.logTextView insertText:[NSString stringWithFormat:@"Subscribed to handle schemas: %@", schemasStr] replacementRange:r];
    } else {
        self.window.title = [NSString stringWithFormat:@"%@ (%@)", self.window.title, @"not subscribed"];
    }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    [[NSAppleEventManager sharedAppleEventManager] removeEventHandlerForEventClass:kInternetEventClass
                                                                        andEventID:kAEGetURL];
}

- (void)handleGetURLEvent:(NSAppleEventDescriptor *)event
           withReplyEvent:(NSAppleEventDescriptor *)replyEvent {
    NSString* url = [[event paramDescriptorForKeyword:keyDirectObject]
                     stringValue];
    
    NSRange r = NSMakeRange(self.logTextView.string.length, 0);
    [self.logTextView insertText:[NSString stringWithFormat:@"\n%@", url] replacementRange:r];
}

@end
