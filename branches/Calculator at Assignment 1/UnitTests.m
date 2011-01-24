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
	
	brain.operand = [@"10" doubleValue];
	[brain performOperation:@"+"];
	brain.operand = [@"5" doubleValue];
	double result = [brain performOperation:@"="];
	double expected = 15.0;
	
	STAssertEquals(expected, result, @"Error summ double value from '10' and from '5' must be %g, instead %g", expected, result);
	
	[brain release];
}

@end
