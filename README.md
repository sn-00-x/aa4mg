# Android Auto 4 MicroG (for A11, A12, A13, A14)

This is a [Magisk](https://topjohnwu.github.io/Magisk/) module that provides an AA (Android Auto) stub as system app, optionally together with [XLauncher Unlocked](https://github.com/Rikj000/Android-Auto-XLauncher-Unlocked) and stubs for Google TTS, Google Maps & Google Search.
It is intended to be used on de-googled devices running MicroG!

If you instead prefer a non-root solution to be built into your own rom, please have a look at [Android Auto as user app with media apps support](https://github.com/sn-00-x/android-auto)

## Warning

**Before uninstalling `aa4mg`,**   
Settings => Apps => See all apps => Android Auto => Triple dot icon *(top right corner)* => Uninstall updates

**Otherwise you may end up with an un-boot-able device.**   
If the AA system app is missing *(by disabling `aa4mg` or booting without Magisk)*,   
but the AA update installed is still present,   
your device may fail to boot due to permission errors!

## Installation

1. Install de-googled ROM with microG (for example [LineageOS for MicroG](https://lineage.microg.org/))
2. Install [Magisk](https://topjohnwu.github.io/Magisk/install.html)
3. Install the [aa4mg](https://github.com/sn-00-x/aa4mg/releases) module through the Magisk Manager App => Reboot
    *(Select the desired dependency stubs with the volume keys during the installation process)*
4. Install [Android Auto](https://play.google.com/store/apps/details?id=com.google.android.projection.gearhead) through [Aurora Store](https://gitlab.com/AuroraOSS/AuroraStore),   
    use `Root installer` as installation method to "install as Google Play Store".   
    *(You can also install through your Package Manager if Aurora doesn't work, not preferred as it does not "install as Google Play Store")*
5. Settings => Apps => See all apps => Android Auto => Mobile data & Wi-Fi => UnCheck all
6. Settings => Notifications => Device & app notifications => Android Auto => Check `Allow notification access` => Ok *(**Settings will still be restricted!**)*
7. Settings => Apps => See all apps => Android Auto => Triple dot icon => Allow restricted settings
8. Settings => Notifications => Device & app notifications => Android Auto => Check `Allow notification access` => Allow
9. Settings => Connected Devices => Connection Preferences => Android Auto
    - System => UnCheck `Google Analytics`
    - About => Tap `Version` a lot => Accept PopUp to become a developer
    - Triple dot icon *(top right corner)* => Developer Settings
        - Application Mode => Developer
        - Scroll down => Check `Unknown Resources`
    - Close app

## Updates

Once the installation is complete:
- [Android Auto](https://play.google.com/store/apps/details?id=com.google.android.projection.gearhead) can be updated through [Aurora Store](https://gitlab.com/AuroraOSS/AuroraStore).
- [aa4mg](https://github.com/sn-00-x/aa4mg) can be updated through Magisk Manager

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

## 3rd party apps

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

To unlock these apps we'll use the Xposed module, included by [Android Auto - XLauncher Unlocked](https://github.com/Rikj000/Android-Auto-XLauncher-Unlocked)

1. Magisk => Settings => Magisk => Check `Zygisk`
2. Install [LSPosed (Zygisk) + Shamiko](https://lsposed.org/)
3. LSPosed => Modules => Android Auto - XLauncher Unlocked
    - Check `Enable module`
    - Check `Android Auto`
4. Reboot

## Can not open Android Auto
If you can not directly open the AA app after installation,   
then you can still access the AA settings through either of below ways:

- Settings => Connected Devices => Connection Preferences => Android Auto
- [Android Auto - XLauncher Unlocked](https://github.com/Rikj000/Android-Auto-XLauncher-Unlocked) => Click 
    - Check `Set the next used launch option as default`
    - Click `Classic` or `Material3` *(Choose which you prefer)*

## Build

```bash
zip aa4mg.zip -9r *
```

## Credits

- **Nikhil Menghani** for [NikGapps](https://nikgapps.com/)
- **[@braga2](https://github.com/braga2)** for his [tutorial on xda](https://forum.xda-developers.com/t/microg-android-auto-fully-working.4319159/page-6)
- **[@SolidHal](https://github.com/SolidHal)** for the initial [dependency stub APKs](https://github.com/SolidHal/android-auto-stub)
- **[@Rikj000](https://github.com/Rikj000)** for [Android Auto - XLauncher Unlocked](https://github.com/Rikj000/Android-Auto-XLauncher-Unlocked)
