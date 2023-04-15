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

# Setup "vanilla" phenotype.db SQLite database, pre-patched with AA-Tweaker.
# Used to make Android Auto + apps work correctly, can be patched further with AA-Tweaker / manually.
ui_print ""
ui_print "Creating initial 'phenotype.db'..."
GMS_PATH=/data/data/com.google.android.gms/
GMS_OWNER=$(stat -c '%U' "$GMS_PATH")
PHENOTYPE_DB_PATH="$GMS_PATH"databases/

# Create the folder if missing + Inject the phenotype.db file
mkdir -p "$PHENOTYPE_DB_PATH"
cp "$MODPATH""$PHENOTYPE_DB_PATH"phenotype.db \
    "$PHENOTYPE_DB_PATH"phenotype.db

# Restore correct ownership
chown -R "$GMS_OWNER" "$PHENOTYPE_DB_PATH"
chgrp -R "$GMS_OWNER" "$PHENOTYPE_DB_PATH"

# Setup "vanilla" com.google.android.projection.gearhead.pb binary file.
# CoolWalk requirement, file cannot be modified..
ui_print "Setting up additional dependencies..."
AA_PATH=/data/data/com.google.android.projection.gearhead/
AA_OWNER=$(stat -c '%U' "$AA_PATH")
PHENOTYPE_PB_PATH="$AA_PATH"files/phenotype/shared/

# Create the folder if missing + Inject the binary .pb file
mkdir -p "$PHENOTYPE_PB_PATH"
cp "$MODPATH""$PHENOTYPE_PB_PATH"com.google.android.projection.gearhead.pb \
    "$PHENOTYPE_PB_PATH"com.google.android.projection.gearhead.pb

# Restore correct ownership
chown -R "$AA_OWNER" "$AA_PATH"files/
chgrp -R "$AA_OWNER" "$AA_PATH"files/

# Finish installation, dependency APKs will automatically be installed on reboot
ui_print ""
ui_print "Installation of AA dependency stubs for MicroG"
ui_print "+ XLauncher Unlocked successfull! 🎉"
ui_print ""
ui_print "Please re-boot your device,"
ui_print "and then install the actual Android Auto app!"
ui_print ""
