//
//  FlaggedTextField.h
//  RSSchool_T4
//
//  Created by Dimasno1 on 4/22/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FlaggedTextField : UIView

@property(retain, nonatomic)UITextField *numberField;

- (void)setFlagImage:(UIImage *)image;

@end

