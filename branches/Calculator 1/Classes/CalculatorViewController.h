//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Антон on 10.01.11.
//  Copyright 2011 Штрих-М. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface CalculatorViewController : UIViewController {
	IBOutlet UILabel *display;
	IBOutlet UILabel *warning;
	IBOutlet UILabel *memory;
	IBOutlet UILabel *curOperation;

	BOOL userIsInTheMiddleOfTypingANumber;
	BOOL thePointHasBeenSet;
	
	CalculatorBrain *brain;
}

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;
- (IBAction)backspacePressed:(UIButton *)sender;
- (IBAction)radianSwitched:(UISwitch *)sender;

@end

