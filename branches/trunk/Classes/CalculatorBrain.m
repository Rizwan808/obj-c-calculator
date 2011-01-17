//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Антон on 11.01.11.
//  Copyright 2011 Штрих-М. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic) double waitingOperand;
@property (nonatomic, copy) NSString *waitingOperation;
@end

@implementation CalculatorBrain

@synthesize operand;
@synthesize memoryValue;
@synthesize waitingOperand;
@synthesize isItRadians;
@synthesize warningOperation;
@synthesize waitingOperation;

@synthesize expression;

- (void)performWaitingOperation
{
	if ([@"+" isEqual:waitingOperation]) {
		operand = waitingOperand + operand;
	} else if ([@"-" isEqual:waitingOperation]) {
		operand = waitingOperand - operand;
	} else if ([@"/" isEqual:waitingOperation]) {
		if (operand) {
			operand = waitingOperand / operand;
		} else {
			warningOperation = @"Can't divide by zero";
		}
	} else if ([@"*" isEqual:waitingOperation]) {
		operand = waitingOperand * operand;
	}
}

- (void)setVariableAsOperand:(NSString *)variableName
{
}

- (double)performOperation:(NSString *)operation
{
	warningOperation = @"";

	if ([@"sqrt" isEqual:operation]) {
		if (operand >= 0) {
			operand = sqrt(operand);
		} else {
			warningOperation = @"Can't sqrt from negative";
		}
	} else if ([@"1/x" isEqual:operation]) {
		if (operand) {
			operand = 1 / operand;
		} else {
			warningOperation = @"Can't divide by zero";
		}
	} else if ([@"-/+" isEqual:operation]) {
		if (operand) {
			operand = -1 * operand;
		}
	} else if ([@"C" isEqual:operation]) {
		operand = 0;
	} else if ([@"π" isEqual:operation]) {
		operand = M_PI;
	} else if ([@"sin" isEqual:operation]) {
		if (isItRadians) {
			operand = sin(operand);
		} else {
			operand = sin(operand * M_PI / 180);
		}
	} else if ([@"cos" isEqual:operation]) {
		if (isItRadians) {
			operand = cos(operand);
		} else {
			operand = cos(operand * M_PI / 180);
		}
	} else if ([@"M" isEqual:operation]) {
		memoryValue = operand;
	} else if ([@"MC" isEqual:operation]) {
		memoryValue = 0;
	} else if ([@"MR" isEqual:operation]) {
		operand = memoryValue;
	} else if ([@"M+" isEqual:operation]) {
		memoryValue = memoryValue + operand;
	} else {
		[self performWaitingOperation];
		waitingOperation = operation;
		waitingOperand = operand;
	}
	
	return operand;
}

@end
