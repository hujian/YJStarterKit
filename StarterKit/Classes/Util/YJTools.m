#import "YJTools.h"
#import <AdSupport/AdSupport.h>

@implementation YJTools


+ (BOOL) isValidateMobile:(NSString *)mobile
{
    NSString * phoneRegex = @"^1(3[0-9]|4[57]|5[0-35-9]|(7[0[059]|6｜7｜8])|8[0-9])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (NSString*)vendorID {
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}

+ (NSString *)cachedVendorID {
    static NSString* uuid_saving_string = @"bocai_uuid_saving_string";
    NSString* uuid = [[NSUserDefaults standardUserDefaults] objectForKey:uuid_saving_string];
    if (uuid == nil) {
        uuid = [UIDevice currentDevice].identifierForVendor.UUIDString;
        [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:uuid_saving_string];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return uuid;
}

+ (NSString *)UUID {
    return [[NSUUID UUID] UUIDString];;
}

+ (NSString *)IDFA {
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    if (!idfa) {
        idfa = @"empty";
    }
    return idfa;
}

+ (NSString *)appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
}

+ (NSString *)appBuild {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey];
}

+ (NSString *)deviceName {
    return [[UIDevice currentDevice] name];
}

+ (void)openSettingApp {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

@end
