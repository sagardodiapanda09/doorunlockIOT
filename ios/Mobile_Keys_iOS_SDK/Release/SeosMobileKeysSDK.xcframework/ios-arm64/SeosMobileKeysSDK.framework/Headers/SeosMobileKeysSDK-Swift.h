#if 0
#elif defined(__arm64__) && __arm64__
// Generated by Apple Swift version 6.0 effective-5.10 (swiftlang-6.0.0.9.10 clang-1600.0.26.2)
#ifndef SEOSMOBILEKEYSSDK_SWIFT_H
#define SEOSMOBILEKEYSSDK_SWIFT_H
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#if defined(__OBJC__)
#include <Foundation/Foundation.h>
#endif
#if defined(__cplusplus)
#include <cstdint>
#include <cstddef>
#include <cstdbool>
#include <cstring>
#include <stdlib.h>
#include <new>
#include <type_traits>
#else
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>
#include <string.h>
#endif
#if defined(__cplusplus)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnon-modular-include-in-framework-module"
#if defined(__arm64e__) && __has_include(<ptrauth.h>)
# include <ptrauth.h>
#else
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wreserved-macro-identifier"
# ifndef __ptrauth_swift_value_witness_function_pointer
#  define __ptrauth_swift_value_witness_function_pointer(x)
# endif
# ifndef __ptrauth_swift_class_method_pointer
#  define __ptrauth_swift_class_method_pointer(x)
# endif
#pragma clang diagnostic pop
#endif
#pragma clang diagnostic pop
#endif

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...) 
# endif
#endif
#if !defined(SWIFT_RUNTIME_NAME)
# if __has_attribute(objc_runtime_name)
#  define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
# else
#  define SWIFT_RUNTIME_NAME(X) 
# endif
#endif
#if !defined(SWIFT_COMPILE_NAME)
# if __has_attribute(swift_name)
#  define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
# else
#  define SWIFT_COMPILE_NAME(X) 
# endif
#endif
#if !defined(SWIFT_METHOD_FAMILY)
# if __has_attribute(objc_method_family)
#  define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
# else
#  define SWIFT_METHOD_FAMILY(X) 
# endif
#endif
#if !defined(SWIFT_NOESCAPE)
# if __has_attribute(noescape)
#  define SWIFT_NOESCAPE __attribute__((noescape))
# else
#  define SWIFT_NOESCAPE 
# endif
#endif
#if !defined(SWIFT_RELEASES_ARGUMENT)
# if __has_attribute(ns_consumed)
#  define SWIFT_RELEASES_ARGUMENT __attribute__((ns_consumed))
# else
#  define SWIFT_RELEASES_ARGUMENT 
# endif
#endif
#if !defined(SWIFT_WARN_UNUSED_RESULT)
# if __has_attribute(warn_unused_result)
#  define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
# else
#  define SWIFT_WARN_UNUSED_RESULT 
# endif
#endif
#if !defined(SWIFT_NORETURN)
# if __has_attribute(noreturn)
#  define SWIFT_NORETURN __attribute__((noreturn))
# else
#  define SWIFT_NORETURN 
# endif
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA 
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA 
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA 
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif
#if !defined(SWIFT_RESILIENT_CLASS)
# if __has_attribute(objc_class_stub)
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME) __attribute__((objc_class_stub))
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_class_stub)) SWIFT_CLASS_NAMED(SWIFT_NAME)
# else
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME)
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) SWIFT_CLASS_NAMED(SWIFT_NAME)
# endif
#endif
#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif
#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER 
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR(_extensibility) __attribute__((enum_extensibility(_extensibility)))
# else
#  define SWIFT_ENUM_ATTR(_extensibility) 
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name, _extensibility) enum _name : _type _name; enum SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) SWIFT_ENUM(_type, _name, _extensibility)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_WEAK_IMPORT)
# define SWIFT_WEAK_IMPORT __attribute__((weak_import))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED_OBJC)
# if __has_feature(attribute_diagnose_if_objc)
#  define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
# else
#  define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
# endif
#endif
#if defined(__OBJC__)
#if !defined(IBSegueAction)
# define IBSegueAction 
#endif
#endif
#if !defined(SWIFT_EXTERN)
# if defined(__cplusplus)
#  define SWIFT_EXTERN extern "C"
# else
#  define SWIFT_EXTERN extern
# endif
#endif
#if !defined(SWIFT_CALL)
# define SWIFT_CALL __attribute__((swiftcall))
#endif
#if !defined(SWIFT_INDIRECT_RESULT)
# define SWIFT_INDIRECT_RESULT __attribute__((swift_indirect_result))
#endif
#if !defined(SWIFT_CONTEXT)
# define SWIFT_CONTEXT __attribute__((swift_context))
#endif
#if !defined(SWIFT_ERROR_RESULT)
# define SWIFT_ERROR_RESULT __attribute__((swift_error_result))
#endif
#if defined(__cplusplus)
# define SWIFT_NOEXCEPT noexcept
#else
# define SWIFT_NOEXCEPT 
#endif
#if !defined(SWIFT_C_INLINE_THUNK)
# if __has_attribute(always_inline)
# if __has_attribute(nodebug)
#  define SWIFT_C_INLINE_THUNK inline __attribute__((always_inline)) __attribute__((nodebug))
# else
#  define SWIFT_C_INLINE_THUNK inline __attribute__((always_inline))
# endif
# else
#  define SWIFT_C_INLINE_THUNK inline
# endif
#endif
#if defined(_WIN32)
#if !defined(SWIFT_IMPORT_STDLIB_SYMBOL)
# define SWIFT_IMPORT_STDLIB_SYMBOL __declspec(dllimport)
#endif
#else
#if !defined(SWIFT_IMPORT_STDLIB_SYMBOL)
# define SWIFT_IMPORT_STDLIB_SYMBOL 
#endif
#endif
#if defined(__OBJC__)
#if __has_feature(objc_modules)
#if __has_warning("-Watimport-in-framework-header")
#pragma clang diagnostic ignored "-Watimport-in-framework-header"
#endif
@import Dispatch;
@import Foundation;
@import ObjectiveC;
#endif

