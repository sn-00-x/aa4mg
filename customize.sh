#!/bin/bash

# Define "detect Volume key input" helper
chooseport() {
    [ "$1" ] && local delay=$1 || local delay=10
    local count=0
    while true; do
        timeout $delay /system/bin/getevent -lqc 1 2>&1 > $TMPDIR/events &
        sleep 0.5; count=$((count + 1))
        if (`grep -q 'KEY_VOLUMEUP *DOWN' $TMPDIR/events`); then
            ui_print "Volume UP (+) = YES detected!"
            return 0 # 0 = True, why shell why..
        elif (`grep -q 'KEY_VOLUMEDOWN *DOWN' $TMPDIR/events`); then
            ui_print "Volume DOWN (-) = NO detected!"
            return 1 # 1 = False, why shell why..
        fi
        [ $count -gt 20 ] && break
    done

    ui_print "Volume key could not be detected..."
    ui_print "Volume DOWN (-) = NO assumed!"
    return 1 # 1 = False, why shell why..
}

# Initialize installation
ui_print ""
ui_print "Installing AA dependency stubs for MicroG"
ui_print "+ XLauncher Unlocked..."
ui_print ""
ui_print " Volume UP (+) = YES"
ui_print " Volume DOWN (-) = NO"

# Request if Fake Google Maps stub dependency should be installed
ui_print ""
ui_print "Install Fake Google Maps stub?"
ui_print "(a.k.a. com.google.android.apps.maps)"
ui_print ""
if chooseport 0; then # 0 = True, why shell why..
    ui_print "Fake Google Maps stub will be installed on next reboot!"
else
    rm -r "$MODPATH/system/product/app/Maps";
    ui_print "Excluded Fake Google Maps stub from installation..."
fi

# Request if Fake Google Speech Services stub dependency should be installed
ui_print ""
ui_print "Install Fake Google Speech Services stub?"
ui_print "(a.k.a. com.google.android.tts)"
ui_print ""
if chooseport 0; then # 0 = True, why shell why..
    ui_print "Fake Google Speech Services stub will be installed on next reboot!"
else
    rm -r "$MODPATH/system/product/app/GoogleTTS";
    ui_print "Excluded Fake Google Speech Services stub from installation..."
fi

# Request if Fake Google Search stub dependency should be installed
ui_print ""
ui_print "Install Fake Google Search stub?"
ui_print "(a.k.a. com.google.android.googlequicksearchbox)"
ui_print ""
if chooseport 0; then # 0 = True, why shell why..
    ui_print "Fake Google Search stub will be installed on next reboot!"
else
    rm -r "$MODPATH/system/product/priv-app/Velvet";
    ui_print "Excluded Fake Google Search stub from installation..."
fi

cp $MODPATH/data/data/com.google.android.gms/databases/phenotype.db /data/data/com.google.android.gms/databases/phenotype.db
cp $MODPATH/data/data/com.google.android.projection.gearhead/files/phenotype/shared/com.google.android.projection.gearhead.pb /data/data/com.google.android.projection.gearhead/files/phenotype/shared/com.google.android.projection.gearhead.pb

# Finish installation, dependency APKs will automatically be installed on reboot
ui_print ""
ui_print "Installation of AA dependency stubs for MicroG"
ui_print "+ XLauncher Unlocked successfull! 🎉"
ui_print ""
ui_print "Please re-boot your device,"
ui_print "and then install the actual Android Auto app!"
ui_print ""
