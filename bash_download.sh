#!/bin/bash

# Script: download_oracle_patch.sh
# Doel: Alleen de patch voor een specifieke versie downloaden via AutoUpgrade

# Zet hier je gewenste target versie
TARGET_VERSION="19.20"

# Pad naar AutoUpgrade JAR
AUTOUPGRADE_JAR="/home/stefan/mijn_ansible1/autoupgrade.jar"

# Uitvoeren van de patch-download
echo "➡️ Start patch download voor Oracle $TARGET_VERSION"

java -jar "$AUTOUPGRADE_JAR" -patch download -target_version "$TARGET_VERSION"

RC=$?
if [ $RC -eq 0 ]; then
    echo "✅ Patch download succesvol afgerond."
else
    echo "❌ Fout tijdens patch download (exit code $RC)."
    exit $RC
fi