#import <SeosMobileKeysSDK/SeosMobileKeysSDK.h>

#endif
#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"
#pragma clang diagnostic ignored "-Wdollar-in-identifier-extension"
#pragma clang diagnostic ignored "-Wunsafe-buffer-usage"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="SeosMobileKeysSDK",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif

#if defined(__OBJC__)
@class NSString;
@class NSURL;
@protocol AuthAccessTokenHoldable;
@class NSDate;

SWIFT_CLASS("_TtC17SeosMobileKeysSDK12AnalyticsAPI")
@interface AnalyticsAPI : NSObject
/// Initializes an instance of the API with the given app name.
/// Returns a new Analytics instance API object. This allows you to create more than one instance
/// of the API object, which is convenient if you’d like to send data to more than
/// one Analytics project from a single app.
/// note:
/// New instance will be created per <code>appName</code>
/// \param appName Name of the app or library using this SDK
///
/// \param url URL to send the events to
///
/// \param headers HTTP headers to pass with URL request
///
/// \param authAccessTokenHolder Authenticated access token provider
///
/// \param source Cloud event source
///
/// \param specVersion Cloud event spec version
///
/// \param includeDeviceDetails Whether to include device details along with event or not
///
/// \param additionalParams Additional paramters that can be passed and supported by the SDK
///
///
/// returns:
/// Instance of <code>AnalyticsAPI</code>
+ (AnalyticsAPI * _Nonnull)instanceWithAppName:(NSString * _Nonnull)appName url:(NSURL * _Nullable)url headers:(NSDictionary<NSString *, NSString *> * _Nullable)headers authAccessTokenHolder:(id <AuthAccessTokenHoldable> _Nullable)authAccessTokenHolder source:(NSString * _Nonnull)source specVersion:(NSString * _Nonnull)specVersion includeDeviceDetails:(BOOL)includeDeviceDetails additionalParams:(NSDictionary<NSString *, id> * _Nonnull)additionalParams SWIFT_WARN_UNUSED_RESULT;
/// Set the URL to send the events to
/// \param url URL to send the events to
///
- (void)setWithUrl:(NSURL * _Nonnull)url;
/// Tries to send locally cached events immedietly.
/// It will throw any one of the <code>AnalyticsError</code>
/// note:
/// This API will work only when the app is in foreground and has network connectivity.
- (BOOL)sendCachedEventsImmediatelyAndReturnError:(NSError * _Nullable * _Nullable)error;
/// Register the super properties to send along with every event
/// \param properties Super properties
///
- (BOOL)registerWithSuperProperties:(NSDictionary<NSString *, id> * _Nonnull)properties error:(NSError * _Nullable * _Nullable)error;
/// Captures the time of events start and the duration will be calculated when the individual event is tracked
/// \param events Names of the events
///
- (void)timeWithEvents:(NSArray<NSString *> * _Nonnull)events;
/// Captures the time of an event start and the duration will be calculated when the event is tracked
/// \param event Name of the event
///
- (void)timeWithEvent:(NSString * _Nonnull)event;
/// Tracks the event along with attributes and date
/// \param event Name of the event
///
/// \param attributes Addional attributes for the event
///
/// \param time Time the event has occured
///
- (BOOL)trackWithEvent:(NSString * _Nonnull)event attributes:(NSDictionary<NSString *, id> * _Nonnull)attributes time:(NSDate * _Nonnull)time error:(NSError * _Nullable * _Nullable)error;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_PROTOCOL("_TtP17SeosMobileKeysSDK23AuthAccessTokenHoldable_")
@protocol AuthAccessTokenHoldable <NSObject>
@property (nonatomic, copy) void (^ _Nullable accessTokenListener)(NSString * _Nullable);
- (void)fetchAccessToken;
- (void)clearAccessToken;
@end


