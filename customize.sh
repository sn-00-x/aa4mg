#!/bin/bash

# Define "detect Volume key input" helper
chooseport() {
    [ -n "$1" ] && local DELAY=$1 || local DELAY=10
    [ "$2" = "YES" ] && local DEFAULT=$2 || local DEFAULT="NO"
    local START_TIMESTAMP=$(date +%s)
    local REMAINING_DELAY=$DELAY

    ui_print "Please answer within $DELAY seconds or $DEFAULT will be assumed."

    while [ "$REMAINING_DELAY" -gt 0 ]; do
        timeout ${REMAINING_DELAY}s /system/bin/getevent -lqc 1 2>&1 > $TMPDIR/events &
        wait $! 2>/dev/null # hide "Terminated" message
        if (`grep -q 'KEY_VOLUMEUP *DOWN' $TMPDIR/events`); then
            ui_print "Volume UP (+) = YES detected!"
            return 0 # 0 = True
        elif (`grep -q 'KEY_VOLUMEDOWN *DOWN' $TMPDIR/events`); then
            ui_print "Volume DOWN (-) = NO detected!"
            return 1 # 1 = False
        fi
        REMAINING_DELAY=$(($START_TIMESTAMP + $DELAY - $(date +%s)))
    done

    ui_print "Volume key could not be detected..."
    if [ "$DEFAULT" = "YES" ] ; then
        ui_print "Volume UP (+) = YES assumed!"
        return 0 # 0 = True
    else
        ui_print "Volume DOWN (-) = NO assumed!"
        return 1 # 1 = False
    fi
}

INSTALLED_APPS=""

# Initialize installation
ui_print ""
ui_print "Installing AA dependency stubs for MicroG"
ui_print "+ XLauncher Unlocked..."
ui_print ""
ui_print "*** Please answer using volume keys ***"
ui_print "*** Volume UP (+)   = YES           ***"
ui_print "*** Volume DOWN (-) = NO            ***"

# Request if Fake Google Maps stub dependency should be installed
ui_print ""
ui_print "*** Install Fake Google Maps stub? ***"
ui_print "(a.k.a. com.google.android.apps.maps)"
ui_print ""
if chooseport 20 "NO"; then # 0 = True, why shell why..
    ui_print "Fake Google Maps stub will be installed on next reboot!"
    INSTALLED_APPS="Google Maps stub"
else
    rm -r "$MODPATH/system/product/app/Maps";
    ui_print "Excluded Fake Google Maps stub from installation..."
fi

# Request if Fake Google Speech Services stub dependency should be installed
ui_print ""
ui_print "*** Install Fake Google Speech Services stub? ***"
ui_print "(a.k.a. com.google.android.tts)"
ui_print ""
if chooseport 10 "NO"; then # 0 = True, why shell why..
    ui_print "Fake Google Speech Services stub will be installed on next reboot!"
    [ -n "$INSTALLED_APPS" ] && INSTALLED_APPS="$INSTALLED_APPS,"
    INSTALLED_APPS="${INSTALLED_APPS}Google Speech Services stub"
else
    rm -r "$MODPATH/system/product/app/GoogleTTS";
    ui_print "Excluded Fake Google Speech Services stub from installation..."
fi

# Request if Fake Google Search stub dependency should be installed
ui_print ""
ui_print "*** Install Fake Google Search stub? ***"
ui_print "(a.k.a. com.google.android.googlequicksearchbox)"
ui_print ""
if chooseport 10 "NO"; then # 0 = True, why shell why..
    ui_print "Fake Google Search stub will be installed on next reboot!"
    [ -n "$INSTALLED_APPS" ] && INSTALLED_APPS="$INSTALLED_APPS,"
    INSTALLED_APPS="${INSTALLED_APPS}Google Search stub"
else
    rm -r "$MODPATH/system/product/priv-app/Velvet";
    ui_print "Excluded Fake Google Search stub from installation..."
fi

