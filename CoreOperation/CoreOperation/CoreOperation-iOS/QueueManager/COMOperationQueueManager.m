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
    
    [operationQueue addOperation:operation];
}

@end