SWIFT_PROTOCOL("_TtP17SeosMobileKeysSDK5Clock_")
@protocol Clock
- (NSTimeInterval)currentTimeIntervalSince1970 SWIFT_WARN_UNUSED_RESULT;
- (NSDate * _Nonnull)now SWIFT_WARN_UNUSED_RESULT;
- (NSDate * _Nonnull)futureWithTime:(NSTimeInterval)time SWIFT_WARN_UNUSED_RESULT;
- (NSDate * _Nonnull)pastWithTime:(NSTimeInterval)time SWIFT_WARN_UNUSED_RESULT;
@end


SWIFT_CLASS("_TtC17SeosMobileKeysSDK9RealClock")
@interface RealClock : NSObject <Clock>
- (NSTimeInterval)currentTimeIntervalSince1970 SWIFT_WARN_UNUSED_RESULT;
- (NSDate * _Nonnull)now SWIFT_WARN_UNUSED_RESULT;
- (NSDate * _Nonnull)futureWithTime:(NSTimeInterval)time SWIFT_WARN_UNUSED_RESULT;
- (NSDate * _Nonnull)pastWithTime:(NSTimeInterval)time SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC17SeosMobileKeysSDK9FakeClock")
@interface FakeClock : RealClock
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (NSTimeInterval)currentTimeIntervalSince1970 SWIFT_WARN_UNUSED_RESULT;
- (NSDate * _Nonnull)now SWIFT_WARN_UNUSED_RESULT;
- (void)tick;
- (void)spendTimeWithTime:(NSTimeInterval)time;
@end

@class Personalized;
@class PersonalizationFailure;

