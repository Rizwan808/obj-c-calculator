//
//  UnitTests.h
//  Calculator
//
//  Created by Антон on 24.01.11.
//  Copyright 2011 Home Basic. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface UnitTests : SenTestCase {
	double testOperand;
	CalculatorBrain *brain;
}

@end
