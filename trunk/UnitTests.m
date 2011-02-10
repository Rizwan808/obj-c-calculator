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

/* testSum10and5 performs a simple addition test: 10.0 + 5 = 15.0.
 * The test has five parts:
 * 1. Through the operand @property, feed the calculator's brain the opearnd 10.0.
 * 2. Through the performOperation: method, feed the calculator's brain the operator +.
 * 3. Through the operand @property, feed the calculator's brain the opearnd 5.
 * 4. Through the performOperation: method, feed the calculator's brain the operator =.
 * 5. Confirm that result of the last operation is 15.0.
 */
- (void) testSum10and5 {
	NSLog(@"%@ start", self.name);   // self.name is the name of the test-case method.
	
	brain.operand = [@"10.0" doubleValue];
	[brain performOperation:@"+"];
	brain.operand = [@"5" doubleValue];
	double result = [brain performOperation:@"="];
	double expected = 15.0;
	
	STAssertEquals(expected, result, @"Error: the sum of '10.0' and '5'\
				   must be %g, instead %g", expected, result);
	
	NSLog(@"%@ end", self.name);
}

/* testClearJob performs a correct clear operation test: 3 + C 3 +.
 * The test has five parts:
 * 1. Through the operand @property, feed the calculator's brain the opearnd 3.
 * 2. Through the performOperation: method, feed the calculator's brain the operator +.
 * 3. Through the performOperation: method, feed the calculator's brain the operator C.
 * 4. Through the operand @property, feed the calculator's brain the opearnd 3.
 * 5. Through the performOperation: method, feed the calculator's brain the operator +.
 * 6. Confirm that result of the last operation is 3.0.
 */
- (void) testClearJob {
	NSLog(@"%@ start", self.name);   // self.name is the name of the test-case method.
	
	brain.operand = [@"3" doubleValue];
	[brain performOperation:@"+"];
	[brain performOperation:@"C"];
	brain.operand = [@"3" doubleValue];
	double result = [brain performOperation:@"+"];
	double expected = 3.0;
	
	STAssertEquals(expected, result, @"Error: the result of this test\
				   must be %g, instead %g", expected, result);
	
	NSLog(@"%@ end", self.name);
}

/* testEvaluateExpressionSubtract11and7 performs a simple subtraction test: 11 - 7.0 = 4.0.
 * The test has seven parts:
 * 1. Through the operand @property, feed the calculator's brain the opearnd 11.
 * 2. Through the performOperation: method, feed the calculator's brain the operator -.
 * 3. Through the operand @property, feed the calculator's brain the opearnd 7.0.
 * 4. Through the performOperation: method, feed the calculator's brain the operator =.
 * 5. Initialize list of the variable values with an empty NSDictionary collection.
 * 6. Perform evaluateExpression:usingVariableValues: method.
 * 7. Confirm that result of the last operation is 4.0.
 */
- (void) testEvaluateExpressionSubtract11and7 {
	NSLog(@"%@ start", self.name);   // self.name is the name of the test-case method.
	
	brain.operand = [@"11" doubleValue];
	[brain performOperation:@"-"];
	brain.operand = [@"7.0" doubleValue];
	[brain performOperation:@"="];
	
	NSDictionary *variables = [[NSDictionary alloc] init];
	
	double result = [CalculatorBrain evaluateExpression:brain.internalExpression usingVariableValues:variables];
	double expected = 4.0;
	
	[variables release];
	
	STAssertEquals(expected, result, @"Error: the subtraction of '7.0' from '11'\
				   leaves %g, instead %g", expected, result);
	
	NSLog(@"%@ end", self.name);
}

/* testEvaluateExpressionDivide15on3plusX performs a simple division test: 15 / 3 + x = 7.0.
 * The test has ten parts:
 *  1. Through the operand @property, feed the calculator's brain the opearnd 15.
 *  2. Through the performOperation: method, feed the calculator's brain the operator /.
 *  3. Through the operand @property, feed the calculator's brain the opearnd 3.
 *  4. Through the performOperation: method, feed the calculator's brain the operator =.
 *  5. Through the performOperation: method, feed the calculator's brain the operator +.
 *  6. Through the setVariableAsOperand: method, feed the calculator's brain the variable x.
 *  7. Through the performOperation: method, feed the calculator's brain the operator =.
 *  8. Initialize list of the variable values with an NSDictionary collection with one
		object inside - the %x variable with double value 2.1.
 *  9. Perform evaluateExpression:usingVariableValues: method.
 * 10. Confirm that result of the last operation is 5.0.
 */
