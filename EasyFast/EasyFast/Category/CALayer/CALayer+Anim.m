
#import "CALayer+Anim.h"
#import <objc/runtime.h>

@implementation CALayer (Anim)


/*
 *  摇动
 */
-(void)shake{
    
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    
    CGFloat s = 5;
    
    kfa.values = @[@(-s),@(0),@(s),@(0),@(-s),@(0),@(s),@(0)];
    
    //时长
    kfa.duration = 0.3f;
    
    //重复
    kfa.repeatCount = 2;
    
    //移除
    kfa.removedOnCompletion = YES;
    
    [self addAnimation:kfa forKey:@"shake"];
}

@end

//***************************************************************************************************************************************************************

NSString *const kXQCUIViewRotationsForKey       = @"XQCUIViewRotationsForKey";
static NSString *kRotationsCompletedForKey      = @"fasekjfaowefawoefkmfsefaf";

@implementation UIView (Rotations)

- (XQCRotationsCompleted)rotationCompleted
{
    return objc_getAssociatedObject(self, &kRotationsCompletedForKey);
}

- (void)setRotationCompleted:(XQCRotationsCompleted)rotationCompleted
{
    [self willChangeValueForKey:kRotationsCompletedForKey];
    objc_setAssociatedObject(self, &kRotationsCompletedForKey, rotationCompleted, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:kRotationsCompletedForKey];
}

#pragma mark - Methods

- (void)stopRotated
{
    [self.layer removeAnimationForKey:kXQCUIViewRotationsForKey];
}

- (void)rotateds
{
    [self rotateds:^(CAAnimation *animation) {}];
}

- (void)rotateds:(XQCRotationsCompleted)completed
{
    [self rotateds:1.0f completed:completed];
}

- (void)rotatedsRepeat:(NSInteger)repeat
{
    [self rotatedsRepeat:repeat completed:^(CAAnimation *animation) {}];
}

- (void)rotatedsRepeat:(NSInteger)repeat completed:(XQCRotationsCompleted)completed
{
    [self rotateds:1.0f repeatCount:repeat forKey:kXQCUIViewRotationsForKey completed:completed];
}

- (void)rotateds:(NSTimeInterval)duration completed:(XQCRotationsCompleted)completed
{
    [self rotateds:duration forKey:kXQCUIViewRotationsForKey completed:completed];
}

- (void)rotateds:(NSTimeInterval)duration forKey:(NSString *)key completed:(XQCRotationsCompleted)completed
{
    [self rotateds:duration repeatCount:HUGE_VALF forKey:key completed:completed];
}

- (void)rotateds:(NSTimeInterval)duration repeatCount:(NSInteger)count forKey:(NSString *)key completed:(XQCRotationsCompleted)completed
{
    if ([self.layer.animationKeys containsObject:kXQCUIViewRotationsForKey]) {
        [self.layer removeAnimationForKey:kXQCUIViewRotationsForKey];
    }
    if ([self.layer.animationKeys containsObject:key]) {
        [self.layer removeAnimationForKey:key];
    }
    CABasicAnimation *rotateds = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateds.delegate = self;
    rotateds.toValue = @(M_PI * 2.0);
    rotateds.duration = duration;
    rotateds.repeatCount = count;
    
    self.rotationCompleted = completed;
    [self.layer addAnimation:rotateds forKey:key];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.rotationCompleted) {
        self.rotationCompleted(anim);
    }
}


@end
