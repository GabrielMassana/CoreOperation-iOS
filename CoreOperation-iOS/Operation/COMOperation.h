//
//  COMOperation.h
//  CoreOperation
//
//  Created by GabrielMassana on 18/11/2015.
//  Copyright © 2015 Gabriel Massana. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^COMOperationOnSuccess)(id result);
typedef void (^COMOperationOnFailure)(NSError *error);
typedef void (^COMOperationOnCompletion)(id result);

/**
 Subclass of NSOperation.
 */
@interface COMOperation : NSOperation

/**
 Operation identifier.
 */
@property (atomic, copy) NSString *identifier;

/**
 This is the identifier of the operation queue you would like the
 operation to be run on.
 */
@property (atomic, copy) NSString *operationQueueIdentifier;

/**
 Callback called when the operation completes succesfully.
 */
@property (nonatomic, copy) COMOperationOnSuccess onSuccess;

/**
 Callback called when the operation fails.
 */
@property (nonatomic, copy) COMOperationOnFailure onFailure;

/**
 Callback called when the operation completes.
 
 The completion block is used instead of the success/failure blocks not alongside.
 */
@property (nonatomic, copy) COMOperationOnCompletion onCompletion;

/**
 The result of the operation.
 */
@property (nonatomic, strong, readonly) id result;

/**
 The error of the operation.
 */
@property (nonatomic, strong, readonly) NSError *error;

/**
 Finishes the execution of the operation.
 
 @note - This shouldn't be called externally as this is used internally by subclasses.
 To cancel an operation use cancel instead.
 */
- (void)finish;

/**
 Finishes the execution of the operation and calls the onSuccess callback.
 
 @note - This shouldn't be called externally as this is used internally by subclasses.
 To cancel an operation use cancel instead.
 */
- (void)didSucceedWithResult:(id)result;

/**
 Finishes the execution of the operation and calls the onCompletion callback.
 
 @note - This shouldn't be called externally as this is used internally by subclasses.
 To cancel an operation use cancel instead.
 */
- (void)didCompleteWithResult:(id)result;

/**
 Finishes the execution of the operation and calls the onFailure callback.
 
 @note - This shouldn't be called externally as this is used internally by subclasses.
 To cancel an operation use cancel instead.
 */
- (void)didFailWithError:(NSError *)error;

@end
