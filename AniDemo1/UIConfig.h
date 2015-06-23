//
//  UIConfig.h
//  xmxcy_iphone
//
//  Created by lisongzhe on 12-12-26.
//  Copyright (c) 2012年 xuchuan. All rights reserved.
//

#ifndef xmxcy_iphone_UIConfig_h
#define xmxcy_iphone_UIConfig_h

#define UI_SCREEN_FULL_HEIGHT               ([[UIScreen mainScreen] bounds].size.height)
#define UI_SCREEN_FULL_WIDTH                ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT                    ([[UIScreen mainScreen] bounds].size.height - 20)

#define UI_SCREEN_SCALEFACTOR               ([[UIScreen mainScreen] bounds].size.width)/320.0
#define UI_SCREEN_INCREASEFACTOR            (([[UIScreen mainScreen] bounds].size.width) - 320.0)
#define UI_SCREEN_SCALE_BASEIPHONE6         (UI_SCREEN_FULL_WIDTH/375.0)

#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)                        RGBA(r, g, b, 1.0f)
#define HEXCOLOR(c)                         [UIColor colorWithRed:((c>>16)&0xFF)/255.0f green:((c>>8)&0xFF)/255.0f blue:(c&0xFF)/255.0f alpha:1.0f];

//创建整形类型的CGPoint
#define UTIL_Point_MakeInt(x, y)                        CGPointMake((NSInteger)(x),(NSInteger)(y))
//创建Ceilf整形类型的CGPoint
#define UTIL_Point_MakeCeilfInt(x, y)                   CGPointMake(ceilf(x),ceilf(y))
//浮点型CGPoint转换为整形CGPoint
#define UTIL_Point_ConvertInt(point)                    CGPointMake((NSInteger)(point.x),(NSInteger)(point.y))
//浮点型CGPoint转换为Ceilf整形CGPoint
#define UTIL_Point_ConvertCeilfInt(point)               CGPointMake(ceilf(point.x),ceilf(point.y))

//创建整形类型的CGRect
#define UTIL_Rect_MakeInt(x, y, width, height)          CGRectMake((NSInteger)(x),(NSInteger)(y),(NSInteger)(width),(NSInteger)(height))
//创建Ceilf整形类型的CGRect
#define UTIL_Rect_MakeCeilfInt(x, y, width, height)     CGRectMake(ceilf(x),ceilf(y),ceilf(width),ceilf(height))
//浮点型CGRect转换为整形CGRect
#define UTIL_Rect_ConvertInt(rect)                      CGRectMake((NSInteger)(rect.origin.x),(NSInteger)(rect.origin.y),(NSInteger)(rect.size.width),(NSInteger)(rect.size.height))
//浮点型CGRect转换为Ceilf整形CGRect
#define UTIL_Rect_ConvertCeilfInt(rect)                 CGRectMake(ceilf(rect.origin.x),ceilf(rect.origin.y),ceilf(rect.size.width),ceilf(rect.size.height))

#define UTIL_View_Width(v)                        v.frame.size.width
#define UTIL_View_Height(v)                       v.frame.size.height
#define UTIL_View_X(v)                            v.frame.origin.x
#define UTIL_View_Y(v)                            v.frame.origin.y
#define UTIL_View_MaxX(v)                         CGRectGetMaxX(v.frame)
#define UTIL_View_MaxY(v)                         CGRectGetMaxY(v.frame)

#define UTIL_Rect_X(rect)                         rect.origin.x
#define UTIL_Rect_Y(rect)                         rect.origin.y
#define UTIL_Rect_Width(rect)                     rect.size.width
#define UTIL_Rect_Height(rect)                    rect.size.height
#define UTIL_Rect_SetWidth(rect, w)               CGRectMake(UTIL_Rect_X(rect), UTIL_Rect_Y(rect), w, UTIL_Rect_Height(rect))
#define UTIL_Rect_SetHeight(rect, h)              CGRectMake(UTIL_Rect_X(rect), UTIL_Rect_Y(rect), UTIL_Rect_Width(rect), h)
#define UTIL_Rect_SetX(rect, x)                   CGRectMake(x, UTIL_Rect_Y(rect), UTIL_Rect_Width(rect), UTIL_Rect_Height(rect))
#define UTIL_Rect_SetY(rect, y)                   CGRectMake(UTIL_Rect_X(rect), y, UTIL_Rect_Width(rect), UTIL_Rect_Height(rect))
#define UTIL_Rect_SetSize(rect, w, h)             CGRectMake(UTIL_Rect_X(rect), UTIL_Rect_Y(rect), w, h)
#define UTIL_Rect_SetOrigin(rect, x, y)           CGRectMake(x, y, UTIL_Rect_Width(rect), UTIL_Rect_Height(rect))

#define LikeBlueColor RGB(42,133,255)
#define LikeGreenColor RGB(54,198,71)
#endif
