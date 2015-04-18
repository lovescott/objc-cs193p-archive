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
- (void)pushVariable:(NSString *)variableName;

@property (nonatomic, readonly) id program;
@property (nonatomic) BOOL varibleOnTheStack;
@property (nonatomic, strong)  NSDictionary *testVariableValues;


+ (double)runProgram:(id)program;
+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues;
+(NSString *)descriptionOfProgram:(id)program;


@end
