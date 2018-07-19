//
//  XViewMacros.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/07/20.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#ifndef XAbstractionLibrary_XViewMacros_h
#define XAbstractionLibrary_XViewMacros_h

#define VIEW_WIDTH(view) (view.bounds.size.width)
#define VIEW_HEIGHT(view) (view.bounds.size.height)

#define VIEW_LEFT(view) (view.frame.origin.x)
#define VIEW_TOP(view) (view.frame.origin.y)
#define VIEW_BOTTOM(view) (VIEW_HEIGHT(view) + VIEW_TOP(view))
#define VIEW_RIGHT(view)  (VIEW_LEFT(view) + VIEW_WIDTH(view))

#define SET_VIEW_HEIGHT(view, height) \
view.frame = CGRectMake(VIEW_LEFT(view), VIEW_TOP(view), VIEW_WIDTH(view), (height));

#define SET_VIEW_WIDTH(view, width) \
view.frame = CGRectMake(VIEW_LEFT(view), VIEW_TOP(view), (width), VIEW_HEIGHT(view));

#define SET_VIEW_LEFT(view, left) \
view.frame = CGRectMake((left), VIEW_TOP(view), VIEW_WIDTH(view), VIEW_HEIGHT(view));

#define SET_VIEW_TOP(view, top) \
view.frame = CGRectMake(VIEW_LEFT(view), (top), VIEW_WIDTH(view), VIEW_HEIGHT(view));

#define SET_VIEW_CENTERY(view, centerY) \
view.center = CGPointMake(view.center.x, (centerY))

#define SET_VIEW_CENTERX(view, centerX) \
view.center = CGPointMake((centerX), view.center.y)

#endif
