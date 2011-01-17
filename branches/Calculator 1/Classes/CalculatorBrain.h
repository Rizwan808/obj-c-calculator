//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Антон on 11.01.11.
//  Copyright 2011 Штрих-М. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject {
	NSString *waitingOperation;
	NSString *warningOperation;

	double operand;
	double waitingOperand;
	double memoryValue;
}

- (void)setOperand:(double)anOperand;
- (double)memoryValue;
- (double)performOperation:(NSString *)operation;
- (NSString *)warningOperation;

@property (nonatomic) BOOL isItRadians;

@end
