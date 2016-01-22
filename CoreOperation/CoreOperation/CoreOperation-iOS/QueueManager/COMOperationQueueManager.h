//
//  COMOperationQueueManager.h
//  CoreOperation
//
//  Created by GabrielMassana on 18/11/2015.
//  Copyright © 2015 Gabriel Massana. All rights reserved.
//

#import <Foundation/Foundation.h>

@class COMOperation;

/**
 This class coordinates the operations.
 */
@interface COMOperationQueueManager : NSObject

/*
 Returns the global COMOperationQueueManager instance.
 
 @return COMOperationQueueManager instance.
 */
+ (instancetype)sharedInstance;

/**
 Registers an operation queue.
 
 @param operationQueue - the new operation queue to be registered.
 @param operationQueueIdentifier - the new operation queue identifier.
 */
- (void)registerOperationQueue:(NSOperationQueue *)operationQueue
      operationQueueIdentifier:(NSString *)operationQueueIdentifier;

/**
 Add an operation to an operation queue.
 
 @param operation - the new operation to be added.
 */
- (void)addOperation:(COMOperation *)operation;

@end
