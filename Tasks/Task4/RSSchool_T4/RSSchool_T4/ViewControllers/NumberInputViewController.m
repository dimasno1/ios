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
    _flaggedTextField = [[FlaggedTextField new]autorelease];
    _numberService = [PhoneNumbersService new];
    _flaggedTextField.numberField.delegate = self;
    
    [self.view addSubview:_flaggedTextField];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)makeConstraints {
    _flaggedTextField.frame = CGRectMake(0, 0, 300, 50);
    _flaggedTextField.center = self.view.center;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return [textField isFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *number = [[textField.text stringByReplacingOccurrencesOfString:@"+" withString:@""]stringByAppendingString:string];
    NSString *code = [_numberService countryCodeForPhone:number];
    
    if (code != nil) {
        NSMutableString *name = [NSMutableString stringWithString:code];
        [name insertString:@"flag_" atIndex:0];
        
        UIImage *flagImage = [UIImage imageNamed:name];
        [_flaggedTextField showFlagImage:flagImage];
    } else {
        [_flaggedTextField hideFlagImage];
    }
    
    [_numberService formatPhoneNumber:number];
    
    
    return YES;
}

@end
