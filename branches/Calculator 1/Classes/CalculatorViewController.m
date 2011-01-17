//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Антон on 10.01.11.
//  Copyright 2011 Штрих-М. All rights reserved.
//

#import "CalculatorViewController.h"

@implementation CalculatorViewController

- (CalculatorBrain *)brain
{
	if (!brain) {
		brain = [[CalculatorBrain alloc] init];
	}
	
	return brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
	NSString *digit = [[sender titleLabel] text];
	
	if ([@"." isEqual:digit]) {
		if (thePointHasBeenSet) {
			return;
		} else {
			thePointHasBeenSet = YES;
		}
	}

	if (userIsInTheMiddleOfTypingANumber) {
		if ([@"0" isEqual:[display text]]) {
			[display setText:digit];
		} else {
			[display setText:[[display text] stringByAppendingString:digit]];
		}
	} else {
		[display setText:digit];
		userIsInTheMiddleOfTypingANumber = YES;
	}
}

- (IBAction)backspacePressed:(UIButton *)sender
{
	NSUInteger operandLength = [[display text] length];
	
	NSString *result;
	if (operandLength > 1) {
		result = [display.text substringToIndex: operandLength - 1];
	} else {
		result = @"0";
	}
	
	[display setText:result];
}

- (IBAction)operationPressed:(UIButton *)sender
{
	NSString *operation = [[sender titleLabel] text];
	
	if (userIsInTheMiddleOfTypingANumber && ![@"-/+" isEqual:operation]) {
		double curDisplayValue = [[display text] doubleValue];
		[[self brain] setOperand:curDisplayValue];
		
		userIsInTheMiddleOfTypingANumber = NO;
	}
	
	double result = [[self brain] performOperation:operation];
	[display setText:[NSString stringWithFormat:@"%g", result]];
	[warning setText:[[self brain] warningOperation]];

	if ([@"M" isEqual:operation]) {
		[memory setText:[display text]];
	} else if ([@"M+" isEqual:operation] || [@"MC" isEqual:operation]) {
		[memory setText:[NSString stringWithFormat:@"%g", [brain memoryValue]]];
	}
	
	NSRange displayPointRange = [display.text rangeOfString:@"."];
	thePointHasBeenSet = displayPointRange.length > 0;
	
	if ([@"/" isEqual:operation] ||
		[@"*" isEqual:operation] ||
		[@"-" isEqual:operation] ||
		[@"+" isEqual:operation]) {
		[curOperation setText:[[display text] stringByAppendingString:operation]];
	} else {
		[curOperation setText:@""];
	}

}

- (IBAction)radianSwitched:(UISwitch *)sender
{
	[self brain].isItRadians = sender.on;
}

@end
