//
//  COMOperationQueueManager.h
//  Hot
//
//  Created by GabrielMassana on 18/11/2015.
//  Copyright © 2015 Gabriel Massana. All rights reserved.
//

#import <Foundation/Foundation.h>

@class COMOperation;

/**
 Identifier for the scheduler for generic network data operations.
 */
static NSString *const kHOTNetworkDataOperationQueueTypeIdentifier = @"kHOTNetworkDataOperationQueueTypeIdentifier";

@interface COMOperationQueueManager : NSObject

/*
 Returns the global COMOperationQueueManager instance.
 
 @return COMOperationQueueManager instance.
 */
+ (instancetype)sharedInstance;

- (void)registerOperationQueue:(NSOperationQueue *)operationQueue
      operationQueueIdentifier:(NSString *)operationQueueIdentifier;

- (void)addOperation:(COMOperation *)operation;


@end
