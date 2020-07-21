//
//  EFPasswordTextField.m
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFPasswordTextField.h"

@implementation EFPasswordTextField

- (instancetype)init
{
    if (self = [super init]) {
        self.delegate = self;
        self.tintColor = colorFE851E;
        if (self.placeholder.length) {
            self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSFontAttributeName : RegularFont15, NSForegroundColorAttributeName : [tabbarBlackColor colorWithAlphaComponent:0.7]}];
        }
        
    }
    return self;
}


- (void)textField:(QMUITextField *)textField didPreventTextChangeInRange:(NSRange)range replacementString:(NSString *)replacementString {
    
}



- (BOOL)deptNumInputShouldNumber:(NSString *)str
{
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"^(?![\d]+$)(?![a-zA-Z]+$)(?![^\da-zA-Z]+$).{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}

@end