- (void) testEvaluateExpressionDivide15on3plusX {
	NSLog(@"%@ start", self.name);   // self.name is the name of the test-case method.
	
	brain.operand = [@"15" doubleValue];
	[brain performOperation:@"/"];
	brain.operand = [@"3" doubleValue];
	[brain performOperation:@"="];
	[brain performOperation:@"+"];
	[brain setVariableAsOperand:@"x"];
	[brain performOperation:@"="];
	
	NSString *variableName = [NSString stringWithString:@"%x"];
	NSNumber *variableValue = [NSNumber numberWithDouble:2.1];
	NSDictionary *variables = [NSDictionary dictionaryWithObjectsAndKeys:variableValue, variableName, nil];

	double result = [CalculatorBrain evaluateExpression:brain.internalExpression usingVariableValues:variables];
	double expected = 7.1;
	
	STAssertEquals(expected, result, @"Error: the division '15' by '3' and plus %%x = 2.1\
				   must be %g, instead %g", expected, result);
	
	NSLog(@"%@ end", self.name);
}

/* testTwoVariablesInExpressionXandB this is a simple test, it puts three variables
 *		x, b and x in the internal expression and get them out by calling
 *		variablesInExpression() method. The result must contain two variables
 *		x and b.
 * The test has five parts:
 * 1. Put variable x in the expression.
 * 2. Put variable b in the expression.
 * 3. Put variable x in the expression.
 * 4. Call variablesInTheExpression() method.
 * 5. Confirm that result set contain two variables x and b.
 */
- (void) testTwoVariablesInExpressionXandB {
	NSLog(@"%@ start", self.name);   // self.name is the name of the test-case method.
	
	[brain setVariableAsOperand:@"x"];
	[brain performOperation:@"*"];
	[brain setVariableAsOperand:@"b"];
	[brain performOperation:@"+"];
	[brain setOperand:2.0];
	[brain performOperation:@"-"];
	[brain setVariableAsOperand:@"x"];
	[brain performOperation:@"="];
	
	NSSet *result = [CalculatorBrain variablesInExpression:brain.internalExpression];
	NSSet *expected = [[NSSet alloc] initWithObjects:@"%x", @"%b", nil];
	
	STAssertTrue([expected isEqualToSet:result], @"Error: the result set of the variables is not same as expected");
	
	NSLog(@"%@ end", self.name);
}

/* testExpressionStringAplus10minusBequals20 this is a simple test, it puts three variables
 *		x, b and x in the internal expression and get them out by calling
 *		variablesInExpression() method. The result must contain two variables
 *		x and b.
 * The test has five parts:
 * 1. Put variable x in the expression.
 * 2. Put variable b in the expression.
 * 3. Put variable x in the expression.
 * 4. Call variablesInTheExpression() method.
 * 5. Confirm that result set contain two variables x and b.
 */
- (void) testExpressionStringAplus10minusBmultXdiv5equal {
	NSLog(@"%@ start", self.name);   // self.name is the name of the test-case method.
	
	[brain setVariableAsOperand:@"a"];
	[brain performOperation:@"+"];
	[brain setOperand:10.0];
	[brain performOperation:@"-"];
	[brain setVariableAsOperand:@"b"];
	[brain performOperation:@"*"];
	[brain setVariableAsOperand:@"x"];
	[brain performOperation:@"/"];
	[brain setOperand:5.0];
	[brain performOperation:@"="];
	
	NSString *result = [CalculatorBrain descriptionOfExpression:brain.internalExpression];
	NSString *expected = @"a+10-b*x/5=";
	
	STAssertEqualObjects(expected, result, @"Error: wrong expression description\
				   must be '%@', instead '%@'", expected, result);
	
	NSLog(@"%@ end", self.name);
}

@end
