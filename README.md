# Xiaomi Mi TV 4A (Magnolia): PatchWall to Official Android TV 9 Upgrade Guide

[![GitHub stars](https://img.shields.io/github/stars/akshit14243/mi-tv-patchwall-to-android?style=for-the-badge)](https://github.com/akshit14243/mi-tv-patchwall-to-android)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)
[![Device: Magnolia](https://img.shields.io/badge/Board-Magnolia%20(32%22%20%26%2043%22)-blue?style=for-the-badge)](docs/FIRMWARE_INFO.md)
[![Target OS: Android 9](https://img.shields.io/badge/Target%20OS-Android%20TV%209%20(Pie)-green?style=for-the-badge)](docs/FIRMWARE_INFO.md)

> **Authored & Reverse-Engineered by [Akshit Saini (@akshit14243)](https://github.com/akshit14243)**  
> Complete guide, reverse-engineered recovery automation scripts (`xiaomi_update-magnolia`), and step-by-step instructions to upgrade legacy Xiaomi Mi TVs running PatchWall (Android 6) to official **Android TV 9.0 (Pie)** with Google Play Store, Chromecast, and Google Assistant.

---

## 📺 Supported Devices

This update specifically targets the Xiaomi hardware board codename **`magnolia`**:
* **Xiaomi Mi TV 4A 32-inch** (`L32M5-AL` / `L32M5-AI`)
* **Xiaomi Mi TV 4A 43-inch** (`L43M5-AL` / `L43M5-AI`)
* Select regional Mi TV models running base firmware build versions: `16938`, `19764`, `16940`, `19766`.

### 🏷️ How to Identify via the Rear Label Sticker

You can easily identify your TV hardware before even powering it on by checking the manufacturer sticker on the back casing:
* **Model Number:** Look for **`MODEL: L32M5-AI`** or **`L32M5-AL`** (32-inch) / **`L43M5-AI`** or **`L43M5-AL`** (43-inch).
* **Serial Number Prefix:** Notice the number preceding the slash on the barcode sticker (e.g. **`SN 16938/280324540`**). Numbers like **`16938`**, **`19764`**, **`16940`**, or **`19766`** directly correspond to the technician spreadsheet for supported Magnolia units!

<p align="center">
  <img src="assets/back_panel_model_label.jpg" alt="Xiaomi Mi TV 4A L32M5-AI Rear Panel Label" width="450"/>
</p>

> [!NOTE]
> You can also verify on-screen under **Settings > About TV > Model**. Confirm your device is a Mi TV 4A (32" or 43").

---

## 🔍 The Missing File: Reverse Engineering `xiaomi_update-magnolia`

Many users find YouTube tutorials or technician spreadsheets promising the PatchWall-to-Android-9 update, but the required companion file **`xiaomi_update-magnolia`** is often missing or hosted on expired Google Drive links.

### What is this file?
Stock Xiaomi TV recovery does not offer an interactive user file explorer. When you boot the TV into recovery mode via remote keys, the recovery daemon scans the root directory of your USB drive (`/udisk`) for an automated batch instruction file:
* **File Name:** `xiaomi_update-magnolia`
* **File Type:** Plain text with **NO file extension** (not `.txt`, not `.bin`)
* **Payload:** Instructs the recovery kernel to locate and flash the firmware archive:
  ```text
  --update_package=/udisk/update-magnolia_p_rel_190830r2854-3698-user.zip
  ```

This repository includes the pre-built template file as well as automated PowerShell/Bash scripts to generate it in seconds.

---

## 🛠️ Requirements

1. **USB Flash Drive:**
   * Capacity: 8 GB or 16 GB recommended (must be FAT32 formatted, MBR partition).
2. **Download Both Files from [GitHub Releases: v1.0.0](https://github.com/akshit14243/mi-tv-patchwall-to-android/releases/tag/v1.0.0):**
   * 📦 **[`update-magnolia_p_rel_190830r2854-3698-user.zip`](https://github.com/akshit14243/mi-tv-patchwall-to-android/releases/download/v1.0.0/update-magnolia_p_rel_190830r2854-3698-user.zip)** (Size: ~758 MB / build `3698`)
   * ⚙️ **[`xiaomi_update-magnolia`](https://github.com/akshit14243/mi-tv-patchwall-to-android/releases/download/v1.0.0/xiaomi_update-magnolia)** (Size: 1 KB / recovery trigger script)
3. **Mi TV Remote** (with working batteries).

---

## 🚀 Step-by-Step Installation Guide

### ⚠️ Step 0: CRITICAL — Hardware Verification (Magnolia vs. Dangal)

> [!CAUTION]
> **DO NOT SKIP THIS STEP!**
> Xiaomi manufactured two outwardly identical TV models with completely different internal hardware mainboards:
> 1. **`magnolia`**: Xiaomi Mi TV 4A (Standard 32" / 43") — **Compatible with this guide!**
> 2. **`dangal` / `dangalUHD`**: Xiaomi Mi TV 4A Pro / 4C Pro — **INCOMPATIBLE!**
>
> If you flash this `magnolia` firmware on a `dangal` board, you will cause a permanent black screen or hard-brick your display panel!

#### How to Check via AIDA64:
Because old PatchWall lacks the official Google Play Store, verify your board before doing anything:
1. **Install AIDA64:**
   * **Method A (Recommended via Aptoide):** Download the **Aptoide TV** APK on your computer, copy it to a USB drive, install it via PatchWall's built-in file manager, and install **AIDA64**.
   * **Method B (Direct Sideload):** Download the official **AIDA64 for Android APK** on your PC, copy it to a USB flash drive, open PatchWall's file/media manager, and install the APK directly.
2. **Open AIDA64 > Navigate to "System":**
   * Check the **Device** and **Board** rows.
   * ✅ If it displays **`magnolia`**, you are **100% safe to proceed**.
   * 🛑 If it displays **`dangal`** (or `dangalUHD`), **DO NOT FLASH THIS PACKAGE**.

<p align="center">
  <img src="assets/aida64_hardware_check.jpg" alt="AIDA64 Hardware Verification - Check Device magnolia vs dangal" width="700"/>
</p>

---

### Step 1: Format the USB Drive
1. Insert your USB flash drive into your computer.
2. Format the drive as **FAT32** (Allocation unit size: Default).
   * *Note: Recovery cannot read NTFS or exFAT formatted drives.*

---

### Step 2: Copy Files to USB Root
Download both files from the **[Releases Section](https://github.com/akshit14243/mi-tv-patchwall-to-android/releases/tag/v1.0.0)** and place **EXACTLY these 2 files** directly in the **root (main directory)** of your USB drive:

```text
[USB Drive E:\]
  ├── update-magnolia_p_rel_190830r2854-3698-user.zip
  └── xiaomi_update-magnolia
```

*(No file renaming, no manual editing, and no unzipping required—simply download both files from the release and drag them to the root of your USB drive).*

<p align="center">
  <img src="assets/usb_drive_files.jpg" alt="USB Drive Root Directory with exactly the 2 files" width="700"/>
</p>

#### Or Generate Automatically:
If your firmware `.zip` has a different name, use the included helper script:

* **On Windows (PowerShell):**
  ```powershell
  .\scripts\generate_update_command.ps1 -UsbDrive "E:\" -ZipFileName "YOUR_FIRMWARE_NAME.zip"
  ```
* **On Linux / macOS:**
  ```bash
  chmod +x ./scripts/generate_update_command.sh
  ./scripts/generate_update_command.sh "/Volumes/MY_USB" "YOUR_FIRMWARE_NAME.zip"
  ```

---

### Step 3: Trigger Recovery on the TV

Follow these exact hardware steps:

#### 1. Press and Hold Remote Buttons
Unplug the TV power cable from the wall. Point your remote directly at the Mi logo at the bottom center of the TV. Press and hold both the **`Home`** and **`Menu`** buttons at the same time:

<p align="center">
  <img src="assets/remote_recovery_combo.jpg" alt="Press and Hold Home + Menu" width="700"/>
</p>

#### 2. Reconnect Power & Boot
While keeping both buttons firmly pressed, plug the power cable back into the wall outlet (or press the physical button underneath the center chin of the TV):

<p align="center">
  <img src="assets/tv_power_recovery.jpg" alt="Hold Button and Connect Power" width="700"/>
</p>

#### 3. Automatic Flashing
* Keep holding the buttons until the **Mi Logo** appears on the screen.
* The recovery daemon will automatically detect `/udisk/xiaomi_update-magnolia`.
* The screen will transition to the Android system update installation progress bar.
* **Do NOT power off or remove the USB drive** during the installation (takes approx. 5–8 minutes).

---

## 🌟 What Changes After the Update?

| Feature | Old Firmware (PatchWall) | Upgraded Android TV 9 |
|---|---|---|
| **Android Version** | Android 6.0.1 (Marshmallow) | **Android 9.0 (Pie)** |
| **Google Play Store** | ❌ No official Play Store | ✅ Full Android TV Google Play Store |
| **Chromecast** | ❌ Third-party casting apps | ✅ Built-in Google Cast support |
| **Voice Search** | ❌ Limited PatchWall search | ✅ Google Assistant Voice Control |
| **Streaming Apps** | ❌ Deprecated / outdated APKs | ✅ Modern Netflix, Prime, YouTube, Hotstar |
| **Dual Interface** | PatchWall Only | Toggle between **Android TV Home** & **PatchWall** |

---

## 📂 Repository Structure

```text
├── assets/
│   ├── aida64_hardware_check.jpg   # AIDA64 board verification (magnolia vs dangal)
│   ├── back_panel_model_label.jpg  # Rear rating label (Model L32M5-AI & SN 16938)
│   ├── remote_recovery_combo.jpg   # Visual guide for remote button combo
│   ├── tv_power_recovery.jpg       # Visual guide for power trigger
│   └── usb_drive_files.jpg         # Screenshot of FAT32 USB drive with the 2 files
├── docs/
│   ├── FIRMWARE_INFO.md            # Technical metadata, build keys, device tree
│   └── TROUBLESHOOTING.md          # Fixes for bootloop, signature check, USB errors
├── scripts/
│   ├── generate_update_command.ps1 # Automated PowerShell recovery file generator
│   └── generate_update_command.sh  # Automated Bash recovery file generator
├── templates/
│   └── xiaomi_update-magnolia      # Reference trigger template
├── .gitignore
├── LICENSE
└── README.md
```

---

## ⚠️ Disclaimer & Safety

* Updating TV firmware carries inherent risks. Ensure your power supply is stable and that you do not interrupt the update process.
* This repository provides documentation, automation scripts, and recovery trigger manifests for educational and repair purposes.
* All trademarks, product names, and brand names are property of their respective owners (Xiaomi Inc. / Google LLC).

---

## 🤝 Contributing & Support

Found an issue or have a tip for another TV model? Pull requests and issue submissions are welcome!

Created with ❤️ by **[Akshit Saini](https://github.com/akshit14243)**. If this guide helped unbrick or upgrade your TV, please consider giving this repository a ⭐!
