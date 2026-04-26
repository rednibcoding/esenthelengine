/******************************************************************************/
#include "iOS.h"
#undef super // Objective-C has its own 'super'
/******************************************************************************/
Bool DontRemoveThisOriOSAppDelegateClassWontBeLinked;
/******************************************************************************/
namespace EE{
/******************************************************************************/
void (*InitChartboostPtr)();
/******************************************************************************/
iOSAppDelegate* GetAppDelegate()
{
   return (iOSAppDelegate*)[UIApplication sharedApplication].delegate;
}
/******************************************************************************/
static void UpdateLocation(CLLocation *location, Bool gps)
{
   if(location)
      if(location.horizontalAccuracy>=0) // can be negative if coordinates are invalid
   {
      LocationLat[gps]=location.coordinate.latitude;
      LocationLon[gps]=location.coordinate.longitude;
      LocationAlt[gps]=location.altitude;
      LocationSpd[gps]=Max(0, (Flt)location.speed); // can be negative if invalid
      LocationAcc[gps]=location.horizontalAccuracy;
      LocationTim[gps].from(location.timestamp);
   }
}
static void UpdateMagnetometer(CLHeading *heading)
{
   if(heading)MagnetometerValue.set(heading.x, heading.y, -heading.z);
}
/******************************************************************************/
} // namespace EE
/******************************************************************************/
@implementation iOSAppDelegate
@synthesize window, controller;
/******************************************************************************/
-(BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
   ViewController=(MyViewController*)controller; // !! set this as first because other calls rely on this !!

   [window setRootViewController:controller]; // [window addSubview:controller.view];
   [window makeKeyAndVisible];

   // Sensors
   REPA(LocationManager)if(!LocationManager[i])
   {
      LocationManager[i]=[[CLLocationManager alloc] init];
      LocationManager[i].delegate       =self;
      LocationManager[i].desiredAccuracy=kCLLocationAccuracyBest;
      LocationManager[i].distanceFilter =kCLDistanceFilterNone;
      LocationManager[i]. headingFilter =kCLHeadingFilterNone;
                               UpdateLocation    (LocationManager[i   ].location, i!=0);
   }  if(LocationManager[true])UpdateMagnetometer(LocationManager[true].heading);
   return true;
}
-(void)applicationWillResignActive:(UIApplication*)application
{
   if(App._closed)return; // do nothing if app called 'Exit'
   App.setActive(false);
}
-(void)applicationDidBecomeActive:(UIApplication*)application
{
   if(App._closed)return; // do nothing if app called 'Exit'
   App.setActive(true);
}
-(void)applicationDidEnterBackground:(UIApplication*)application
{
   if(App._closed)return; // do nothing if app called 'Exit'
   if(App.save_state)App.save_state();
}
-(void)applicationWillTerminate:(UIApplication*)application
{
   if(App._closed)return; // do nothing if app called 'Exit'
   App.del();
}
-(void)applicationDidReceiveMemoryWarning:(UIApplication*)application
{
   if(App._closed)return; // do nothing if app called 'Exit'
   App.lowMemory();
}
-(void)dealloc
{
                         [window             release]; window            =null;
                         [controller         release]; controller        =null; ViewController=null;
   REPA(LocationManager){[LocationManager[i] release]; LocationManager[i]=null;}

   [super dealloc];
}
/******************************************************************************/
-(void)locationManager:(CLLocationManager*)manager didUpdateLocations:(NSArray*)locations
{
   UpdateLocation([locations lastObject], manager==LocationManager[1]); // last is the newest
}
-(void)locationManager:(CLLocationManager*)manager didUpdateHeading:(CLHeading*)newHeading
{
   UpdateMagnetometer(newHeading);
}
/******************************************************************************/
@end
/******************************************************************************/
