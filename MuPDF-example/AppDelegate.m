//
//  AppDelegate.m
//  MuPDF-example
//
//  Created by Joseph Heenan on 05/07/2015.
//  Copyright (c) 2015 Artifex. All rights reserved.
//

#import "AppDelegate.h"

#import "MuDocRef.h"
#import "MuDocumentController.h"
#include "mupdf/fitz.h"
#include "common.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

enum
{
    ResourceCacheMaxSize = 128<<20	/**< use at most 128M for resource cache */
};

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    queue = dispatch_queue_create("com.artifex.mupdf.queue", NULL);

    screenScale = [[UIScreen mainScreen] scale];

    ctx = fz_new_context(NULL, NULL, ResourceCacheMaxSize);
    fz_register_document_handlers(ctx);

    NSString *file = [[NSBundle mainBundle] pathForResource:@"hello-world" ofType:@"pdf"];
    MuDocRef *doc;

    doc = [[MuDocRef alloc] initWithFilename:(char *)file.UTF8String];
    if (!doc) {
        NSLog(@"Cannot open document '%@'", file);
        return YES;
    }

    MuDocumentController *document = [[MuDocumentController alloc] initWithFilename:file path:(char *)file.UTF8String document: doc];

    UINavigationController *navigator = [[UINavigationController alloc] initWithRootViewController: document];
    [[navigator navigationBar] setTranslucent: YES];
    [[navigator toolbar] setTranslucent: YES];

    self.window.rootViewController = navigator;

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
