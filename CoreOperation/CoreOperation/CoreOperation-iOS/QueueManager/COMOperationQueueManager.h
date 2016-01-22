//
//  COMOperationQueueManager.h
//  CoreOperation
//
//  Created by GabrielMassana on 18/11/2015.
//  Copyright © 2015 Gabriel Massana. All rights reserved.
//

#import <Foundation/Foundation.h>

@class COMOperation;

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