/// Class responsible for analytics authentication and URL configurations
SWIFT_CLASS("_TtC17SeosMobileKeysSDK15IHAnalyticsUtil")
@interface IHAnalyticsUtil : NSObject
@property (nonatomic, readonly, strong) AnalyticsAPI * _Nonnull analyticsAPI;
@property (nonatomic, strong) Personalized * _Nullable personalized;
@property (nonatomic, strong) PersonalizationFailure * _Nullable personalizationFailure;
/// Authentication base URL
/// Ensure <code>personalized</code> / <code>personalizationFailure</code> set before setting this property
@property (nonatomic, copy) NSURL * _Nullable baseAuthURL;
@property (nonatomic, copy) NSURL * _Nullable baseURL;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
/// Method dedicated for endpoint unregister
- (void)sendPersonalizedEventsImmediately;
@end

enum State : NSInteger;
@protocol LegacyStateMachineDelegateProtocol;
enum ReaderModuleType : NSInteger;

SWIFT_CLASS("_TtC17SeosMobileKeysSDK23LegacyReaderModuleState")
@interface LegacyReaderModuleState : NSObject
@property (nonatomic) enum State state;
- (nonnull instancetype)initWithDelegate:(id <LegacyStateMachineDelegateProtocol> _Nonnull)delegate initialState:(enum State)initialState readerModuleType:(enum ReaderModuleType)readerModuleType queue:(dispatch_queue_t _Nonnull)queue OBJC_DESIGNATED_INITIALIZER;
- (BOOL)allowTransitionTo:(enum State)to from:(enum State)from SWIFT_WARN_UNUSED_RESULT;
- (void)didTransitionTo:(enum State)to from:(enum State)from;
- (NSString * _Nonnull)toString SWIFT_WARN_UNUSED_RESULT;
- (NSString * _Nonnull)textWithState:(enum State)state SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

@class SeosFileSystem;
@class NSData;

SWIFT_CLASS("_TtC17SeosMobileKeysSDK30LegacySeosFileSystemDataFormat")
@interface LegacySeosFileSystemDataFormat : NSObject
@property (nonatomic) uint32_t endOfData;
@property (nonatomic, strong) SeosFileSystem * _Nonnull seosFileSystem;
- (nonnull instancetype)initWithSeosFileSystem:(SeosFileSystem * _Nonnull)seosFileSystem OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithRawData:(NSData * _Nonnull)rawData OBJC_DESIGNATED_INITIALIZER;
- (NSData * _Nonnull)exportToLegacyDataFormat SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_PROTOCOL("_TtP17SeosMobileKeysSDK34LegacyStateMachineDelegateProtocol_")
@protocol LegacyStateMachineDelegateProtocol
- (void)didTransitionFromTo:(enum State)to from:(enum State)from;
@end


SWIFT_CLASS("_TtC17SeosMobileKeysSDK15NSAPIInfoBridge")
@interface NSAPIInfoBridge : NSObject
- (nullable instancetype)initWithRegion:(Region)region environment:(EnvironmentType)environment error:(NSError * _Nullable * _Nullable)error OBJC_DESIGNATED_INITIALIZER;
- (id _Nullable)valueForKey:(NSString * _Nonnull)key withError:(NSError * _Nullable * _Nullable)error SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC17SeosMobileKeysSDK15NVRamByteWriter")
@interface NVRamByteWriter : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC17SeosMobileKeysSDK27NewSeosFileSystemDataFormat")
@interface NewSeosFileSystemDataFormat : NSObject
@property (nonatomic) uint32_t endOfData;
@property (nonatomic, strong) SeosFileSystem * _Nonnull seosFileSystem;
- (nonnull instancetype)initWithSeosFileSystem:(SeosFileSystem * _Nonnull)seosFileSystem OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithRawData:(NSData * _Nonnull)rawData OBJC_DESIGNATED_INITIALIZER;
- (NSData * _Nonnull)exportToVersion3DataFormat SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

@class ReaderRepository;
@class MobileKeysReader;
@class TriggerResult;

