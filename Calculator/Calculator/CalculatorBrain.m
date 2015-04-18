//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Scott Love on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"
@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain
@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack
{
    if (_operandStack == nil) _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
}

- (void)pushOperand:(double)operand
{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
    
}
- (double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) {
        [self.operandStack removeLastObject];
    }
    return [operandObject doubleValue];
}

- (void)clearStack:(NSMutableArray *)stack
{
    stack = nil;
}

- (double)performOperation:(NSString *)operation
{
    double result = 0;
    
    if ([operation isEqualToString:@"+"])
    {
        result = [self popOperand] + [self popOperand];
    }
    else if ([@"*" isEqualToString:operation]) 
    {
        result = [self popOperand] * [self popOperand];
    }
    else if ([operation isEqualToString:@"-"]) 
    {
        double subtranhend = [self popOperand];
        result = [self popOperand] - subtranhend;
    }
    else if ([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        double dividend = [self popOperand];
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
        result = sin([self popOperand] * M_PI / 180);
    }
    else if ([operation isEqualToString:@"cos"]) 
    {
        result = cos([self popOperand] * M_PI / 180);
    }
    else if([operation isEqualToString:@"sqrt"])
    {
        double operand = [self popOperand];
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
        [self.operandStack removeAllObjects];
        
    }
    
    [self pushOperand:result];
    return result;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"stack = %@", self.operandStack];
}


@end
