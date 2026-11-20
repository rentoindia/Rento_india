# What is connected to the real backend, and what is not

Legend: ✅ connected to the database and live · 🟡 partly · ⬜ still demo / local data (screen works, but not from the server)

## User app – Rental marketplace
| Feature | Status | Notes |
|---|---|---|
| Phone OTP login, stay logged in, logout | ✅ | token refresh is automatic |
| Categories / sub-categories / products | ✅ | loaded at start; admin changes arrive live |
| Home screen "featured / trending" carousels | ⬜ | still the hard-coded lists in `home_screen.dart` |
| Create order, pay (coins redeem, cashback), cancel | ✅ | |
| Delivery OTP / return OTP shown to the customer | ✅ | real codes from the server |
| Live order status (vendor accepted → rider → delivered …) | ✅ | pushed over WebSocket |
| Schedule return, extend rental, buy item | ✅ | |
| Live map of the rider on the order | ⬜ | endpoint `GET /orders/{id}/tracking` + WebSocket `location` events exist; `live_tracking_screen` still animates a demo map |
| Wallet / coins, notifications (live), favourites, reviews | ✅ | |
| Coupons / offers screen | ⬜ | `GET /offers` and `POST /offers/validate` exist; screens not hooked yet |
| Lender: verification, add/edit/pause/delete products (photos upload), requests, accept/decline | ✅ | |
| Profile name | ✅ | edit saves to the server |
| Chat support | ⬜ | |

## User app – Delivery (rider)
| Feature | Status |
|---|---|
| Rider registration (photos + details) | ✅ |
| Go online / offline, "under review" message | ✅ |
| Live incoming rental delivery/return requests, accept | ✅ |
| Pickup OTP / drop OTP verified by the server | ✅ |
| Parcel and person-ride jobs on the rider side | ⬜ (API ready: `/rider/jobs/PARCEL|RIDE/...`) |
| Rider live location sending, earnings, trip history screens | ⬜ (API ready: `/rider/location`, `/rider/earnings`, `/rider/jobs/history`) |

## User app – Parcel & Person ride (customer)
| Feature | Status |
|---|---|
| Book parcel / ride (sent to nearby riders instantly) | ✅ |
| Live status, real rider/captain, real OTPs | ✅ (the small "on the way" steps between events are cosmetic) |
| SOS (alerts the admin app live), cancel ride/parcel | ✅ |
| Saved addresses | ⬜ (API ready: `/addresses`) |

## User app – My House
| Feature | Status |
|---|---|
| Property search from the database | ✅ |
| Apply for a property, request a visit | ✅ |
| Raise a maintenance request | ✅ |
| Rent payment, utility bill payment | ⬜ (API ready: `MyHouseApi.payRent / payUtility`) – hook them to the "Pay" buttons |
| Owner portal (list property, approve tenants) | ⬜ (API ready: `MyHouseApi.createProperty / decideApplication`) |
| Wishlist, chat, documents | ⬜ |

## Admin app
| Module | Status |
|---|---|
| Admin login (e-mail/phone + password) | ✅ |
| Rental admin: products, categories, brands, orders, users, campaigns/coupons, dashboard | ✅ (live) |
| Delivery admin: riders, document verification, suspension, rides, parcels, SOS, notes | ✅ (live) |
| Delivery admin dashboard charts | ⬜ (monthly demo statistics) |
| My House admin: properties (approve/reject), maintenance list, dashboard cards | ✅ |
| My House admin: users, approval detail pages, analytics, settings | ⬜ |
| Rental analytics / settings screens | ⬜ |

## Backend (Spring Boot)
157 endpoints (see `backend/docs/API_ENDPOINTS.md`), WebSocket at `/ws`, file uploads at `/api/v1/uploads` (stored on the server disk
in `uploads/` – move to S3 before production), Razorpay + MSG91 hooks ready (inactive until you add keys).

## Not verified here (be honest with yourself before demo day)
I could not compile or run anything in my environment (no access to Maven Central or the Flutter SDK). What I did verify:
* Java: all 110 files parse; every call between my own classes type-checks (library types stubbed).
* Dart: every file parses (`dart format`); the networking core, services, providers and state classes type-check against stubs.
First real run may therefore show a few small compile errors (a missing import, a renamed widget parameter). Paste them to me and I'll fix them.
