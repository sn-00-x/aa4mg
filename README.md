# Android Auto 4 microG (for A13)

This is a Magisk module that adds AA (Android Auto) to de-googled devices running microG on Android 13!   
Tested under LineageOS 20 only, but should run on all Android 13 devices.
*(See [here](https://github.com/sn-00-x/aa4mg/branches) for other Android versions)*

## Warning

**Before uninstalling `aa4mg`,**   
Settings => Apps => See all apps => Android Auto => Triple dot icon *(top right corner)* => Uninstall updates

**Otherwise you may end up with an un-boot-able device.**   
If the AA system app is missing *(by disabling `aa4mg` or booting without Magisk)*,   
but the AA update installed is still present,   
your device may fail to boot due to permission errors!

## Installation

1. Install [LineageOS for microG](https://lineage.microg.org/)
2. Install [Magisk](https://github.com/topjohnwu/Magisk/)
3. Install the dependencies for AA, choose one of either options for each dependency:   
    - **As empty / stub APKs**:   
        Install the APKs included in the [`stubs`](https://github.com/sn-00-x/aa4mg/tree/master/stubs) folder of this repo,   
        use [King Installer](https://github.com/Rikj000/KingInstaller) to "install as Google Play Store".
        - [Fake Google](https://github.com/sn-00-x/aa4mg/raw/master/stubs/Google-Stub-2022-01-29-SolidHal.apk)
        - [Fake Google Speech Services / TTS](https://github.com/sn-00-x/aa4mg/raw/master/stubs/Google-Speech-Services-Stub-2022-01-29-SolidHal.apk)
        - [Fake Google Maps](https://github.com/sn-00-x/aa4mg/raw/master/stubs/Google-Maps-Stub-v2100000000-Rikj000.apk)
    - **As full / official APKs**:   
        Install through [Aurora Store](https://gitlab.com/AuroraOSS/AuroraStore),   
        use `Root installer` as installation method to "install as Google Play Store".
        - [Google](https://play.google.com/store/apps/details?id=com.google.android.googlequicksearchbox)
        - [Google Speech Services / TTS](https://play.google.com/store/apps/details?id=com.google.android.tts)
        - [Google Maps](https://play.google.com/store/apps/details?id=com.google.android.apps.maps)
    - Feel free to freeze these dependencies through [Hail](https://github.com/aistra0528/Hail).
4. Install [Android Auto](https://play.google.com/store/apps/details?id=com.google.android.projection.gearhead) through [Aurora Store](https://gitlab.com/AuroraOSS/AuroraStore),   
    use `Root installer` as installation method to "install as Google Play Store".
5. Install the [aa4mg](https://github.com/sn-00-x/aa4mg) module through the Magisk Manager App => Reboot
6. Settings => Connected Devices => Connection Preferences => Android Auto
    - Scroll down => Tap `Version` 10 times => Accept PopUp to become a developer
    - Triple dot icon *(top right corner)* => Developer Settings
        - Application Mode => Developer
        - Scroll down => Check `Unknown Resources`

## Updates

Once the installation is complete, [Android Auto](https://play.google.com/store/apps/details?id=com.google.android.projection.gearhead) can be updated through [Aurora Store](https://gitlab.com/AuroraOSS/AuroraStore).

## Uninstall

1. Settings => Apps => See all apps => Android Auto => Triple dot icon *(top right corner)* => Uninstall updates
2. Magisk => Modules => Remove "Android Auto 4 microG" => Reboot

## First steps

When first using your device in your car,   
follow the usual flow on your head unit and device until you reach a page asking for location permissions for maps.   
Double check maps has permissions and click "cancel".   

If nothing happens, unplug and re-plug your device.   
When asked for, grant all permissions.   

In case you encounter an error "Communication error 17",   
manually open Settings and grant all available permissions to the Android Auto app.   
Then unplug and re-plug your device.

## 3th party apps

#### Android Auto won't show apps not installed through Google Play Store.
To mitigate this, first un-install the app, then you can use following ways to "install as Google Play Store".

- **Play Store APKs**: Use [Aurora Store](https://gitlab.com/AuroraOSS/AuroraStore) + `Root installer` as the installation method, works for single + split APKs.
- **Non Play Store APKs**: Use [King Installer](https://github.com/Rikj000/KingInstaller), works for single APK.
- Or use **direct ADB install**, works for single APK:   
    ```bash
    pm install -i "com.android.vending" <apk>
    ```

#### Android Auto still won't show some apps.
Some apps have additional restrictions applied on them by AA,   
which leads to them still not showing up, even if "installed as Google Play Store".

To unlock these apps use [Android Auto - Xposed Unlocked](https://github.com/Rikj000/Android-Auto-Xposed-Unlocked)

## Can not open Android Auto
If you can not directly open the AA app after installation,   
then you can still access the AA settings through either of below ways:

- Settings => Connected Devices => Connection Preferences => Android Auto
- Install the [Android Auto for phone screens](https://github.com/sn-00-x/aa4mg/raw/development/stubs/Android-Auto-for-phone-screens-v1.1.apk) `.apk` included in the [`stubs`](https://github.com/sn-00-x/aa4mg/tree/master/stubs) folder of this repo,   
use [King Installer](https://github.com/Rikj000/KingInstaller) to "install as Google Play Store", then launch AA through this app.

## Build

```bash
zip aa4mg.zip -9r * -x "stubs/*"
```

## Credits

- **Nikhil Menghani** for [NikGapps](https://nikgapps.com/)
- **[@braga2](https://github.com/braga2)** for his [tutorial on xda](https://forum.xda-developers.com/t/microg-android-auto-fully-working.4319159/page-6)
- **[@SolidHal](https://github.com/SolidHal)** for the initial [dependency stub APKs](https://github.com/SolidHal/android-auto-stub)