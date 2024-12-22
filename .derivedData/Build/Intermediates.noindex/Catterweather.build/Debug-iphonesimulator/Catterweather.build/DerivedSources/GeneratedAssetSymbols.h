#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The resource bundle ID.
static NSString * const ACBundleID AC_SWIFT_PRIVATE = @"catterwaul.Catterweather";

/// The "Card Background" asset catalog color resource.
static NSString * const ACColorNameCardBackground AC_SWIFT_PRIVATE = @"Card Background";

/// The "Primary Text" asset catalog color resource.
static NSString * const ACColorNamePrimaryText AC_SWIFT_PRIVATE = @"Primary Text";

/// The "Secondary Text" asset catalog color resource.
static NSString * const ACColorNameSecondaryText AC_SWIFT_PRIVATE = @"Secondary Text";

/// The "Tertiary Text" asset catalog color resource.
static NSString * const ACColorNameTertiaryText AC_SWIFT_PRIVATE = @"Tertiary Text";

#undef AC_SWIFT_PRIVATE
