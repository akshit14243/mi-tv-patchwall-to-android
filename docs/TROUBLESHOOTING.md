# Troubleshooting & FAQ

Encountering an issue while upgrading your Xiaomi Mi TV? Follow the tested solutions below.

---

### 1. The TV Boots Normally into PatchWall Instead of Recovery
* **Cause:** Button combo was released too early, remote signal was blocked, or the remote was disconnected.
* **Fix:**
  1. Make sure you point the remote directly at the IR/Bluetooth receiver (near the center Mi logo on the bottom bezel).
  2. Hold **`Home` + `Menu`** buttons firmly BEFORE plugging the power cable into the socket.
  3. Keep holding BOTH buttons without letting go until you see the Mi logo appear and the recovery animation begins.
  4. If your remote does not respond via Bluetooth at boot, use an IR Mi remote or hold the physical button underneath the TV power LED simultaneously.

---

### 2. "Signature Verification Failed" or "Installation Aborted"
* **Cause:** Corrupted download or mismatched board codename (e.g. attempting to flash a `dangal` board with a `magnolia` package).
* **Fix:**
  1. **Check Hardware Board:** Sideload **AIDA64** via Aptoide TV or USB. Navigate to **System**. Verify that **Device** and **Board** are strictly `magnolia`.
  2. If AIDA64 reports `dangal` or `dangalUHD` (common on Mi TV 4A Pro / 4C Pro models), **STOP IMMEDIATELY**. Flashing this package will brick your display.
  3. Verify that the ZIP file size is exactly `795,256,952 bytes` (~758 MB). If it is smaller, redownload the complete package.
  4. Do **not** extract or alter files inside the ZIP archive.

---

### 3. USB Drive Not Detected ("Can't mount /udisk")
* **Cause:** Incorrect file system or partition layout.
* **Fix:**
  1. The USB drive **must be formatted to FAT32**. NTFS, exFAT, and macOS formats are NOT supported by stock recovery.
  2. Partition table must be **MBR** (Master Boot Record), not GPT.
  3. Try using a USB 2.0 drive under 32 GB.
  4. If your TV has multiple USB ports, plug into the **USB 1 / top port**.

---

### 4. TV Stuck at Boot Loop on the Mi Logo After Flashing
* **Cause:** Old cache or user data conflicts between Android 6 and Android TV 9.
* **Fix:**
  1. Open your `xiaomi_update-magnolia` file on your PC.
  2. Add `--wipe_data` on a new line:
     ```text
     --update_package=/udisk/update-magnolia_p_rel_190830r2854-3698-user.zip
     --wipe_data
     ```
  3. Re-run the recovery process. This performs a clean factory reset alongside the installation.
