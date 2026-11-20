# API reference (generated from the controllers)

Base URL: `http://HOST:8080`. Every response is `{ "success": true, "message": "OK", "data": ... }`.

Send `Authorization: Bearer <accessToken>` on every endpoint except the public ones (login, catalog, offers, reviews GET, public My House search).

Live API explorer: `http://HOST:8080/docs` (Swagger UI) once the server is running.


## /api/v1/addresses

| Method | Path | Handler |
|---|---|---|
| GET | `/api/v1/addresses` | AddressController.list |
| POST | `/api/v1/addresses` | AddressController.add |
| DELETE | `/api/v1/addresses/{id}` | AddressController.delete |
| PUT | `/api/v1/addresses/{id}` | AddressController.update |

## /api/v1/admin

| Method | Path | Handler |
|---|---|---|
| GET | `/api/v1/admin/campaigns` | AdminCampaignController.list |
| POST | `/api/v1/admin/campaigns` | AdminCampaignController.create |
| PUT | `/api/v1/admin/campaigns/coupons/{id}` | AdminCampaignController.updateCoupon |
| POST | `/api/v1/admin/campaigns/coupons/{id}/toggle` | AdminCampaignController.toggleCoupon |
| DELETE | `/api/v1/admin/campaigns/{id}` | AdminCampaignController.delete |
| PUT | `/api/v1/admin/campaigns/{id}` | AdminCampaignController.update |
| POST | `/api/v1/admin/campaigns/{id}/coupons` | AdminCampaignController.addCoupon |
| GET | `/api/v1/admin/catalog/brands` | AdminCatalogController.listBrands |
| POST | `/api/v1/admin/catalog/brands` | AdminCatalogController.addBrand |
| POST | `/api/v1/admin/catalog/brands/{id}/toggle` | AdminCatalogController.toggleBrand |
| GET | `/api/v1/admin/catalog/categories` | AdminCatalogController.listCategories |
| POST | `/api/v1/admin/catalog/categories` | AdminCatalogController.addCategory |
| POST | `/api/v1/admin/catalog/categories/{id}/subcategories` | AdminCatalogController.addSub |
| POST | `/api/v1/admin/catalog/categories/{id}/toggle` | AdminCatalogController.toggleCategory |
| GET | `/api/v1/admin/catalog/products` | AdminCatalogController.listProducts |
| POST | `/api/v1/admin/catalog/products` | AdminCatalogController.createProduct |
| DELETE | `/api/v1/admin/catalog/products/{id}` | AdminCatalogController.deleteProduct |
| GET | `/api/v1/admin/catalog/products/{id}` | AdminCatalogController.getProduct |
| PUT | `/api/v1/admin/catalog/products/{id}` | AdminCatalogController.updateProduct |
| POST | `/api/v1/admin/catalog/products/{id}/inventory` | AdminCatalogController.inventory |
| POST | `/api/v1/admin/catalog/products/{id}/status` | AdminCatalogController.setStatus |
| POST | `/api/v1/admin/catalog/subcategories/{id}/toggle` | AdminCatalogController.toggleSub |
| GET | `/api/v1/admin/dashboard` | AdminDashboardController.dashboard |
| POST | `/api/v1/admin/logistics/documents/{id}/review` | AdminLogisticsController.reviewDocument |
| GET | `/api/v1/admin/logistics/parcels` | AdminLogisticsController.listParcels |
| GET | `/api/v1/admin/logistics/parcels/{id}` | AdminLogisticsController.getParcel |
| POST | `/api/v1/admin/logistics/parcels/{id}/cancel` | AdminLogisticsController.cancelParcel |
| POST | `/api/v1/admin/logistics/parcels/{id}/notes` | AdminLogisticsController.addParcelNote |
| GET | `/api/v1/admin/logistics/riders` | AdminLogisticsController.listRiders |
| GET | `/api/v1/admin/logistics/riders/{id}` | AdminLogisticsController.getRider |
| POST | `/api/v1/admin/logistics/riders/{id}/payout` | AdminLogisticsController.payout |
| POST | `/api/v1/admin/logistics/riders/{id}/status` | AdminLogisticsController.setStatus |
| GET | `/api/v1/admin/logistics/rides` | AdminLogisticsController.listRides |
| GET | `/api/v1/admin/logistics/rides/{id}` | AdminLogisticsController.getRide |
| POST | `/api/v1/admin/logistics/rides/{id}/cancel` | AdminLogisticsController.cancelRide |
| POST | `/api/v1/admin/logistics/rides/{id}/notes` | AdminLogisticsController.addRideNote |
| POST | `/api/v1/admin/logistics/rides/{id}/resolve-sos` | AdminLogisticsController.resolveSos |
| GET | `/api/v1/admin/myhouse/applications` | AdminMyHouseController.listApplications |
| GET | `/api/v1/admin/myhouse/maintenance` | AdminMyHouseController.listMaintenance |
| POST | `/api/v1/admin/myhouse/maintenance/{id}` | AdminMyHouseController.updateMaintenance |
| GET | `/api/v1/admin/myhouse/properties` | AdminMyHouseController.listProperties |
| GET | `/api/v1/admin/myhouse/properties/{id}` | AdminMyHouseController.getProperty |
| POST | `/api/v1/admin/myhouse/properties/{id}/decision` | AdminMyHouseController.decide |
| GET | `/api/v1/admin/myhouse/properties/{id}/rooms` | AdminMyHouseController.listRooms |
| POST | `/api/v1/admin/myhouse/properties/{id}/rooms` | AdminMyHouseController.addRoom |
| GET | `/api/v1/admin/myhouse/rent` | AdminMyHouseController.listRent |
| POST | `/api/v1/admin/myhouse/rooms/{id}/status` | AdminMyHouseController.roomStatus |
| GET | `/api/v1/admin/myhouse/utilities` | AdminMyHouseController.listUtilities |
| GET | `/api/v1/admin/orders` | AdminOrderController.list |
| GET | `/api/v1/admin/orders/{id}` | AdminOrderController.one |
| POST | `/api/v1/admin/orders/{id}/status` | AdminOrderController.status |
| GET | `/api/v1/admin/users` | AdminUserController.list |
| POST | `/api/v1/admin/users/broadcast` | AdminUserController.broadcast |
| DELETE | `/api/v1/admin/users/{id}` | AdminUserController.delete |
| GET | `/api/v1/admin/users/{id}` | AdminUserController.one |
| POST | `/api/v1/admin/users/{id}/block` | AdminUserController.block |
| POST | `/api/v1/admin/users/{id}/verify` | AdminUserController.verify |

