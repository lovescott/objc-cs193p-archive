//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Scott Love on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject



- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void)clearStack:(NSMutableArray *)stack;

@property (readonly) id program;

+ (double)runProgram:(id)program;
+(NSString *)descriptionOfProgram:(id)program;

@end
