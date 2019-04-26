//
//  NumberInputViewController.m
//  RSSchool_T4
//
//  Created by Dimasno1 on 4/22/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "NumberInputViewController.h"

@interface NumberInputViewController ()

@property(retain, nonatomic)PhoneNumbersService *numberService;
@property(retain, nonatomic)FlaggedTextField *flaggedTextField;

@end

@implementation NumberInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self makeConstraints];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self makeConstraints];
}

- (void)setup {
    _flaggedTextField = [FlaggedTextField new];
    _numberService = [PhoneNumbersService new];
    _flaggedTextField.numberField.delegate = self;
    
    [self.view addSubview:_flaggedTextField];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)makeConstraints {
    _flaggedTextField.frame = CGRectMake(0, 0, 300, 50);
    _flaggedTextField.center = self.view.center;
}

- (void)updateImageIfNeededForCode:(NSString *)code {
    if (code) {
        NSString *name = [@"flag_" stringByAppendingString:code];
        UIImage *flagImage = [UIImage imageNamed:name];

        [_flaggedTextField setFlagImage:flagImage];
    } else {
        [_flaggedTextField setFlagImage: nil];
    }
}

- (void)dealloc {
    [_numberService release];
    [_flaggedTextField release];
    [super dealloc];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return [textField isFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL isDeleting = [string isEqualToString:@""];
    NSCharacterSet *set = [NSCharacterSet.decimalDigitCharacterSet invertedSet];
    NSString *text = [textField.text stringByAppendingString:string];

    if (text.length == 1 && isDeleting) {
        return  YES;
    }

    NSString *digitsString = [[text componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
    NSString *code = [_numberService codeIn:digitsString];

    if (digitsString.length > [_numberService phoneLenghtForPhone:digitsString] + code.length) {
        return isDeleting;
    }

    NSString *result = isDeleting ? [digitsString substringToIndex:MAX(digitsString.length - 1,0)] : digitsString;
    NSString *countryCode = [_numberService countryCodeInPhoneNumber:result];
    [self updateImageIfNeededForCode: countryCode];

    NSString *formatted = [_numberService formatPhoneNumber:result];
    textField.text = formatted;

    return NO;
}

@end