## /api/v1/auth

| Method | Path | Handler |
|---|---|---|
| POST | `/api/v1/auth/admin/login` | AuthController.adminLogin |
| POST | `/api/v1/auth/refresh` | AuthController.refresh |
| POST | `/api/v1/auth/request-otp` | AuthController.requestOtp |
| POST | `/api/v1/auth/verify-otp` | AuthController.verifyOtp |

## /api/v1/catalog

| Method | Path | Handler |
|---|---|---|
| GET | `/api/v1/catalog/brands` | CatalogController.brands |
| GET | `/api/v1/catalog/categories` | CatalogController.categories |
| GET | `/api/v1/catalog/products` | CatalogController.list |
| GET | `/api/v1/catalog/products/by-name` | CatalogController.byName |
| GET | `/api/v1/catalog/products/featured` | CatalogController.featured |
| GET | `/api/v1/catalog/products/{id}` | CatalogController.one |

## /api/v1/favorites

| Method | Path | Handler |
|---|---|---|
| DELETE | `/api/v1/favorites` | FavoriteController.remove |
| GET | `/api/v1/favorites` | FavoriteController.list |
| POST | `/api/v1/favorites` | FavoriteController.add |

## /api/v1/lender

| Method | Path | Handler |
|---|---|---|
| GET | `/api/v1/lender/products` | LenderController.myProducts |
| POST | `/api/v1/lender/products` | LenderController.create |
| DELETE | `/api/v1/lender/products/{id}` | LenderController.delete |
| PUT | `/api/v1/lender/products/{id}` | LenderController.update |
| POST | `/api/v1/lender/products/{id}/toggle-pause` | LenderController.togglePause |
| GET | `/api/v1/lender/profile` | LenderController.profile |
| GET | `/api/v1/lender/requests` | LenderController.requests |
| POST | `/api/v1/lender/requests/{id}/complete` | LenderController.complete |
| POST | `/api/v1/lender/requests/{id}/respond` | LenderController.respond |
| GET | `/api/v1/lender/summary` | LenderController.summary |
| POST | `/api/v1/lender/verification` | LenderController.verify |

