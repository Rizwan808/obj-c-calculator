//
//  UnitTests.m
//  Calculator
//
//  Created by Антон on 24.01.11.
//  Copyright 2011 Home Basic. All rights reserved.
//

#import "UnitTests.h"

@implementation UnitTests

- (void) testSumm10and5 {
	CalculatorBrain *brain = [[CalculatorBrain alloc] init];
	
	brain.operand = [@"10.0" doubleValue];
	[brain performOperation:@"+"];
	brain.operand = [@"5" doubleValue];
	double result = [brain performOperation:@"="];
	double expected = 15.0;
	
	[brain release];
	
	STAssertEquals(expected, result, @"Error summ double value from '10' and from '5' must be %g, instead %g",
				   expected, result);
}

- (void) testEvaluateExpressionSumm11and7 {
	CalculatorBrain *brain = [[CalculatorBrain alloc] init];
	
	brain.operand = [@"11" doubleValue];
	[brain performOperation:@"+"];
	brain.operand = [@"7.0" doubleValue];
	[brain performOperation:@"="];
	
	NSDictionary *variables = [[NSDictionary alloc] init];
	
	double result = [CalculatorBrain evaluateExpression:brain.internalExpression usingVariableValues:variables];
	double expected = 18.0;
	
	[variables release];
	[brain release];
	
	STAssertEquals(expected, result, @"Error summ double value from '11' and from '7' must be %g, instead %g",
				   expected, result);
}

@end
