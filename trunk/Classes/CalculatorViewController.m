//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Антон on 10.01.11.
//  Copyright 2011 Home Basic. All rights reserved.
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

- (CalculatorBrain *)brain {
	if (!brain) {
		brain = [[CalculatorBrain alloc] init];
	}
	
	return brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
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

- (IBAction)backspacePressed:(UIButton *)sender {
	NSUInteger operandLength = [display.text length];
	
	NSString *result;
	if (operandLength > 1) {
		result = [display.text substringToIndex: operandLength - 1];
	} else {
		result = @"0";
	}
	
	display.text = result;
}

- (void)showDisplayText:(double)value andOperation:(NSString *)operation {
	if ([CalculatorBrain variablesInExpression:brain.internalExpression].count > 0) {
		display.text = [CalculatorBrain descriptionOfExpression:brain.internalExpression];
	} else {
		display.text = [NSString stringWithFormat:@"%g", value];

		if ([@"/" isEqual:operation] ||
			[@"*" isEqual:operation] ||
			[@"-" isEqual:operation] ||
			[@"+" isEqual:operation]) {
			curOperation.text = [display.text stringByAppendingString:operation];
		} else {
			curOperation.text = @"";
		}
	}
}

- (IBAction)operationPressed:(UIButton *)sender {
	NSString *operation = sender.titleLabel.text;
	
	if (userIsInTheMiddleOfTypingANumber) {
		double curDisplayValue = [display.text doubleValue];
		self.brain.operand = curDisplayValue;
		
		if (![@"-/+" isEqual:operation]) {
			userIsInTheMiddleOfTypingANumber = NO;
		}
	}

	warning.text = self.brain.warningOperation;

	if ([@"M" isEqual:operation]) {
		memory.text = display.text;
	} else if ([@"M+" isEqual:operation] || [@"MC" isEqual:operation]) {
		memory.text = [NSString stringWithFormat:@"%g", self.brain.memoryValue];
	}
	
	double result = [self.brain performOperation:operation];
	[self showDisplayText:result andOperation:operation];
	
	NSRange displayPointRange = [display.text rangeOfString:@"."];
	thePointHasBeenSet = displayPointRange.length > 0;
}

- (IBAction)variablePressed:(UIButton *)sender {
	[self.brain setVariableAsOperand:sender.titleLabel.text];
	userIsInTheMiddleOfTypingANumber = NO;

	[self showDisplayText:0 andOperation:@""];
	warning.text = self.brain.warningOperation;
}

- (IBAction)evaluatePressed:(UIButton *)sender {
	NSDictionary *variables = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:2.0], @"%x",
							   [NSNumber numberWithDouble:4.0], @"%a",
							   [NSNumber numberWithDouble:3.0], @"%b",
							   nil];
	double result = [CalculatorBrain evaluateExpression:brain.internalExpression usingVariableValues:variables];
	
	display.text =[NSString stringWithFormat:@"%g", result];
}

- (IBAction)radianSwitched:(UISwitch *)sender {
	self.brain.isItRadians = sender.on;
}

- (void)dealloc {
	[brain release];
	[super dealloc];
}

@end