SWIFT_CLASS("_TtC17SeosMobileKeysSDK24OpeningTriggerController")
@interface OpeningTriggerController : NSObject
- (nonnull instancetype)initWithRepository:(ReaderRepository * _Nonnull)repository OBJC_DESIGNATED_INITIALIZER;
- (TriggerResult * _Nonnull)rssiTriggerWithReader:(MobileKeysReader * _Nonnull)reader SWIFT_WARN_UNUSED_RESULT;
/// This trigger handles the case where a reader connects to the phone. We assume that
/// The reader handles RSSi calculations
- (TriggerResult * _Nonnull)readerConnectedTriggerWithReader:(MobileKeysReader * _Nonnull)reader SWIFT_WARN_UNUSED_RESULT;
- (TriggerResult * _Nonnull)userActionClosestReaderWithType:(MobileKeysOpeningType)type SWIFT_WARN_UNUSED_RESULT;
- (TriggerResult * _Nonnull)specificReaderWithReader:(MobileKeysReader * _Nonnull)reader type:(MobileKeysOpeningType)type checkSystemWideEnabledOpeningModes:(BOOL)checkSystemWideEnabledOpeningModes SWIFT_WARN_UNUSED_RESULT;
- (void)setSupportedOpeningTypesWithTypes:(NSArray<NSNumber *> * _Nonnull)types;
- (BOOL)supportsOpeningTypeWithType:(MobileKeysOpeningType)type SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

typedef SWIFT_ENUM(NSInteger, OpeningType, open) {
  OpeningTypeTap = 0,
  OpeningTypeTwistAndGo = 1,
  OpeningTypeSeamless = 2,
  OpeningTypeUserInitiated = 3,
  OpeningTypeEnhancedTap = 4,
};


SWIFT_CLASS("_TtC17SeosMobileKeysSDK22PersonalizationFailure")
@interface PersonalizationFailure : NSObject
- (nonnull instancetype)initWithInviteCode:(NSString * _Nonnull)inviteCode baseURL:(NSURL * _Nullable)baseURL OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


@class MobileKeysEndpointInfo;

SWIFT_CLASS("_TtC17SeosMobileKeysSDK12Personalized")
@interface Personalized : NSObject
- (nonnull instancetype)initWithEndpointInfo:(MobileKeysEndpointInfo * _Nonnull)endpointInfo accessToken:(NSString * _Nonnull)accessToken OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC17SeosMobileKeysSDK16PreconditionUtil")
@interface PreconditionUtil : NSObject
+ (void)preconditionCheck:(BOOL)condition message:(NSString * _Nullable)message;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC17SeosMobileKeysSDK6Reader")
@interface Reader : NSObject
- (nonnull instancetype)initWithUuid:(NSString * _Nonnull)uuid OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

typedef SWIFT_ENUM(NSInteger, ReaderCapabilities, open) {
  ReaderCapabilitiesAdvertising = 0,
  ReaderCapabilitiesConnecting = 1,
};

typedef SWIFT_ENUM(NSInteger, ReaderModuleType, open) {
  ReaderModuleTypeBleScanner = 0,
  ReaderModuleTypeBleAdvertiser = 1,
};


SWIFT_CLASS("_TtC17SeosMobileKeysSDK16ReaderRepository")
@interface ReaderRepository : NSObject
- (nonnull instancetype)initWithClock:(id <Clock> _Nonnull)clock OBJC_DESIGNATED_INITIALIZER;
- (MobileKeysReader * _Nullable)closestReader SWIFT_WARN_UNUSED_RESULT;
- (MobileKeysReader * _Nullable)closestActivePeripheralForOpeningTypeWithType:(MobileKeysOpeningType)type SWIFT_WARN_UNUSED_RESULT;
- (MobileKeysReader * _Nullable)closestPeripheralForOpeningTypeWithType:(MobileKeysOpeningType)type enforceTimeout:(BOOL)enforceTimeout SWIFT_WARN_UNUSED_RESULT;
- (BOOL)hasPeripheralsForOpeningTypeWithType:(MobileKeysOpeningType)type SWIFT_WARN_UNUSED_RESULT;
- (void)addRssiWithReader:(MobileKeysReader * _Nonnull)reader rssi:(NSInteger)rssi;
- (void)updateOrSaveWithReader:(MobileKeysReader * _Nonnull)reader;
- (MobileKeysReader * _Nullable)findReaderWithUuid:(NSString * _Nonnull)uuid SWIFT_WARN_UNUSED_RESULT;
- (void)removeReaderWithUuid:(NSString * _Nonnull)uuid;
- (NSArray<MobileKeysReader *> * _Nonnull)listAllActiveReaders SWIFT_WARN_UNUSED_RESULT;
- (void)removeInactiveReadersWithCallback:(void (^ _Nonnull)(MobileKeysReader * _Nonnull))callback;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end



