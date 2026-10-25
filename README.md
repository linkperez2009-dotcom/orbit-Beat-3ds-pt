# Orbit Beat — 3DS / Android-first rhythm-game starter

A fan-made rhythm-game project inspired by the *idea* of timing inputs along a path. It is not the original ADOFAI and contains no original game assets or music.

## Current status
- C++ Nintendo 3DS homebrew starter using devkitPro/devkitARM + libctru.
- A simple timing prototype: press **A** in time with the beat; the screen reports hit/miss feedback.
- A GitHub Actions workflow is included so the project can be compiled in the cloud without owning a PC.
- This is an initial foundation, not a finished game. Audio playback, real level parsing, menus, and an Android build are not implemented yet.

## Build without a PC
1. On your Android phone, sign in to GitHub and create a new **public or private repository**.
2. Upload the contents of this folder to the repository (GitHub's website can upload files; the mobile app/site UI may vary).
3. Open the repository's **Actions** tab and enable workflows if GitHub asks.
4. Run the workflow named **Build Nintendo 3DS homebrew** using **Run workflow**.
5. When it finishes, open that run and download the `orbit-beat-3dsx` artifact.
6. Copy the `.3dsx` file to the SD card in the location used by your Homebrew Launcher.

The workflow uses the devkitPro devkitARM toolchain and libctru, the standard homebrew toolchain/library for 3DS. Cloud build success is not guaranteed until tested; if the workflow fails, share its log and we can fix it.

## Local build
With devkitPro/devkitARM and the 3DS development packages installed:
```sh
make
```

## Controls in this prototype
- **A**: attempt the beat
- **START**: exit

## Next milestones
1. Add original level format and path/planet animation.
2. Add audio playback and offset calibration.
3. Add original music and levels.
4. Add a browser-playable Android prototype, then share timing/level logic where practical.
5. Test on real hardware and optimize.

## Important
This repository is a starting point. It does not yet contain a playable Android APK or a complete ADOFAI port.
