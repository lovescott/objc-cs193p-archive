//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Scott Love on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"
@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;

@end

@implementation CalculatorBrain
@synthesize programStack = _programStack;
@synthesize varibleOnTheStack = _varibleOnTheStack;
@synthesize testVariableValues = _testVariableValues;

- (NSMutableArray *)programStack
{
    if (_programStack == nil) _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}

- (void)pushOperand:(double)operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
    
}
- (void)pushVariable:(NSString *)variableName
{
    [self.programStack addObject:variableName];
}
- (double)performOperation:(NSString *)operation
{
    [self.programStack addObject:operation];
    if (!self.varibleOnTheStack) 
    {
        return [CalculatorBrain runProgram:self.program];
    }
    return [CalculatorBrain runProgram:self.program usingVariableValues:self.testVariableValues];
}
-(id)program
{
    return [self.programStack copy];
}

+ (NSString *)descriptionOfProgram:(id)program
{
    return @"Implement this in Assigment 2";
    
}
+ (double)runProgram:(id)program
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]])
    {
        stack = [program mutableCopy];
    }
    return [self popOperandOffStack:stack];
}
+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues
{
    NSSet* set = [self variablesUsedInProgram:program];
    double num = 4;
    id test = set;
    //return [self popOperandOffStack:program];
    return num;
}
+ (NSSet *)variablesUsedInProgram:(id)program
{
    NSMutableSet *set;
    for (NSString *v in program) 
    {
        if ([v isKindOfClass:[NSString class]] && ([v isEqualToString:@"+"] || [v isEqualToString:@"-"] || [v isEqualToString:@"/"] || [v isEqualToString:@"*"] || [v isEqualToString:@"sin"] || [v isEqualToString:@"cos"] || [v isEqualToString:@"sqrt"] || [v isEqualToString:@"π"] || [v isEqualToString:@"C"])) 
        {
            [set addObject:v];
        }
    }
    if (set == nil) {
        return nil;
    }
    return [set copy];
}
+ (double)popOperandOffStack:(NSMutableArray *)stack
{
    double result = 0;
    
    id topofStack = [stack lastObject];
    if (topofStack) [stack removeLastObject];
    
    if ([topofStack isKindOfClass:[NSNumber class]]) 
    {
        result = [topofStack doubleValue];
    }
    else if ([topofStack isKindOfClass:[NSString class]]) 
    {
        NSString *operation = topofStack;
        if ([operation isEqualToString:@"+"])
        {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        }
        else if ([@"*" isEqualToString:operation]) 
        {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        }
        else if ([operation isEqualToString:@"-"]) 
        {
            double subtranhend = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] - subtranhend;
        }
        else if ([operation isEqualToString:@"/"]) 
        {
            double divisor = [self popOperandOffStack:stack];
            double dividend = [self popOperandOffStack:stack];
            if (divisor)
            {
                result = dividend  / divisor;
            }
            else {
                result = 0;   
            }
        }
        else if ([operation isEqualToString:@"sin"]) 
        {
            result = sin([self popOperandOffStack:stack] * M_PI / 180);
        }
        else if ([operation isEqualToString:@"cos"]) 
        {
            result = cos([self popOperandOffStack:stack] * M_PI / 180);
        }
        else if([operation isEqualToString:@"sqrt"])
        {
            double operand = [self popOperandOffStack:stack];
            if (operand >= 0) 
            {
                result = sqrt(operand);
            }
            else {
                result = 0;
            }
        }
        else if ([operation isEqualToString:@"π"]) 
        {
            result = M_PI;
        }
        else if ([operation isEqualToString:@"C"]) {
            result = 0;
            [stack removeAllObjects];
        }

    }
    
    return result;
}



@end
