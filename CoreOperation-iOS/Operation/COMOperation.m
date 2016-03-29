//
//  COMOperation.m
//  CoreOperation
//
//  Created by GabrielMassana on 18/11/2015.
//  Copyright © 2015 Gabriel Massana. All rights reserved.
//

#import "COMOperation.h"

@interface COMOperation ()

@property (atomic, assign, getter=isReady) BOOL ready;
@property (atomic, assign, getter=isExecuting) BOOL executing;
@property (atomic, assign, getter=isFinished) BOOL finished;

@property (nonatomic, strong, readwrite) id result;
@property (nonatomic, strong, readwrite) NSError *error;

@property (nonatomic, strong) NSOperationQueue *callbackQueue;

@end

@implementation COMOperation

@synthesize ready = _ready;
@synthesize executing = _executing;
@synthesize finished = _finished;

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.ready = YES;
        self.callbackQueue = [NSOperationQueue currentQueue];
    }
    
    return self;
}

#pragma mark - Name

- (NSString *)name
{
    return self.identifier;
}

#pragma mark - State

- (void)setReady:(BOOL)ready
{
    if (_ready != ready)
    {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isReady))];
        _ready = ready;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isReady))];
    }
}

- (BOOL)isReady
{
    return _ready;
}

- (void)setExecuting:(BOOL)executing
{
    if (_executing != executing)
    {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
        _executing = executing;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
    }
}

- (BOOL)isExecuting
{
    return _executing;
}

- (void)setFinished:(BOOL)finished
{
    if (_finished != finished)
    {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
        _finished = finished;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
    }
}

- (BOOL)isFinished
{
    return _finished;
}

- (BOOL)isAsynchronous
{
    return YES;
}

#pragma mark - Control

- (void)start
{
    if (!self.isExecuting)
    {
        self.ready = NO;
        self.executing = YES;
        self.finished = NO;
        
        NSLog(@"%@ - Operation will start.", self.name);
    }
}

- (void)finish
{
    if (self.executing)
    {
        NSLog(@"%@ - Operation did finish.", self.name);
        
        self.executing = NO;
        self.finished = YES;
    }
}

#pragma mark - Callbacks

- (void)didSucceedWithResult:(id)result
{
    self.result = result;
    
    [self finish];
    
    if (self.onSuccess)
    {
        [self.callbackQueue addOperationWithBlock:^
         {
             self.onSuccess(result);
         }];
    }
}

- (void)didCompleteWithResult:(id)result
{
    self.result = result;
    
    [self finish];
    
    if (self.onCompletion)
    {
        [self.callbackQueue addOperationWithBlock:^
         {
             self.onCompletion(result);
         }];
    }
}

- (void)didFailWithError:(NSError *)error
{
    self.error = error;
    
    [self finish];
    
    if (self.onFailure)
    {
        [self.callbackQueue addOperationWithBlock:^
         {
             self.onFailure(error);
         }];
    }
}

#pragma mark - Coalescing

- (BOOL)canCoalesceWithOperation:(COMOperation *)operation
{
    return [self.identifier isEqualToString:operation.identifier];
}

- (void)coalesceWithOperation:(COMOperation *)operation
{
    // Success coalescing
    void (^mySuccessBlock)(id result) = [_onSuccess copy];
    void (^theirSuccessBlock)(id result) = [operation->_onSuccess copy];
    
    self.onSuccess = ^(id result)
    {
        if (mySuccessBlock)
        {
            mySuccessBlock(result);
        }
        
        if (theirSuccessBlock)
        {
            theirSuccessBlock(result);
        }
    };
    
    // Failure coalescing
    void (^myFailureBlock)(NSError *error) = [_onFailure copy];
    void (^theirFailureBlock)(NSError *error) = [operation->_onFailure copy];
    
    self.onFailure = ^(NSError *error)
    {
        if (myFailureBlock)
        {
            myFailureBlock(error);
        }
        
        if (theirFailureBlock)
        {
            theirFailureBlock(error);
        }
    };
    
    // Completion coalescing
    void (^myCompletionBlock)(id result) = [_onCompletion copy];
    void (^theirCompletionBlock)(id result) = [operation->_onCompletion copy];
    
    self.onCompletion = ^(id result)
    {
        if (myCompletionBlock)
        {
            myCompletionBlock(result);
        }
        
        if (theirCompletionBlock)
        {
            theirCompletionBlock(result);
        }
    };
}

@end
