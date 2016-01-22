//
//  AppDelegate.m
//  CoreOperation
//
//  Created by Gabriel Massana on 20/1/16.
//  Copyright © 2016 Gabriel Massana. All rights reserved.
//

#import "COMAppDelegate.h"

#import "CoreOperation.h"

@interface COMAppDelegate ()

@end

NSString *const kCOMLocalOperationQueueTypeIdentifier = @"kCOMLocalOperationQueueTypeIdentifier";

@implementation COMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self registerOperationQueues];
    
    return YES;
}

#pragma mark - OperationQueues

- (void)registerOperationQueues
{
    //Local Background
    NSOperationQueue *localOperationQueue = [[NSOperationQueue alloc] init];
    localOperationQueue.qualityOfService = NSQualityOfServiceBackground;
    localOperationQueue.maxConcurrentOperationCount = 1;
    
    [[COMOperationQueueManager sharedInstance] registerOperationQueue:localOperationQueue
                                             operationQueueIdentifier:kCOMLocalOperationQueueTypeIdentifier];
}

@end
