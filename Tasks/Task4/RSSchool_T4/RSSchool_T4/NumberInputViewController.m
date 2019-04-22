//
//  NumberInputViewController.m
//  RSSchool_T4
//
//  Created by Dimasno1 on 4/22/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "NumberInputViewController.h"

@interface NumberInputViewController(Protocols) <UITextFieldDelegate>
@end

@implementation NumberInputViewController(Protocols)

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        textField.text = @"+";
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return [textField isFirstResponder];
}

@end

@interface NumberInputViewController ()

@property(retain, nonatomic)UITextField *numberField;

@end

@implementation NumberInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    _numberField = [[UITextField new]autorelease];
    _numberField.layer.borderColor = UIColor.blackColor.CGColor;
    _numberField.layer.borderWidth = 2.0f;
    _numberField.delegate = self;
    _numberField.keyboardType = UIKeyboardTypePhonePad;
    
    [self makeConstraints];
    [self.view addSubview:_numberField];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)makeConstraints {
    _numberField.frame = CGRectMake(0, 0, 300, 50);
    _numberField.center = self.view.center;
    _numberField.layer.cornerRadius = MIN(_numberField.frame.size.width, _numberField.frame.size.height) * 0.3f;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self makeConstraints];
}

@end