SWIFT_CLASS("_TtC17SeosMobileKeysSDK15RssiMeasurement")
@interface RssiMeasurement : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC17SeosMobileKeysSDK14SeosFileSystem")
@interface SeosFileSystem : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (NSString * _Nonnull)toString SWIFT_WARN_UNUSED_RESULT;
- (NSString * _Nonnull)toShortString SWIFT_WARN_UNUSED_RESULT;
- (BOOL)isEmpty SWIFT_WARN_UNUSED_RESULT;
@end


@interface SeosFileSystem (SWIFT_EXTENSION(SeosMobileKeysSDK))
- (BOOL)isEqual:(id _Nullable)object SWIFT_WARN_UNUSED_RESULT;
@end


SWIFT_CLASS("_TtC17SeosMobileKeysSDK19SeosNvramDataFormat")
@interface SeosNvramDataFormat : NSObject
@property (nonatomic) uint32_t endOfData;
@property (nonatomic, strong) SeosFileSystem * _Nonnull seosFileSystem;
- (nonnull instancetype)initWithSeosFileSystem:(SeosFileSystem * _Nonnull)seosFileSystem OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithRawData:(NSData * _Nonnull)rawData OBJC_DESIGNATED_INITIALIZER;
- (NSData * _Nonnull)exportTo32x32 SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC17SeosMobileKeysSDK16SeosSystemEeprom")
@interface SeosSystemEeprom : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


@interface SeosSystemEeprom (SWIFT_EXTENSION(SeosMobileKeysSDK))
- (BOOL)isEqual:(id _Nullable)object SWIFT_WARN_UNUSED_RESULT;
@end

typedef SWIFT_ENUM(NSInteger, State, open) {
  StateIDLE = 0,
  StateTRYINGTOSTART = 1,
  StateSTARTED = 2,
  StateADVERTISING = 3,
  StateSCANNING = 4,
  StateCONNECTING = 5,
  StateCONNECTED = 6,
  StateSERVICE_DISCOVERY = 7,
  StateSERVICES_DISCOVERED = 8,
  StateCHARACTERISTIC_DISCOVERY = 9,
  StateCHARACTERISTICS_DISCOVERED = 10,
  StateDATA_TRANSFER = 11,
  StateDISCONNECTING = 12,
  StateDISCONNECTED = 13,
};

enum TriggerStatus : NSInteger;

SWIFT_CLASS("_TtC17SeosMobileKeysSDK13TriggerResult")
@interface TriggerResult : NSObject
@property (nonatomic, strong) MobileKeysReader * _Nullable reader;
@property (nonatomic) MobileKeysOpeningType openingType;
@property (nonatomic) enum TriggerStatus status;
@property (nonatomic, readonly) BOOL success;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

typedef SWIFT_ENUM(NSInteger, TriggerStatus, open) {
  TriggerStatusSuccess = 0,
  TriggerStatusUnsupportedOpeningType = 1,
  TriggerStatusNoReaderInRange = 2,
  TriggerStatusReaderInTimeout = 3,
  TriggerStatusReaderNotFound = 4,
  TriggerStatusReaderNotActive = 5,
  TriggerStatusNoAction = 6,
};

#endif
#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#if defined(__cplusplus)
#endif
#pragma clang diagnostic pop
#endif

#else
#error unsupported Swift architecture
#endif
