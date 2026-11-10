#!/usr/bin/env bash
# ==============================================================================
# Xiaomi Mi TV Recovery Command Generator
# Developed by Akshit Saini (@akshit14243)
# ==============================================================================

TARGET_DIR="${1:-.}"
ZIP_NAME="${2:-update-magnolia_p_rel_190830r2854-3698-user.zip}"
WIPE_DATA="${3:-false}"

echo "=========================================================="
echo " Xiaomi Mi TV Recovery Command Generator"
echo " Developed by Akshit Saini (@akshit14243)"
echo "=========================================================="
echo " Target Directory : ${TARGET_DIR}"
echo " Firmware Package : /udisk/${ZIP_NAME}"
echo " Wipe Data Option : ${WIPE_DATA}"
echo ""

COMMAND="--update_package=/udisk/${ZIP_NAME}"
if [ "${WIPE_DATA}" = "true" ] || [ "${WIPE_DATA}" = "wipe" ]; then
    COMMAND="${COMMAND}\n--wipe_data"
fi

printf "%b\n" "${COMMAND}" > "${TARGET_DIR}/xiaomi_update-magnolia"

echo "[+] Created: ${TARGET_DIR}/xiaomi_update-magnolia"
echo ""
echo "Done! Copy your firmware zip and these files to the root of your FAT32 USB drive."
