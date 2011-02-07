//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Антон on 11.01.11.
//  Copyright 2011 Home Basic. All rights reserved.
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

@synthesize internalExpression = _internalExpression;

+ (BOOL)isThisObjectAVariable:(id)object {
	BOOL result = NO;
	
	if ([object isKindOfClass:[NSString class]]) {
		NSUInteger objectLength = [object length];
		if (objectLength > 1) {
			NSString *vp = VARIABLE_PREFIX;
			result = [[object substringToIndex:1] isEqual:vp];
		}
	}
	
	return result;
}

+ (double)evaluateExpression:(NSArray *)anExpression
		 usingVariableValues:(NSDictionary *)variables {
	
	CalculatorBrain *brain = [[CalculatorBrain alloc] init];
	
	for (id object in anExpression) {
		if ([object isKindOfClass:[NSNumber class]]) {
			brain.operand = [object doubleValue];
		} else if ([object isKindOfClass:[NSString class]]) {
			if ([CalculatorBrain isThisObjectAVariable:object]) {
				brain.operand = [[variables objectForKey:object] doubleValue];
			} else {
				[brain performOperation:object];
			}
		}
	}
	
	double result = brain.operand;
	[brain release];
	
	return result;
}

+ (NSSet *)variablesInExpression:(NSArray *)anExpression {
	NSMutableSet *setOfVariables = [[NSMutableSet alloc] init];
	
	for (id object in anExpression) {
		if ([CalculatorBrain isThisObjectAVariable:object] && [setOfVariables member:object] == nil) {
			[setOfVariables addObject:object];
		}
	}
	
	NSSet *result = nil;
	if (setOfVariables.count) {
		result = [NSSet setWithSet:setOfVariables];
	}
	
	[setOfVariables release];
	
	return result;
}

+ (NSString *)descriptionOfExpression:(NSArray *)anExpression {
	NSString *result = @"";
	
	for (id object in anExpression) {
		if ([CalculatorBrain isThisObjectAVariable:object]) {
			result = [result stringByAppendingString:[object substringFromIndex:1]];
		} else if ([object isKindOfClass:[NSNumber class]]) {
			result = [result stringByAppendingString:[object stringValue]];
		} else {
			result = [result stringByAppendingString:object];
		}
	}
	
	return result;
}

+ (id)propertyListForExpression:(id)anExpression {
	return nil;
}

+ (id)expressionForPropertyList:(id)propertyList {
	return nil;
}

- (NSArray *)internalExpression {
	return [NSArray arrayWithArray:_internalExpression];
}

- (void)performWaitingOperation {
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

- (BOOL)canAddOperandToExpression {
	if (self.internalExpression.count > 0) {
		id lastObject = [self.internalExpression objectAtIndex:self.internalExpression.count - 1];
		
		if ([lastObject isKindOfClass:[NSNumber class]])
		{
			warningOperation = @"Can't add: last object is an operand";
			return NO;
		}
		
		if ([CalculatorBrain isThisObjectAVariable:lastObject])
		{
			warningOperation = @"Can't add: last object is a variable";
			return NO;
		}
	}

	return YES;
}

- (void)setVariableAsOperand:(NSString *)variableName {
	if ([self canAddOperandToExpression]) {
		NSString *vp = VARIABLE_PREFIX;
		[_internalExpression addObject:[vp stringByAppendingString:variableName]];
	}
}

- (void)setOperand:(double)anOperand {
	operand = anOperand;
	
	if ([self canAddOperandToExpression]) {
		NSNumber *objectOperand = [[NSNumber alloc] initWithDouble:anOperand];
		[_internalExpression addObject:objectOperand];
	}
	
}

- (double)performOperation:(NSString *)operation {
	warningOperation = @"";

	[_internalExpression addObject:[[NSString alloc] initWithString:operation]];

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
		[_internalExpression removeAllObjects];
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
		self.waitingOperation = operation;
		waitingOperand = operand;
	}
	
	return operand;
}

- (id)init {
	if (self = [super init]) {
		_internalExpression = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (void)dealloc {
	[_internalExpression release];
	[super dealloc];
}

@end
