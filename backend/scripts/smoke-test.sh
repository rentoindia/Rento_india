#!/usr/bin/env bash
# End-to-end smoke test of the backend with curl. Run AFTER the server is up (mvn spring-boot:run).
#   bash scripts/smoke-test.sh            (uses http://localhost:8080)
#   BASE=http://192.168.1.10:8080 bash scripts/smoke-test.sh
# Needs: curl and jq.  The server must run with OTP_DEV_MODE=true (default) so the OTP is returned.
set -e
BASE=${BASE:-http://localhost:8080}
PHONE=${PHONE:-9876543210}
j() { jq -r "$1"; }

echo "1) health";                curl -s $BASE/health; echo
echo "2) request OTP";           OTP=$(curl -s -X POST $BASE/api/v1/auth/request-otp -H 'Content-Type: application/json' -d "{\"phone\":\"$PHONE\"}" | j .data.devOtp); echo "   otp=$OTP"
echo "3) verify OTP (customer)"; TOKEN=$(curl -s -X POST $BASE/api/v1/auth/verify-otp -H 'Content-Type: application/json' -d "{\"phone\":\"$PHONE\",\"code\":\"$OTP\",\"role\":\"CUSTOMER\"}" | j .data.accessToken); echo "   token ok: ${TOKEN:0:20}..."
AUTH="Authorization: Bearer $TOKEN"
echo "4) catalog";               curl -s "$BASE/api/v1/catalog/categories" | j '.data | length' | sed 's/^/   categories: /'
PRODUCT=$(curl -s "$BASE/api/v1/catalog/products?size=1" | j '.data.items[0].name'); echo "   first product: $PRODUCT"
echo "5) create order";          ORDER=$(curl -s -X POST $BASE/api/v1/orders -H "$AUTH" -H 'Content-Type: application/json' -d "{\"productName\":\"$PRODUCT\",\"deliveryAddress\":\"12 Test Street, Chennai\"}" | j .data.id); echo "   order id: $ORDER"
echo "6) pay order";             curl -s -X POST $BASE/api/v1/orders/$ORDER/pay -H "$AUTH" -H 'Content-Type: application/json' -d '{"paymentMethod":"UPI"}' | j '.data.status' | sed 's/^/   status: /'
echo "7) wallet";                curl -s $BASE/api/v1/wallet -H "$AUTH" | j '.data.coins' | sed 's/^/   coins: /'
echo "8) admin login";           ADMIN=$(curl -s -X POST $BASE/api/v1/auth/admin/login -H 'Content-Type: application/json' -d '{"identifier":"admin@rentoindia.com","password":"Admin@12345"}' | j .data.accessToken); echo "   admin token ok: ${ADMIN:0:20}..."
echo "9) admin dashboard";       curl -s $BASE/api/v1/admin/dashboard -H "Authorization: Bearer $ADMIN" | j '.data.rental.totalOrders' | sed 's/^/   total orders: /'
echo "10) admin sees the order"; curl -s $BASE/api/v1/admin/orders -H "Authorization: Bearer $ADMIN" | j '.data[0].orderNo + "  " + .data[0].status' | sed 's/^/   /'
echo "DONE - if every step printed a value, the backend + database are working."
