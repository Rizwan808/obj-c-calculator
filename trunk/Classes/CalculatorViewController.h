//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Антон on 10.01.11.
//  Copyright 2011 Home Basic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface CalculatorViewController : UIViewController {
}

@property (nonatomic, retain) IBOutlet UILabel *display;
@property (nonatomic, retain) IBOutlet UILabel *warning;
@property (nonatomic, retain) IBOutlet UILabel *memory;
@property (nonatomic, retain) IBOutlet UILabel *curOperation;

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;
- (IBAction)backspacePressed:(UIButton *)sender;
- (IBAction)variablePressed:(UIButton *)sender;
- (IBAction)evaluatePressed:(UIButton *)sender;

- (IBAction)radianSwitched:(UISwitch *)sender;

@end

