//
//  COMOperationQueueManager.m
//  CoreOperation
//
//  Created by GabrielMassana on 18/11/2015.
//  Copyright © 2015 Gabriel Massana. All rights reserved.
//

#import "COMOperationQueueManager.h"

#import "COMOperation.h"

@interface COMOperationQueueManager ()

@property (nonatomic, strong) NSMutableDictionary *operationQueuesDictionary;

@end

@implementation COMOperationQueueManager

#pragma mark - SharedInstance

+ (instancetype)sharedInstance
{
    static COMOperationQueueManager *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      sharedInstance = [[COMOperationQueueManager alloc] init];
                  });
    
    return sharedInstance;
}

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.operationQueuesDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

#pragma mark - Register

- (void)registerOperationQueue:(NSOperationQueue *)operationQueue
      operationQueueIdentifier:(NSString *)operationQueueIdentifier
{
    [self.operationQueuesDictionary setObject:operationQueue
                                       forKey:operationQueueIdentifier];
}

#pragma mark - AddOperation

- (void)addOperation:(COMOperation *)operation
{
    NSOperationQueue *operationQueue = self.operationQueuesDictionary[operation.operationQueueIdentifier];
    
    COMOperation *coalescedOperation = [self coalesceOperation:operation
                                                     scheduler:operationQueue];
    
    // If operation was not coalesced, then adde it to the queue.
    // If was coalesced, then it was already in the queue.
    if (!coalescedOperation)
    {
        [operationQueue addOperation:operation];
    }
}

- (COMOperation *)coalesceOperation:(COMOperation *)newOperation
                          scheduler:(NSOperationQueue *)operationQueue
{
    NSArray *operations = [operationQueue operations];
    
    for (COMOperation *operation in operations)
    {
        BOOL canAskToCoalesce = [operation isKindOfClass:[COMOperation class]];
        
        if (canAskToCoalesce &&
            [operation canCoalesceWithOperation:newOperation])
        {
            [operation coalesceWithOperation:newOperation];
            
            return operation;
        }
    }

    return nil;
}

@end
