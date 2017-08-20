//
//  DetailedViewController.h
//  Recipts
//
//  Created by Mohammad Shahzaib Ather on 2017-08-17.
//  Copyright © 2017 Mohammad Shahzaib Ather. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailedViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;

@end
