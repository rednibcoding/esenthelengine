/******************************************************************************/
#include "stdafx.h"
#define SUPPORT_CHARTBOOST 0
#if SUPPORT_CHARTBOOST
#include "../Platforms/iOS/iOS.h"

static void ChartboostCall(ChartboostClass::RESULT result)
{
   if(void (*callback)(ChartboostClass::RESULT)=EE::Chartboost.callback)callback(result);
}

@interface EsenthelChartboostDelegate : NSObject<ChartboostDelegate>
{
   // following methods must use 'AppVolume.muteEx' instead of 'PauseSound/ResumeSound' because it's possible that the app is still running while the video is displayed, and new sounds could be started by the app
}
@end
@implementation EsenthelChartboostDelegate
 //- (BOOL)shouldRequestInterstitial:(CBLocation)location {return YES;}
 //- (BOOL)shouldDisplayInterstitial:(CBLocation)location {return YES;}
   - (void)didCacheInterstitial:(CBLocation)location {ChartboostCall(ChartboostClass::INTERSTITIAL_LOADED);}
   - (void)didFailToLoadInterstitial:(CBLocation)location withError:(CBLoadError)error {ChartboostCall(ChartboostClass::INTERSTITIAL_LOAD_FAIL);}
   - (void)didDisplayInterstitial:(CBLocation)location {ChartboostCall(ChartboostClass::INTERSTITIAL_DISPLAYED);}
   - (void)didDismissInterstitial:(CBLocation)location {AppVolume.muteEx(false); ChartboostCall(ChartboostClass::INTERSTITIAL_CLOSED);}
 //- (void)didCloseInterstitial:(CBLocation)location {AppVolume.muteEx(false); ChartboostCall(ChartboostClass::INTERSTITIAL_CLOSED);}
   - (void)didClickInterstitial:(CBLocation)location {ChartboostCall(ChartboostClass::INTERSTITIAL_CLICKED);}

 //- (BOOL)shouldDisplayRewardedVideo:(CBLocation)location {return YES;}
   - (void)didCacheRewardedVideo:(CBLocation)location {ChartboostCall(ChartboostClass::REWARDED_VIDEO_LOADED);}
   - (void)didFailToLoadRewardedVideo:(CBLocation)location withError:(CBLoadError)error {ChartboostCall(ChartboostClass::REWARDED_VIDEO_LOAD_FAIL);}
   - (void)didDisplayRewardedVideo:(CBLocation)location {AppVolume.muteEx(true); ChartboostCall(ChartboostClass::REWARDED_VIDEO_DISPLAYED);}
   - (void)willDisplayVideo:(CBLocation)location {AppVolume.muteEx(true); /*ChartboostCall(ChartboostClass::REWARDED_VIDEO_DISPLAYED);*/}
   - (void)didDismissRewardedVideo:(CBLocation)location {AppVolume.muteEx(false); ChartboostCall(ChartboostClass::REWARDED_VIDEO_CLOSED);}
 //- (void)didCloseRewardedVideo:(CBLocation)location {AppVolume.muteEx(false); ChartboostCall(ChartboostClass::REWARDED_VIDEO_CLOSED);}
   - (void)didCompleteRewardedVideo:(CBLocation)location withReward:(int)reward {AppVolume.muteEx(false); ChartboostCall(ChartboostClass::REWARDED_VIDEO_COMPLETED);}
   - (void)didClickRewardedVideo:(CBLocation)location {ChartboostCall(ChartboostClass::REWARDED_VIDEO_CLICKED);}
