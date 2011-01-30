//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Антон on 11.01.11.
//  Copyright 2011 Home Basic. All rights reserved.
//

#import <Foundation/Foundation.h>

#define VARIABLE_PREFIX @"%"

@interface CalculatorBrain : NSObject {
	double operand;
	NSMutableArray *_internalExpression;
}

@property (nonatomic) BOOL isItRadians;
@property (nonatomic, setter=setOperand) double operand;
@property (nonatomic) double memoryValue;
@property (nonatomic, retain) NSString *warningOperation;

@property (readonly, getter=internalExpression) NSArray *internalExpression;

+ (double)evaluateExpression:(NSArray *)anExpression
		 usingVariableValues:(NSDictionary *)variables;

/*
+ (NSSet *)variablesInExpression:(NSArray)anExpression;
+ (NSString *)descriptionOfExpression:(NSArray)anExpression;

+ (id)propertyListForExpression:(NSArray)anExpression;
+ (id)expressionForPropertyList:(id)propertyList;
*/

- (double)performOperation:(NSString *)operation;
- (void)setVariableAsOperand:(NSString *)variableName;

@end
