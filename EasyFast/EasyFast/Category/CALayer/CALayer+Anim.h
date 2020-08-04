
#import <QuartzCore/QuartzCore.h>

@interface CALayer (Anim)

/*
 *  摇动
 */
-(void)shake;

@end


FOUNDATION_EXPORT NSString *const kXQCUIViewRotationsForKey;
typedef void(^XQCRotationsCompleted)(CAAnimation *animation);

@interface UIView (Rotations) <CAAnimationDelegate>

@property (nonatomic, copy) XQCRotationsCompleted rotationCompleted;

- (void)stopRotated;
- (void)rotateds;
- (void)rotateds:(XQCRotationsCompleted)completed;
- (void)rotatedsRepeat:(NSInteger)repeat;
- (void)rotatedsRepeat:(NSInteger)repeat completed:(XQCRotationsCompleted)completed;
- (void)rotateds:(NSTimeInterval)duration completed:(XQCRotationsCompleted)completed;
- (void)rotateds:(NSTimeInterval)duration forKey:(NSString *)key completed:(XQCRotationsCompleted)completed;
- (void)rotateds:(NSTimeInterval)duration repeatCount:(NSInteger)count forKey:(NSString *)key completed:(XQCRotationsCompleted)completed;

@end