## /api/v1/me

| Method | Path | Handler |
|---|---|---|
| GET | `/api/v1/me` | MeController.get |
| PUT | `/api/v1/me` | MeController.update |
| POST | `/api/v1/me/roles` | MeController.addRole |

## /api/v1/myhouse

| Method | Path | Handler |
|---|---|---|
| GET | `/api/v1/myhouse/owner/applications` | MyHouseController.ownerApplications |
| POST | `/api/v1/myhouse/owner/applications/{id}/decide` | MyHouseController.decide |
| GET | `/api/v1/myhouse/owner/maintenance` | MyHouseController.ownerMaintenance |
| GET | `/api/v1/myhouse/owner/properties` | MyHouseController.ownerProperties |
| POST | `/api/v1/myhouse/owner/properties` | MyHouseController.createProperty |
| DELETE | `/api/v1/myhouse/owner/properties/{id}` | MyHouseController.deleteProperty |
| PUT | `/api/v1/myhouse/owner/properties/{id}` | MyHouseController.updateProperty |
| GET | `/api/v1/myhouse/owner/rent` | MyHouseController.ownerRent |
| GET | `/api/v1/myhouse/owner/visits` | MyHouseController.ownerVisits |
| POST | `/api/v1/myhouse/owner/visits/{id}/status` | MyHouseController.visitStatus |
| GET | `/api/v1/myhouse/public/properties` | MyHouseController.search |
| GET | `/api/v1/myhouse/public/properties/{id}` | MyHouseController.one |
| GET | `/api/v1/myhouse/tenant/applications` | MyHouseController.myApplications |
| POST | `/api/v1/myhouse/tenant/applications` | MyHouseController.apply |
| POST | `/api/v1/myhouse/tenant/applications/{id}/withdraw` | MyHouseController.withdraw |
| GET | `/api/v1/myhouse/tenant/maintenance` | MyHouseController.myMaintenance |
| POST | `/api/v1/myhouse/tenant/maintenance` | MyHouseController.raiseMaintenance |
| GET | `/api/v1/myhouse/tenant/rent` | MyHouseController.myRent |
| POST | `/api/v1/myhouse/tenant/rent` | MyHouseController.payRent |
| GET | `/api/v1/myhouse/tenant/utilities` | MyHouseController.myUtilities |
| POST | `/api/v1/myhouse/tenant/utilities` | MyHouseController.payUtility |
| GET | `/api/v1/myhouse/tenant/visits` | MyHouseController.myVisits |
| POST | `/api/v1/myhouse/tenant/visits` | MyHouseController.requestVisit |

## /api/v1/notifications

| Method | Path | Handler |
|---|---|---|
| GET | `/api/v1/notifications` | NotificationController.mine |
| POST | `/api/v1/notifications/read-all` | NotificationController.readAll |
| DELETE | `/api/v1/notifications/{id}` | NotificationController.delete |
| POST | `/api/v1/notifications/{id}/read` | NotificationController.read |