@end
#endif
namespace EE{
/******************************************************************************/
ChartboostClass Chartboost;
/******************************************************************************/
#if SUPPORT_CHARTBOOST
static EsenthelChartboostDelegate *EsenthelChartboostDelegatePtr;
static void InitChartboost()
{
   if(NSString *app_id       =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"ChartboostAppID"       ])if(app_id       .length)
   if(NSString *app_signature=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"ChartboostAppSignature"])if(app_signature.length)
   {
      EsenthelChartboostDelegatePtr=[[EsenthelChartboostDelegate alloc] init];
      [::Chartboost startWithAppId:app_id
                      appSignature:app_signature
                          delegate:EsenthelChartboostDelegatePtr];
   }
}
#endif
ChartboostClass::~ChartboostClass()
{
#if SUPPORT_CHARTBOOST
   [::Chartboost setDelegate:nil];
   [EsenthelChartboostDelegatePtr release]; EsenthelChartboostDelegatePtr=null; // have to release only after we will not use Chartboost anymore, and we've cleared the delegate, if we would release inside 'InitChartboost' then it would get destroyed immediately as chartboost does not increase the ref cound for it
#endif
}
ChartboostClass::ChartboostClass()
{
#if SUPPORT_CHARTBOOST
   InitChartboostPtr=InitChartboost;
#endif
}
/******************************************************************************/
Bool ChartboostClass::visible()C // this does not work on Android, most likely it's not compatible with OpenGL and 'Chartboost.setImpressionsUseActivities'
{
#if ANDROID
   JNI jni;
   if(jni && ActivityClass)
   if(JMethodID chartboostVisible=jni.staticFunc(ActivityClass, "chartboostVisible", "()Z"))
      return jni->CallStaticBooleanMethod(ActivityClass, chartboostVisible);
#elif SUPPORT_CHARTBOOST
   return [::Chartboost isAnyViewVisible];
#endif
   return false;
}
/******************************************************************************/
ChartboostClass& ChartboostClass::interstitialLoad()
{
#if ANDROID
   JNI jni;
   if(jni && ActivityClass)
      if(JMethodID chartboostInterstitialLoad=jni.staticFunc(ActivityClass, "chartboostInterstitialLoad", "()V"))
         jni->CallStaticVoidMethod(ActivityClass, chartboostInterstitialLoad);
#elif SUPPORT_CHARTBOOST
   [::Chartboost cacheInterstitial:CBLocationDefault];
#endif
   return T;
}
ChartboostClass& ChartboostClass::interstitialShow()
{
#if ANDROID
   JNI jni;
   if(jni && ActivityClass)
      if(JMethodID chartboostInterstitialShow=jni.staticFunc(ActivityClass, "chartboostInterstitialShow", "()V"))
         jni->CallStaticVoidMethod(ActivityClass, chartboostInterstitialShow);
#elif SUPPORT_CHARTBOOST
   [::Chartboost showInterstitial:CBLocationDefault];
#endif
   return T;
}
Bool ChartboostClass::interstitialAvailable()C
{
#if ANDROID
   JNI jni;
   if(jni && ActivityClass)
      if(JMethodID chartboostInterstitialAvailable=jni.staticFunc(ActivityClass, "chartboostInterstitialAvailable", "()Z"))
         return jni->CallStaticBooleanMethod(ActivityClass, chartboostInterstitialAvailable);
#elif SUPPORT_CHARTBOOST
   return [::Chartboost hasInterstitial:CBLocationDefault];
#endif
   return false;
}
/******************************************************************************/
ChartboostClass& ChartboostClass::rewardedVideoLoad()
{
#if ANDROID
   JNI jni;
   if(jni && ActivityClass)
      if(JMethodID chartboostRewardedVideoLoad=jni.staticFunc(ActivityClass, "chartboostRewardedVideoLoad", "()V"))
         jni->CallStaticVoidMethod(ActivityClass, chartboostRewardedVideoLoad);
#elif SUPPORT_CHARTBOOST
   [::Chartboost cacheRewardedVideo:CBLocationDefault];
#endif
   return T;
}
ChartboostClass& ChartboostClass::rewardedVideoShow()
{
#if ANDROID
   JNI jni;
   if(jni && ActivityClass)
      if(JMethodID chartboostRewardedVideoShow=jni.staticFunc(ActivityClass, "chartboostRewardedVideoShow", "()V"))
         jni->CallStaticVoidMethod(ActivityClass, chartboostRewardedVideoShow);
#elif SUPPORT_CHARTBOOST
   [::Chartboost showRewardedVideo:CBLocationDefault];
#endif
   return T;
}
Bool ChartboostClass::rewardedVideoAvailable()C
{
#if ANDROID
   JNI jni;
   if(jni && ActivityClass)
      if(JMethodID chartboostRewardedVideoAvailable=jni.staticFunc(ActivityClass, "chartboostRewardedVideoAvailable", "()Z"))
         return jni->CallStaticBooleanMethod(ActivityClass, chartboostRewardedVideoAvailable);
#elif SUPPORT_CHARTBOOST
   return [::Chartboost hasRewardedVideo:CBLocationDefault];
#endif
   return false;
}
/******************************************************************************/
} // namespace EE
/******************************************************************************/
#if ANDROID
extern "C" JNIEXPORT void JNICALL Java_com_esenthel_Native_chartboost(JNIEnv *env, jclass clazz, jint result)
{
   if(void (*callback)(ChartboostClass::RESULT)=Chartboost.callback)callback(ChartboostClass::RESULT(result));
}
#endif
/******************************************************************************/
