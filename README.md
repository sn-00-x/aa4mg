# Android Auto 4 microG (for A13)

This is a Magisk module that adds Android Auto to de-googled devices running microG on Android 13 (see [here](https://github.com/sn-00-x/aa4mg/branches) for other versions). Tested under LineageOS 20 only, but should run on all Android 13 devices.

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

## First steps

When first using your device in your car, follow the usual flow on your head unit and device until you reach a page asking for location permissions for maps. Double check maps has permissions and click "cancel". If nothing happens, unplug and replug your device. When asked for, grant all permissions. In case you encounter an error "Communication error 17", manually open Settings and grant all available persmissions to the Android Auto app. Then unplug and replug your device.

Android Auto won't show apps not installed through Play Store. Since you most probably installed all your compatible apps through Aurora Store, they are missing in Android Auto. In the Android Auto interface on your head unit: select "Settings", scroll down, tap "See more in the phone app". On your phone: scroll down, tap version 10 times to become a developer, tap the three dots in the upper right corner and select "Developer Settings", then check "Unkown sources".

## Build

    zip aa4mg.zip -9r *

## Credits

- **Nikhil Menghani** for [NikGapps](https://nikgapps.com/)
- **[@braga2](https://github.com/braga2)** for his [tutorial on xda](https://forum.xda-developers.com/t/microg-android-auto-fully-working.4319159/page-6)
