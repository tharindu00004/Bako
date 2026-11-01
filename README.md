# HIT BAKO - Android Mobile Application

A marketplace & rental application for heavy machinery (Backhoe loaders, Excavators, Spare parts & Repair services) in Sri Lanka.

## 🔐 Authentication & Roles (Verification & Super Admin Secret Access)

The app supports verified **Member Login (Phone/Email)** and exclusive **Super Admin Private Access**:

### 1. 👤 සාමාජික (Verified Member Login)
- **Login Options**: Members can log in using either:
  1. **දුරකථන අංකය (Phone Number)** + Password
  2. **විද්‍යුත් තැපෑල (Email Address)** + Password
- **Verification Step (OTP)**:
  - During sign up, members receive a 6-digit OTP verification code via SMS or Email.
  - **Demo OTP code for testing**: `739281`
  - Once verified, the member sets their password and can log in anytime.
- **Default Verified Demo Account**:
  - Phone: `077 123 4567` OR Email: `kasun@gmail.com`
  - Password: `password123`

---

### 2. 👑 Super Admin (Private & Known Only By You)
- **Access Configuration File**:
  [`lib/constants/admin_credentials.dart`](file:///C:/Users/thari/.gemini/antigravity/scratch/hit_bako_app/lib/constants/admin_credentials.dart)
- **Your Secret Credentials**:
  - **Admin Email**: `admin@hitbako.lk`
  - **Secret Password**: `HitBako#SuperAdmin@2026!`
  - **Master Security Key (PIN)**: `882199`
- *Note: You can change this password or master key at any time by editing `admin_credentials.dart`.*

---

## 🎨 Color Palette & Design System

The app replicates the exact blue & yellow color theme from the reference design:

| Element | Color Name | Hex Code |
|---|---|---|
| Background Canvas | Deep Navy | `#061536` |
| Surfaces / Cards | Card Blue | `#0C2458` |
| Header Gradient Start | Royal Navy | `#071C49` |
| Header Gradient End | Electric Blue | `#1557BF` |
| Brand Accent / Active Tabs | Glowing Cyan | `#00C2FF` |
| Price & Attention CTA | Golden Amber | `#FFC107` |
| Notification Badge | Alert Red | `#EF4444` |
| "විකිණීමට" (For Sale) Badge | Royal Blue | `#2563EB` |
| "කුලියට" (For Rent) Badge | Sky Cyan | `#0284C7` |
| Text Primary | Clean White | `#FFFFFF` |
| Text Secondary / Specs | Ice Blue | `#93C5FD` |

---

## 📱 Features Included

1. **Header Banner**: Circular HIT BAKO logo badge, tagline (`මිලදී ගන්න • විකුණන්න • කුලියට`), notification bell with unread badge (3), and menu drawer button.
2. **Search Bar**: Floating white pill input with filter options.
3. **5-Action Category Grid**:
   - මිලදී ගන්න (Buy)
   - බැකෝ කුලියට (Rent Backhoe)
   - අමතර කොටස් අලුත්වැඩියා (Spare Parts & Repairs)
   - වීඩියෝ ගැලරි (Video Gallery)
   - මගේ ලැයිස්තුව (My Saved List)
4. **Latest Listings (නවතම ලැයිස්තු)**:
   - Horizontal scrolling cards for JCB 3DX, CAT 320D, and Tata 315 E.
   - Price highlight in gold yellow (`රු. 4,250,000`, `රු. 35,000 / දිනයකට`).
   - Location tag (කුරුණෑගල, නුවර, ගම්පහ) and favorite toggle.
5. **Featured Video Section (විශේෂිත වීඩියෝ)**:
   - High-definition video card with play button, duration badge (`02:36`), and author tag (`කමල් පෙරේරා`).
6. **Spare Parts Promo Banner**:
   - `අමතර කොටස් අවශ්‍යද?` callout with yellow `දැන්ම සම්බන්ධ වන්න >` action button.
7. **Bottom Navigation Bar**:
   - Curved dark dock with 4 nav destinations and center elevated cyan `+` button to post an ad.
8. **Screens**:
   - Home Screen
   - Listing Detail Screen (Machine specifications, condition, tyre health, direct call & WhatsApp contact buttons)
   - Post Ad Screen (Sale vs Rent toggle, machinery model, year, hours, price, location selector)

---

## 🚀 How to Run

### Option 1: Live Interactive Preview (Browser or BlueStacks)
Open the generated preview HTML file directly:
`C:\Users\thari\.gemini\antigravity\brain\f3f90b7c-6cce-4ece-9edf-9c763b3942ce\hit_bako_preview.html`
You can double-click it to run in Google Chrome, Brave, or your preferred browser to test all interactive features.

### Option 2: Running with Flutter
1. Install the Flutter SDK (https://flutter.dev/docs/get-started/install).
2. Open terminal in `C:\Users\thari\.gemini\antigravity\scratch\hit_bako_app`:
   ```bash
   flutter pub get
   flutter run
   ```
3. To generate an installable Android APK:
   ```bash
   flutter build apk --release
   ```
   The APK will be generated at `build/app/outputs/flutter-apk/app-release.apk`.