# Ask for Android Auto - XLauncher Unlocked
ui_print ""
ui_print "*** Install Android Auto - XLauncher Unlocked? ***"
ui_print "*** Recommended for enabling 3rd party apps    ***"
ui_print ""
AAXLU="true"
if chooseport 10 "YES"; then
    ui_print "Android Auto - XLauncher Unlocked will be installed on next reboot!"
    [ -n "$INSTALLED_APPS" ] && INSTALLED_APPS="$INSTALLED_APPS,"
    INSTALLED_APPS="${INSTALLED_APPS}Android Auto - XLauncher Unlocked"
else
    rm -r "$MODPATH/system/product/app/XLauncherUnlocked";
    ui_print "Excluded Android Auto - XLauncher Unlocked from installation..."
    AAXLU="false"
fi

# Setup "vanilla" phenotype.db SQLite database, pre-patched with AA-Tweaker.
# Used to make Android Auto + apps work correctly, can be patched further with AA-Tweaker / manually.
ui_print ""

GMS_PATH=/data/data/com.google.android.gms/
PHENOTYPE_DB_PATH="$GMS_PATH"databases/
COPY_PHENOTYPE_DB="true"

if [ -f "${PHENOTYPE_DB_PATH}/phenotype.db" ] ; then
    ui_print "*** Overwrite pre-existing phenotyope.db? ***"
    ui_print ""
    if chooseport 10 "NO"; then
        ui_print "Overwriting phenotype.db"
    else
        ui_print "Keeping pre-existing phenotype.db"
        COPY_PHENOTYPE_DB="false"
    fi
fi

if [ "$COPY_PHENOTYPE_DB" = "true" ] ; then
  ui_print "Creating initial 'phenotype.db'..."

  GMS_OWNER=$(stat -c '%U' "$GMS_PATH")
  GMS_GROUP=$(stat -c '%G' "$GMS_PATH")

  # Create the folder if missing + Inject the phenotype.db file
  mkdir -p "$PHENOTYPE_DB_PATH"
  cp "$MODPATH""$PHENOTYPE_DB_PATH"phenotype.db \
      "$PHENOTYPE_DB_PATH"phenotype.db

  # Restore correct ownership
  chown -R "$GMS_OWNER" "$PHENOTYPE_DB_PATH"
  chgrp -R "$GMS_GROUP" "$PHENOTYPE_DB_PATH"
fi

if [ ! -f "${PHENOTYPE_PB_PATH}com.google.android.projection.gearhead.pb" ] ; then
    # Setup "vanilla" com.google.android.projection.gearhead.pb binary file.
    # CoolWalk requirement, file cannot be modified..
    ui_print "Setting up additional dependencies..."
    AA_PATH=/data/data/com.google.android.projection.gearhead/
    AA_OWNER=$(stat -c '%U' "$AA_PATH")
    AA_GROUP=$(stat -c '%U' "$AA_PATH")
    PHENOTYPE_PB_PATH="$AA_PATH"files/phenotype/shared/

    # Create the folder if missing + Inject the binary .pb file
    mkdir -p "$PHENOTYPE_PB_PATH"
    cp "$MODPATH""$PHENOTYPE_PB_PATH"com.google.android.projection.gearhead.pb \
        "$PHENOTYPE_PB_PATH"com.google.android.projection.gearhead.pb

    # Restore correct ownership
    chown -R "$AA_OWNER" "$AA_PATH"files/
    chgrp -R "$AA_GROUP" "$AA_PATH"files/
fi

# Finish installation, dependency APKs will automatically be installed on reboot
ui_print ""
ui_print "Installation of"
ui_print "    Android Auto 4 MicroG"
IFS=','
for INSTALLED_APP in $INSTALLED_APPS ; do
    ui_print "    $INSTALLED_APP"
done
ui_print "successfull! 🎉"
ui_print ""
ui_print "*** Please re-boot your device,                      ***"
ui_print "*** and then update Android Auto (e.g. with Aurora)! ***"
ui_print ""
if [ $AAXLU = "true" ] ; then
    ui_print "*** Please also have a look at the README            ***"
    ui_print "*** for instructions on how to activate              ***"
    ui_print "*** XLauncher Unlocked's XPosed module               ***"
fi
ui_print ""
ui_print ""
ui_print ""


