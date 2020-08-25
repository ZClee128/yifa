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
//        if (self.placeholder.length) {
//            self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSFontAttributeName : RegularFont15, NSForegroundColorAttributeName : [tabbarBlackColor colorWithAlphaComponent:0.7]}];
//        }
        self.placeholderColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
        self.secureTextEntry = YES;
        @weakify(self);
        [self setRightViewWithimageName:@"no_see" click:^(QMUIButton *x) {
            @strongify(self);
            x.selected ? [x setImage:UIImageMake(@"see") forState:(UIControlStateNormal)] : [x setImage:UIImageMake(@"no_see") forState:(UIControlStateNormal)];
            self.secureTextEntry = !x.selected;
        }];
        
    }
    return self;
}


- (void)textField:(QMUITextField *)textField didPreventTextChangeInRange:(NSRange)range replacementString:(NSString *)replacementString {
    
}





@end
