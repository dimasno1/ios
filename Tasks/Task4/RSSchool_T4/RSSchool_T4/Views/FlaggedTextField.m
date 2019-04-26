//
//  FlaggedTextField.m
//  RSSchool_T4
//
//  Created by Dimasno1 on 4/22/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "FlaggedTextField.h"

@interface FlaggedTextField()

@property (readonly, nonatomic)BOOL isFlagHidden;
@property (retain, nonatomic)UIImageView *flagImageView;

@end

@implementation FlaggedTextField

- (BOOL)isFlagHidden {
    return _flagImageView.image == nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _numberField = [[UITextField new]autorelease];
    _flagImageView = [[UIImageView new]autorelease];
    _numberField.keyboardType = UIKeyboardTypePhonePad;
    
    [self makeConstraints];
    [self addSubview:_numberField];
    [self addSubview:_flagImageView];
    self.backgroundColor = UIColor.whiteColor;
    self.layer.borderColor = UIColor.blackColor.CGColor;
    self.layer.borderWidth = 2.0f;
    self.layer.masksToBounds = YES;
}

- (void)makeConstraints {
    CGFloat width = [self isFlagHidden] ? self.bounds.size.width : self.bounds.size.width * 0.7f;
    CGFloat offset = 5.0f;
    
    _numberField.frame = CGRectMake(_flagImageView.frame.size.width + offset, 0, width - offset, self.bounds.size.height);
    self.layer.cornerRadius = MIN(self.bounds.size.width, self.bounds.size.height) * 0.3f;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self makeConstraints];
}

- (void)setFlagImage:(UIImage *)image {
    CGFloat offset = image == nil ? 0.0f : 5.0f;
    CGFloat width = image == nil ? 0.0f : self.bounds.size.width * 0.2f;

    _flagImageView.frame = CGRectMake(offset, 0, width, self.bounds.size.height);
    [_flagImageView setImage:image];
}

@end
