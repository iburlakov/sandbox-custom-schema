//
//  AppDelegate.h
//  sandbox-custom-schema
//
//  Created by Ivan Burlakov on 13/10/15.
//  Copyright © 2015 Ivan Burlakov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    BOOL isSubscribed;
}

@property (unsafe_unretained) IBOutlet NSTextView *logTextView;

@end

