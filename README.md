# Android Auto 4 microG (for A12)

This is a Magisk module that adds Android Auto to de-googled devices running microG on Android 12. Tested under LineageOS 4 microG 19.1 only, but should run on all Android 12 devices.

## Warning

If you update Android Auto app through Aurora, double check to uninstall it through Aurora (or rather downgrade to the version shipped by this module), before uninstalling/disabling aa4mg or boot without Magisk!

Otherwise you may end up with an unbootable device. If the system app is missing (by disabling aa4mg or booting without Magisk), but the update installed by Aurora is still present, your device may fail to boot due to permission errors!

## Installation

- Install [LineageOS for microG](https://lineage.microg.org/)
- Install [Magisk](https://github.com/topjohnwu/Magisk/)
- Install this module through the Magisk Manager App
- Install [Google TTS](https://play.google.com/store/apps/details?id=com.google.android.tts)
- Install either [Google App Stub](https://git.sr.ht/~dylanger/Google-App-Stub) or the original [Google](https://play.google.com/store/apps/details?id=com.google.android.googlequicksearchbox)-app
- Optionally upgrade Android Auto through Aurora Store (see "Upgrade to current version" below)

## Upgrade to current version

This module ships with Android Auto 6.9.613724 (extracted from NikGapps) and can be upgraded through Aurora Store.

## First steps

When first using your device in your car, follow the usual flow on your head unit and device until you reach a page asking for location permissions for maps. Double check maps has permissions and click "cancel". If nothing happens, unplug and replug your device. When asked for, grant all permissions. In case you encounter an error "Communication error 17", manually open Settings and grant all available persmissions to the Android Auto app. Then unplug and replug your device.

Android Auto won't show apps not installed through Play Store. Since you most probably installed all your compatible apps through Aurora Store, they are missing in Android Auto. In the Android Auto interface on your head unit: select "Settings", scroll down, tap "See more in the phone app". On your phone: scroll down, tap version 10 times to become a developer, tap the three dots in the upper right corner and select "Developer Settings", then check "Unkown sources".

## Build

    zip aa4mg.zip -9r *

## Credits

- **Nikhil Menghani** for [NikGapps](https://nikgapps.com/)
