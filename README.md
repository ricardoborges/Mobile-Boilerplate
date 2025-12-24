git clone <seu-repo>
# Tauri Mobile Boilerplate

Minimal boilerplate to ship Android, Windows, and Web apps with Tauri 2.0. The frontend can be built with any JavaScript stack (plain HTML, React, Vue, Svelte, Solid, etc.). This README covers architecture, terminal commands, and helper scripts.

![Version](https://img.shields.io/badge/version-0.1.0-blue) ![Platform](https://img.shields.io/badge/platform-Android%20%7C%20Windows%20%7C%20Web-green) ![Tauri](https://img.shields.io/badge/Tauri-2.0-orange) ![License](https://img.shields.io/badge/license-MIT-yellow)

## Architecture

- Project root: `index.html`, `styles.css`, `script.js` are the sample frontend. `copy-to-dist.ps1` (or `npm run prepare:dist`) copies these files into `dist/`, which Tauri uses at runtime.
- `dist/`: frontend artifacts bundled by Tauri. If you use React/Vue/Svelte/etc., point your framework build output here or adjust `build.frontendDist` in `src-tauri/tauri.conf.json` to match your build folder.
- `src-tauri/`: Tauri backend (Rust). The entry point `src-tauri/src/main.rs` calls `app_lib::run()` in `src-tauri/src/lib.rs`. `tauri.conf.json` defines product metadata, windows, bundle targets, and where to read the frontend (`dist/`).
- PowerShell scripts: automate dist preparation, environment checks, and Android builds.

## Requirements

- Node.js 18+
- Rust 1.77+
- Android toolchain (for mobile): Android SDK 35, NDK 27.0.12077973, Java JDK, ADB on PATH

## Quick start

```powershell
npm install
npm run build         
npm run dev           

# antes de rodar para Android, valide o ambiente:
./setup-android.ps1

npm exec tauri android init 
./run-android.ps1      # mobile dev on emulator/device
./build-android.ps1    # release APK
```

## NPM scripts

- `npm run prepare:dist` — create `dist/` and copy `index.html`, `styles.css`, `script.js` (used by all other scripts).
- `npm run dev` — prepare `dist/` and run `tauri dev` (desktop).
- `npm run build` — prepare `dist/` and run `tauri build` (desktop release).
- `npm run android:dev` — prepare `dist/` and run `tauri android dev` (hot reload on device/emulator).
- `npm run android:build` — prepare `dist/` and run `tauri android build` (release APK).

## PowerShell scripts

- `./copy-to-dist.ps1` — copy static frontend files into `dist/`.
- `./run-android.ps1` — ensures ADB/npm, copies assets, then runs `npm run android:dev`.
- `./build-android.ps1` — checks tools (node, npm, cargo, javac, adb), copies assets, then runs `npm run android:build` (signed APK in `src-tauri/target/android/release/`).
- `./setup-android.ps1` — checklist para validar o ambiente antes de buildar: mostra status de `java`/`javac`, `ANDROID_HOME`, `NDK_HOME`, `rustc`, `cargo`, `node`, `npm` e `adb`.

## Using your own JS framework

1) Build your app with React/Vue/Svelte/Solid/etc.
2) Point the build output to `dist/` (or update `build.frontendDist` in `src-tauri/tauri.conf.json`).
3) Ensure the built `index.html` uses relative asset paths so it works offline on Android/Windows.
4) Run `npm run dev` (desktop) or `./run-android.ps1` (mobile) to test; use `npm run build` / `./build-android.ps1` for release.

## Project layout

```
Mobile-Boilerplate/
├── index.html          # Sample frontend
├── styles.css
├── script.js
├── dist/               # Frontend output consumed by Tauri (generated)
├── src-tauri/
│   ├── tauri.conf.json # Tauri config (frontendDist -> ../dist)
│   └── src/
│       ├── main.rs     # Entrypoint
│       └── lib.rs      # Tauri builder
├── copy-to-dist.ps1    # Copy frontend to dist
├── run-android.ps1     # Android dev
├── build-android.ps1   # Android release
└── setup-android.ps1   # Environment checklist
```

## Notes

- CSP is disabled (`csp: null`) for development convenience; tighten it for production.
- To change icons/identifier, edit `productName`, `identifier`, and `bundle.icon` in `src-tauri/tauri.conf.json`.
- Android signing is handled by `tauri android build`; provide your own keystore for production apps.

## License

MIT
