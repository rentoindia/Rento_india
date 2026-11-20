# Rento India – connect everything (backend + user app + admin app)

You have three folders:

| Folder | What it is | Where it goes |
|---|---|---|
| `backend/` | Spring Boot server (Java 21) – **replaces** your current `rentoindia-backend` project | its own VS Code window |
| `user_app/lib/` | changed / new files of the **user app** | copy over your user app's `lib/` (same sub-folders) |
| `admin_app/lib/` | changed / new files of the **admin app** | copy over your admin app's `lib/` (same sub-folders) |

> Every Flutter file here is a **complete replacement** of the file with the same path (I removed the old commented-out
> history from the files I touched). Keep a copy/commit of your project first so you can compare.

---------------------------------------------------------------------------------------------------

## PART 1 – Backend (do this first)

### 1. Use Java 21 (important)
Your `pom.xml` had been changed to Java 25 by an automatic upgrade tool. Spring Boot 3.3 does **not** run reliably on Java 25/26.
Install **JDK 21** (Temurin 21) and make VS Code use it (`Java: Configure Java Runtime`). The new `pom.xml` is already set to 21.

### 2. Replace the project
Delete the old source folder contents and copy this `backend/` over your project (so `pom.xml`, `src/`, `Dockerfile`, `docs/`, `scripts/` are the new ones).
The new project no longer needs Lombok, Redis, Flyway or Mail (removed on purpose – fewer things to break).

### 3. Supabase connection (use the SESSION POOLER)
In Supabase: **Connect → Session pooler** (not "Direct connection").
Direct connections are IPv6-only now and fail on most home networks; the Session pooler works everywhere.
You need three values:

```
DB_URL      = jdbc:postgresql://aws-0-<region>.pooler.supabase.com:5432/postgres?sslmode=require
DB_USER     = postgres.<your-project-ref>        <- note the ".<project-ref>" part
DB_PASSWORD = <your database password>
```
Set them as environment variables (PowerShell, before running):
```powershell
$env:DB_URL="jdbc:postgresql://aws-0-xxxx.pooler.supabase.com:5432/postgres?sslmode=require"
$env:DB_USER="postgres.yourprojectref"
$env:DB_PASSWORD="your-password"
$env:JWT_SECRET="put-a-long-random-text-here-at-least-40-characters"
```
(or put them in VS Code `launch.json` → `"env": {...}`). See `backend/.env.example` for every option.

### 4. Start with a clean database (recommended once)
The tables are created automatically by the server (Hibernate `ddl-auto: update`). If you already ran the **old** migration on Supabase,
open Supabase → SQL Editor and run this once so the new tables are created cleanly:
```sql
drop schema public cascade;
create schema public;
grant all on schema public to postgres, anon, authenticated, service_role;
```

### 5. Run it
```powershell
cd backend
mvn spring-boot:run          # or VS Code: Run RentoIndiaBackendApplication
```
You should see `Started RentoIndiaBackendApplication` and, on the first start, `Demo catalogue ready: 25 categories, 79 products`.

### 6. Prove it works
* Browser: `http://localhost:8080/health` -> `{"status":"UP"}`
* Browser: `http://localhost:8080/docs` -> Swagger page with all endpoints
* Supabase -> Table Editor -> you now see `users, products, rental_orders, riders, ...`
* Terminal: `bash backend/scripts/smoke-test.sh` (needs `curl` + `jq`) – walks through login, order, payment and the admin view.

**First admin login** (created automatically): e-mail `admin@rentoindia.com` (or phone `9999999999`) / password `Admin@12345`. Change it with `ADMIN_PASSWORD`.

---------------------------------------------------------------------------------------------------

## PART 2 – Flutter apps

### 1. Packages (both apps)
```
flutter pub add http web_socket_channel shared_preferences
```
(user app already has `shared_preferences` and `flutter_riverpod`; admin app already has `provider`).

### 2. Copy the files
Copy `user_app/lib/*` into your user app's `lib/`, and `admin_app/lib/*` into your admin app's `lib/` – same folder names.
New folders: `lib/core/` (both apps), `lib/delivery/core/`, `lib/Percel&person/core/`, `lib/my_house/core/`, `lib/maha/data/`.

### 3. Allow plain-http to your dev server (Android)
`android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<application android:usesCleartextTraffic="true" ...>
```
(iOS: add `NSAppTransportSecurity -> NSAllowsArbitraryLoads = true` to Info.plist for dev only.)
Use `https://` and remove this once the backend is deployed.

### 4. Tell the app where the server is
```
Android emulator : flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8080     (this is the default)
Real phone (Wi-Fi): flutter run --dart-define=API_BASE_URL=http://192.168.1.10:8080   (your PC's IP)
Deployed          : flutter run --dart-define=API_BASE_URL=https://api.yourdomain.com
```
Phone and PC must be on the same Wi-Fi, and Windows Firewall must allow port 8080.

---------------------------------------------------------------------------------------------------

## PART 3 – Try the whole thing end to end (4 "people")

1. **Admin app** → log in (`admin@rentoindia.com` / `Admin@12345`). Dashboard/Products show the 79 demo products from the database.
2. **User app (customer)** → log in with any phone. The OTP appears in a snackbar (the server returns it while `OTP_DEV_MODE=true`).
   Browse a category → rent a product → pay. **Watch the admin app: the order appears in Orders instantly (no refresh).**
3. **User app (lender)** → Lender verification → add a product with photos (they upload to the server). As a second customer, rent it → the lender gets
   a live "New Rental Request"; accept it.
4. **Rider**: second phone/emulator → Delivery portal → complete the registration (photos upload). It shows *under review*.
   In the **admin app → Delivery → Riders → documents → Verify** every document → the rider is approved automatically (live notification).
   Rider goes **Online** → the paid rental order appears as a request → **Accept** → at pickup enters the vendor OTP → at drop enters the
   **customer's OTP** (shown on the customer's "Delivery OTP" screen). The customer's order moves to *Delivered* live.
5. **Parcel / ride**: customer books a parcel or ride; the SOS button alerts the admin app live.
6. **My House**: owner lists a property in the owner portal (needs the owner API – see COVERAGE.md); admin approves it in the admin My House → Properties
   (Approve/Reject buttons on pending cards); tenants then see it in search.

---------------------------------------------------------------------------------------------------

## Business rules I had to choose (please confirm)

* **Cashback coins**: the app credited coins equal to 100 % of the rent. The server keeps that (`CASHBACK_PERCENT=100`). Change it before launch.
* **Deposit refund**: the rental is closed and the deposit refunded to the wallet automatically when the rider collects the return.
* **Rider approval**: a rider becomes ACTIVE when an admin has verified all uploaded documents.
* **Payments**: with no Razorpay keys the server runs in *test mode* and accepts the payment. When you add `RAZORPAY_KEY_ID/SECRET`, the server verifies
  Razorpay signatures (you then must open the Razorpay checkout in `payment_screen.dart` – the comment shows where).
* **OTP SMS**: with no MSG91 key the OTP is returned in the API (dev only). Set `SMS_PROVIDER=msg91`, the MSG91 keys and `OTP_DEV_MODE=false` for production.

See **COVERAGE.md** for exactly what is connected and what still runs on demo data.
