#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BaiduMapView.h"
#import "BaiduMapViewManager.h"
#import "BaseModule.h"
#import "ClusterAnnotation.h"
#import "GeolocationModule.h"
#import "GetDistanceModule.h"
#import "BMKCluster.h"
#import "BMKClusterManager.h"
#import "BMKClusterQuadtree.h"
#import "BaiduMapAppModule.h"
#import "BaiduMapManager.h"
#import "OverlayUtils.h"
#import "OverlayMarkerManager.h"
#import "OverlayPolylineManager.h"
#import "OverlayCluster.h"
#import "OverlayClusterManager.h"
#import "OverlayMarker.h"
#import "OverlayPolyline.h"
#import "OverlayView.h"

FOUNDATION_EXPORT double react_native_baidu_mapVersionNumber;
FOUNDATION_EXPORT const unsigned char react_native_baidu_mapVersionString[];

