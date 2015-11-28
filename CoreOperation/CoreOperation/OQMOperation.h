//
//  OQMOperation.h
//  Hot
//
//  Created by GabrielMassana on 18/11/2015.
//  Copyright © 2015 Gabriel Massana. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^OQMOperationOnSuccessCallback)(id result);
typedef void (^OQMOperationOnFailureCallback)(NSError *error);
typedef void (^OQMOperationOnCompletionCallback)(id result);

@interface OQMOperation : NSOperation <NSCoding, NSCopying>

@property (atomic, copy) NSString *identifier;
@property (atomic, copy) NSString *operationQueueIdentifier;

@property (nonatomic, copy) OQMOperationOnSuccessCallback onSuccess;
@property (nonatomic, copy) OQMOperationOnFailureCallback onFailure;
@property (nonatomic, copy) OQMOperationOnCompletionCallback onCompletion;

@property (nonatomic, strong, readonly) id result;
@property (nonatomic, strong, readonly) NSError *error;
@property (nonatomic, strong, readonly) NSProgress *progress;


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
