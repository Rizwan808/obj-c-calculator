//
//  UnitTests.m
//  Calculator
//
//  Created by Антон on 24.01.11.
//  Copyright 2011 Home Basic. All rights reserved.
//

#import "UnitTests.h"

@implementation UnitTests

#pragma mark test setUp/tearDown

/* The setUp method is called automatically before each test-case method (methods whose name starts with 'test').
 */
- (void) setUp {
	NSLog(@"%@ setUp", self.name);
	
	brain = [[CalculatorBrain alloc] init];
	
	STAssertNotNil(brain, @"Cannot create Calculator instance");
}

/* The tearDown method is called automatically after each test-case method (methods whose name starts with 'test').
 */

- (void) tearDown {
	[brain release];
	
	NSLog(@"%@ tearDown", self.name);
}

/* testSumm10and5 performs a simple addition test: 10.0 + 5 = 15.0.
 * The test has five parts:
 * 1. Through the operand @property, feed the calculator's brain the opearnd 10.0.
 * 2. Through the performOperation: method, feed the calculator's brain the operator +.
 * 3. Through the operand @property, feed the calculator's brain the opearnd 5.
 * 4. Through the performOperation: method, feed the calculator's brain the operator =.
 * 5. Confirm that result of the last operation is 15.0.
 */
- (void) testSumm10and5 {
	NSLog(@"%@ start", self.name);   // self.name is the name of the test-case method.
	
	brain.operand = [@"10.0" doubleValue];
	[brain performOperation:@"+"];
	brain.operand = [@"5" doubleValue];
	double result = [brain performOperation:@"="];
	double expected = 15.0;
	
	STAssertEquals(expected, result, @"Error summ double value from '10' and from '5' must be %g, instead %g",
				   expected, result);
	
	NSLog(@"%@ end", self.name);
}

/* testEvaluateExpressionSubstract11and7 performs a simple substraction test: 11 - 7.0 = 4.0.
 * The test has seven parts:
 * 1. Through the operand @property, feed the calculator's brain the opearnd 11.
 * 2. Through the performOperation: method, feed the calculator's brain the operator -.
 * 3. Through the operand @property, feed the calculator's brain the opearnd 7.0.
 * 4. Through the performOperation: method, feed the calculator's brain the operator =.
 * 5. Initialize list of the variable values with an empty NSDictionary collection.
 * 6. Perform evaluateExpression:usingVariableValues: method.
 * 7. Confirm that result of the last operation is 4.0.
 */
- (void) testEvaluateExpressionSubstract11and7 {
	NSLog(@"%@ start", self.name);   // self.name is the name of the test-case method.
	
	brain.operand = [@"11" doubleValue];
	[brain performOperation:@"-"];
	brain.operand = [@"7.0" doubleValue];
	[brain performOperation:@"="];
	
	NSDictionary *variables = [[NSDictionary alloc] init];
	
	double result = [CalculatorBrain evaluateExpression:brain.internalExpression usingVariableValues:variables];
	double expected = 4.0;
	
	[variables release];
	
	STAssertEquals(expected, result, @"Error substract double value '7' from '11' must be %g, instead %g",
				   expected, result);
	
	NSLog(@"%@ end", self.name);
}

@end
