# Technical Firmware Details: Xiaomi Mi TV 4A (Magnolia)

This document contains reverse-engineered technical specifications and metadata extracted directly from the official OTA build package.

---

## Hardware & Target Board
* **Device Codename:** `magnolia`
* **Applicable Models:** 
  * Xiaomi Mi TV 4A 32-inch (L32M5-AL / L32M5-AI)
  * Xiaomi Mi TV 4A 43-inch (L43M5-AL / L43M5-AI)
  * Related regional PatchWall variants (Indian / Global 2018-2019 editions)
* **Incompatible Board Variants (DO NOT FLASH):**
  * `dangal` / `dangalUHD` (Mi TV 4A Pro / 4C Pro series)
  * `pulpfiction` / `matrix` (Mi TV 4 / 4 Pro series)
* **Processor Architecture:** Amlogic T962X / T962E Cortex-A53 Quad-Core
* **Original OS:** Android 6.0.1 Marshmallow (PatchWall 1.x / 2.x)
* **Upgraded OS:** **Android TV 9.0 Pie (SDK 28)**

---

## Build Metadata (`META-INF/com/android/metadata`)
```ini
ota-property-files=metadata:69:273
ota-required-cache=0
ota-type=BLOCK
post-build=Xiaomi/magnolia/magnolia:9/PI/3698:user/release-keys
post-build-incremental=3698
post-sdk-level=28
post-security-patch-level=2022-01-05
post-timestamp=1648107295
pre-device=magnolia
```

---

## File Verification & Integrity
* **File Name:** `update-magnolia_p_rel_190830r2854-3698-user.zip`
* **File Size:** `795,256,952 bytes` (~758.4 MB)
* **Official Release Keys:** Signed with official `Xiaomi release-keys` (validates against stock recovery cryptographic check).

---

## Why the Recovery Trigger is Required
Stock Xiaomi recovery on the `magnolia` platform runs in a locked batch execution mode when triggered via hardware button combinations. Instead of launching an interactive UI file explorer, the recovery daemon checks the root of `/udisk` (the mounted USB flash drive) for:
1. `xiaomi_update-magnolia`
2. `xiaomi_update`

The recovery daemon passes the arguments inside this file to `update_package` automatically:
```text
--update_package=/udisk/update-magnolia_p_rel_190830r2854-3698-user.zip
```