## /api/v1/offers

| Method | Path | Handler |
|---|---|---|
| GET | `/api/v1/offers` | OffersController.live |
| POST | `/api/v1/offers/validate` | OffersController.validate |

## /api/v1/orders

| Method | Path | Handler |
|---|---|---|
| GET | `/api/v1/orders` | OrderController.list |
| POST | `/api/v1/orders` | OrderController.create |
| GET | `/api/v1/orders/{id}` | OrderController.one |
| PUT | `/api/v1/orders/{id}` | OrderController.update |
| POST | `/api/v1/orders/{id}/cancel` | OrderController.cancel |
| POST | `/api/v1/orders/{id}/extend` | OrderController.extend |
| POST | `/api/v1/orders/{id}/pay` | OrderController.pay |
| POST | `/api/v1/orders/{id}/purchase` | OrderController.purchase |
| POST | `/api/v1/orders/{id}/rental-active` | OrderController.rentalActive |
| POST | `/api/v1/orders/{id}/schedule-return` | OrderController.scheduleReturn |
| GET | `/api/v1/orders/{id}/tracking` | OrderController.tracking |

## /api/v1/parcels

| Method | Path | Handler |
|---|---|---|
| GET | `/api/v1/parcels` | ParcelController.list |
| POST | `/api/v1/parcels` | ParcelController.create |
| GET | `/api/v1/parcels/{id}` | ParcelController.one |
| POST | `/api/v1/parcels/{id}/cancel` | ParcelController.cancel |

## /api/v1/payments

| Method | Path | Handler |
|---|---|---|
| POST | `/api/v1/payments/razorpay/order` | PaymentController.createOrder |

## /api/v1/reviews

| Method | Path | Handler |
|---|---|---|
| GET | `/api/v1/reviews` | ReviewController.list |
| POST | `/api/v1/reviews` | ReviewController.add |

## /api/v1/rider

| Method | Path | Handler |
|---|---|---|
| GET | `/api/v1/rider/earnings` | RiderController.earnings |
| GET | `/api/v1/rider/jobs/available` | RiderController.available |
| GET | `/api/v1/rider/jobs/current` | RiderController.current |
| GET | `/api/v1/rider/jobs/history` | RiderController.history |
| POST | `/api/v1/rider/jobs/{kind}/{id}/accept` | RiderController.accept |
| POST | `/api/v1/rider/jobs/{kind}/{id}/release` | RiderController.release |
| POST | `/api/v1/rider/jobs/{kind}/{id}/verify-drop` | RiderController.drop |
| POST | `/api/v1/rider/jobs/{kind}/{id}/verify-pickup` | RiderController.pickup |
| POST | `/api/v1/rider/location` | RiderController.location |
| GET | `/api/v1/rider/me` | RiderController.me |
| PUT | `/api/v1/rider/me` | RiderController.update |
| POST | `/api/v1/rider/online` | RiderController.online |
| POST | `/api/v1/rider/register` | RiderController.register |

## /api/v1/rides

| Method | Path | Handler |
|---|---|---|
| GET | `/api/v1/rides` | RideController.list |
| POST | `/api/v1/rides` | RideController.create |
| GET | `/api/v1/rides/{id}` | RideController.one |
| POST | `/api/v1/rides/{id}/cancel` | RideController.cancel |
| POST | `/api/v1/rides/{id}/sos` | RideController.sos |

## /api/v1/uploads

| Method | Path | Handler |
|---|---|---|
| POST | `/api/v1/uploads` | UploadController.upload |

## /api/v1/wallet

| Method | Path | Handler |
|---|---|---|
| GET | `/api/v1/wallet` | WalletController.get |
| POST | `/api/v1/wallet/redeem` | WalletController.redeem |

## /health

| Method | Path | Handler |
|---|---|---|
| GET | `/health` | HealthController.health |
