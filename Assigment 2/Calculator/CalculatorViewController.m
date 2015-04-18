//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Scott Love on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"


@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringNumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController
@synthesize display = _display;
@synthesize userIsInTheMiddleOfEnteringNumber = _userIsInTheMiddleOfEnteringNumber;
@synthesize brain = _brain;
@synthesize tracker = _tracker;
@synthesize testVariableValues = _testVariableValues;


- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender 
{
    NSString *digit = [sender currentTitle];
    if (self.userIsInTheMiddleOfEnteringNumber)
    {
        self.display.text = [self.display.text stringByAppendingString:digit];
    }
    else 
    {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringNumber = YES;
    }
}

- (IBAction)operationPressed:(UIButton *)sender 
{
    if (self.userIsInTheMiddleOfEnteringNumber) {
        [self enterPressed];
    }
    [self trackChanges:sender.currentTitle];
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
    [self trackChanges:resultString];
    
}

- (IBAction)enterPressed 
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringNumber = NO;
    [self trackChanges:self.display.text];
    
}
- (IBAction)decimalPressed:(UIButton *)sender 
{
    NSString *decimal = [sender currentTitle];
    NSRange range = [self.display.text rangeOfString:@"."];
    if (self.userIsInTheMiddleOfEnteringNumber)
    {
        if (range.location == NSNotFound) 
        {
            self.display.text = [self.display.text stringByAppendingString:decimal];
        }
        return;
    }
    else 
    {
        self.display.text = @"0";
        self.display.text = [self.display.text stringByAppendingString:decimal];
        self.userIsInTheMiddleOfEnteringNumber = YES;
    }
}

-(void)trackChanges:(NSString *)track
{
    NSRange range = [track rangeOfString:@"C"];
    if (range.location != NSNotFound) 
    {
        self.tracker.text = @"";
    }
    self.tracker.text = [[self.tracker.text stringByAppendingString:track]stringByAppendingString:@" "];
    
}

- (IBAction)testPressed:(id)sender 
{
    NSNumber *x;
    NSNumber *a;
    NSNumber *b; 
    NSString *currentTest = [sender currentTitle];
    if ([currentTest isEqualToString:@"Test 1"]) 
    {
        x = [NSNumber numberWithDouble:4];
        a = [NSNumber numberWithDouble:5];
        b = [NSNumber numberWithDouble:9];
        
    }
    self.brain.testVariableValues = [NSDictionary dictionaryWithObjectsAndKeys:x,@"x",a,@"a",b,@"b", nil];
}

- (IBAction)variablePressed:(id)sender 
{
    NSString* var = [sender currentTitle];
    self.display.text = var;
    self.brain.varibleOnTheStack = YES;
    [self enterPressed];
}

@end
