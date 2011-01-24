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
}

- (double)performOperation:(NSString *)operation;
- (void)setVariableAsOperand:(NSString *)variableName;

@property (nonatomic) BOOL isItRadians;
@property (nonatomic) double operand;
@property (nonatomic) double memoryValue;
@property (nonatomic, retain) NSString *warningOperation;

@property (readonly, copy) NSMutableArray *internalExpression;

/*
+ (double)evaluateExpression:(id)anExpression
		 usingVariableValues:(NSDictionary *)variables;

+ (NSSet *)variablesInExpression:(id)anExpression;
+ (NSString *)descriptionOfExpression:(id)anExpression;

+ (id)propertyListForExpression:(id)anExpression;
+ (id)expressionForPropertyList:(id)propertyList;
*/

@end
