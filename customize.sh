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

ui_print "Installing aa4mg..."

cp $MODPATH/data/data/com.google.android.gms/databases/phenotype.db /data/data/com.google.android.gms/databases/phenotype.db
cp $MODPATH/data/data/com.google.android.projection.gearhead/files/phenotype/shared/com.google.android.projection.gearhead.pb /data/data/com.google.android.projection.gearhead/files/phenotype/shared/com.google.android.projection.gearhead.pb
