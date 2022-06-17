//
//  BezierPathFromString.h
//  TopVideoEditor
//
//  Created by WangZhengHong on 2022/5/9.
//

#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface BezierPathFromString : CALayer
- (UIBezierPath *)transformToBezierPath:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
