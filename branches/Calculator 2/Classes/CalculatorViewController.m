//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Антон on 10.01.11.
//  Copyright 2011 Штрих-М. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController()
@property (nonatomic, assign, readonly) CalculatorBrain *brain;
@property (nonatomic) BOOL userIsInTheMiddleOfTypingANumber;
@property (nonatomic) BOOL thePointHasBeenSet;
@end

@implementation CalculatorViewController

@synthesize brain;
@synthesize userIsInTheMiddleOfTypingANumber;
@synthesize thePointHasBeenSet;

- (CalculatorBrain *)brain
{
	if (!brain) {
		brain = [[CalculatorBrain alloc] init];
	}
	
	return brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
	NSString *digit = [sender titleLabel].text;
	
	if ([@"." isEqual:digit]) {
		if (thePointHasBeenSet) {
			return;
		} else {
			thePointHasBeenSet = YES;
		}
	}

	if (userIsInTheMiddleOfTypingANumber) {
		if ([@"0" isEqual:display.text]) {
			display.text = digit;
		} else {
			display.text = [display.text stringByAppendingString:digit];
		}
	} else {
		display.text = digit;
		userIsInTheMiddleOfTypingANumber = YES;
	}
}

- (IBAction)backspacePressed:(UIButton *)sender
{
	NSUInteger operandLength = [display.text length];
	
	NSString *result;
	if (operandLength > 1) {
		result = [display.text substringToIndex: operandLength - 1];
	} else {
		result = @"0";
	}
	
	display.text = result;
}

- (IBAction)operationPressed:(UIButton *)sender
{
	NSString *operation = sender.titleLabel.text;
	
	if (userIsInTheMiddleOfTypingANumber) {
		double curDisplayValue = [display.text doubleValue];
		self.brain.operand = curDisplayValue;
		
		if (![@"-/+" isEqual:operation]) {
			userIsInTheMiddleOfTypingANumber = NO;
		}
	}
	
	double result = [self.brain performOperation:operation];
	display.text =[NSString stringWithFormat:@"%g", result];
	warning.text = self.brain.warningOperation;

	if ([@"M" isEqual:operation]) {
		memory.text = display.text;
	} else if ([@"M+" isEqual:operation] || [@"MC" isEqual:operation]) {
		memory.text = [NSString stringWithFormat:@"%g", self.brain.memoryValue];
	}
	
	NSRange displayPointRange = [display.text rangeOfString:@"."];
	thePointHasBeenSet = displayPointRange.length > 0;
	
	if ([@"/" isEqual:operation] ||
		[@"*" isEqual:operation] ||
		[@"-" isEqual:operation] ||
		[@"+" isEqual:operation]) {
		curOperation.text = [display.text stringByAppendingString:operation];
	} else {
		curOperation.text = @"";
	}
}

- (IBAction)variablePressed:(UIButton *)sender
{
	[self.brain setVariableAsOperand:sender.titleLabel.text];
}

- (IBAction)evaluatePressed:(UIButton *)sender
{
}

- (IBAction)radianSwitched:(UISwitch *)sender
{
	self.brain.isItRadians = sender.on;
}

- (IBAction)evaluateTestPressed:(UIButton *)sender
{
}

- (void)dealloc
{
	[brain release];
	[super dealloc];
}

@end
