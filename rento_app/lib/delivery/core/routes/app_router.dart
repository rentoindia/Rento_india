// import 'package:flutter/material.dart';
// import 'route_names.dart';
// import 'package:rento/delivery/features/auth/presentation/screens/splash_screen.dart';
// import 'package:rento/delivery/features/auth/presentation/screens/mobile_entry_screen.dart';
// import 'package:rento/delivery/features/auth/presentation/screens/otp_verification_screen.dart';
// import 'package:rento/delivery/features/auth/presentation/screens/role_selection_screen.dart';
// import 'package:rento/delivery/features/rider/presentation/screens/registration/aadhaar_verification_screen.dart';
// import 'package:rento/delivery/features/rider/presentation/screens/registration/selfie_verification_screen.dart';
// import 'package:rento/delivery/features/rider/presentation/screens/registration/common_information_screen.dart';
// import 'package:rento/delivery/features/rider/presentation/screens/registration/driving_license_screen.dart';
// import 'package:rento/delivery/features/rider/presentation/screens/registration/vehicle_details_screen.dart';
// import 'package:rento/delivery/features/rider/presentation/screens/registration/insurance_details_screen.dart';
// import 'package:rento/delivery/features/rider/presentation/screens/registration/bank_details_screen.dart';
// import 'package:rento/delivery/features/rider/presentation/screens/registration/select_delivery_zone_screen.dart';
// import 'package:rento/delivery/features/rider/presentation/screens/registration/review_details_screen.dart';
// import 'package:rento/delivery/features/rider/presentation/screens/registration/under_review_screen.dart';
// import 'package:rento/delivery/features/rider/presentation/screens/registration/approved_screen.dart';

// // REMOVED: direct RiderHomeScreen import — no longer routed to directly.
// // RiderHomeScreen is now only reached as a tab INSIDE RiderShell.
// import 'package:rento/delivery/features/rider/presentation/screens/trips/trips_list_screen.dart';
// import 'package:rento/delivery/features/customer/presentation/screens/registration/common_information_screen.dart';
// import 'package:rento/delivery/features/customer/presentation/screens/registration/address_information_screen.dart';
// import 'package:rento/delivery/features/customer/presentation/screens/registration/review_details_screen.dart';
// import 'package:rento/delivery/features/customer/presentation/screens/registration/under_review_screen.dart';
// import 'package:rento/delivery/features/customer/presentation/screens/registration/approved_screen.dart';
// import 'package:rento/delivery/features/customer/presentation/screens/customer_home_placeholder_screen.dart';
// import 'package:rento/delivery/features/rider/presentation/rider_shell.dart';
// import 'package:rento/delivery/features/rider/presentation/screens/registration/aadhaar_verification_screen.dart';
// import 'package:rento/delivery/features/rider/presentation/screens/registration/selfie_verification_screen.dart';
// import 'package:rento/delivery/features/rider/presentation/screens/registration/driving_license_screen.dart';
// import 'package:rento/delivery/features/rider/presentation/screens/registration/vehicle_details_screen.dart';
// import 'package:rento/delivery/features/rider/presentation/screens/registration/insurance_details_screen.dart';
// import 'package:rento/delivery/features/rider/presentation/screens/registration/bank_details_screen.dart';
// import 'package:rento/delivery/features/rider/presentation/screens/registration/select_delivery_zone_screen.dart';

// /// Central onGenerateRoute. Register every new screen here.
// class AppRouter {
//   AppRouter._();

//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case RouteNames.splash:
//       // return MaterialPageRoute(builder: (_) => const SplashScreen());

//       case RouteNames.mobileEntry:
//       // return MaterialPageRoute(builder: (_) => const MobileEntryScreen());

//       case RouteNames.otpVerification:
//         return MaterialPageRoute(
//           //  builder: (_) => const OtpVerificationScreen(),
//           settings: settings, // keeps the mobile number argument attached
//         );

//       case RouteNames.roleSelection:
//       //  return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());

//       case RouteNames.riderRegistration:
//         return MaterialPageRoute(
//           builder: (_) => const AadhaarVerificationScreen(),
//         );

//       case RouteNames.riderSelfieVerification:
//         return MaterialPageRoute(
//           builder: (_) => const SelfieVerificationScreen(),
//         );

//       case RouteNames.riderCommonInfo:
//         return MaterialPageRoute(
//           builder: (_) => const CommonInformationScreen(),
//         );

//       case RouteNames.riderDrivingLicense:
//         return MaterialPageRoute(builder: (_) => const DrivingLicenseScreen());

//       case RouteNames.riderVehicleDetails:
//         return MaterialPageRoute(builder: (_) => const VehicleDetailsScreen());

//       case RouteNames.riderInsuranceDetails:
//         return MaterialPageRoute(
//           builder: (_) => const InsuranceDetailsScreen(),
//         );

//       case RouteNames.riderBankDetails:
//         return MaterialPageRoute(builder: (_) => const BankDetailsScreen());

//       case RouteNames.riderDeliveryZone:
//         return MaterialPageRoute(
//           builder: (_) => const SelectDeliveryZoneScreen(),
//         );

//       case RouteNames.riderReviewDetails:
//         return MaterialPageRoute(builder: (_) => const ReviewDetailsScreen());

//       case RouteNames.riderUnderReview:
//         return MaterialPageRoute(builder: (_) => const UnderReviewScreen());

//       case RouteNames.riderApproved:
//         return MaterialPageRoute(builder: (_) => const ApprovedScreen());

//       // CORRECTED: riderHome now routes to RiderShell, which owns the
//       // bottom-nav tabs (Home/Trips/Earnings/Profile) AND listens
//       // globally for incoming delivery requests — so the request popup
//       // can appear no matter which tab the rider is on, and "Go Online"
//       // no longer pushes a separate dead-end screen.
//       //
//       // FIX: this route wasn't passed `settings: settings`, so the
//       // resulting route's settings.name was always null instead of
//       // '/rider/home' — any code trying to pop back to Rider Home by
//       // name (e.g. after Confirm Delivery / Confirm Return) could never
//       // find it and ended up with a blank screen. Now it's attached.
//       case RouteNames.riderHome:
//         return MaterialPageRoute(
//           builder: (_) => const RiderShell(),
//           settings: settings,
//         );

//       case RouteNames.riderTrips:
//         return MaterialPageRoute(builder: (_) => const TripsListScreen());

//       case RouteNames.customerCommonInfo:
//         return MaterialPageRoute(
//           builder: (_) => const customer_common_info.CommonInformationScreen(),
//         );

//       case RouteNames.customerAddressInfo:
//         return MaterialPageRoute(
//           builder: (_) => const AddressInformationScreen(),
//         );

//       case RouteNames.customerReviewDetails:
//         return MaterialPageRoute(
//           builder: (_) => const customer_review.ReviewDetailsScreen(),
//         );

//       case RouteNames.customerUnderReview:
//         return MaterialPageRoute(
//           builder: (_) => const customer_under_review.UnderReviewScreen(),
//         );

//       case RouteNames.customerApproved:
//         return MaterialPageRoute(
//           builder: (_) => const customer_approved.ApprovedScreen(),
//         );

//       case RouteNames.customerHome:
//         return MaterialPageRoute(
//           builder: (_) => const CustomerHomePlaceholderScreen(),
//         );

//       default:
//         return MaterialPageRoute(
//           builder: (_) => Scaffold(
//             body: Center(child: Text('No route defined for ${settings.name}')),
//           ),
//         );
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'route_names.dart';
// import '../../features/auth/presentation/screens/splash_screen.dart';
// import '../../features/auth/presentation/screens/mobile_entry_screen.dart';
// import '../../features/auth/presentation/screens/otp_verification_screen.dart';
// import '../../features/auth/presentation/screens/role_selection_screen.dart'; 

import '../../features/rider/presentation/screens/registration/aadhaar_verification_screen.dart';
import '../../features/rider/presentation/screens/registration/selfie_verification_screen.dart';
import '../../features/rider/presentation/screens/registration/common_information_screen.dart';
import '../../features/rider/presentation/screens/registration/driving_license_screen.dart';
import '../../features/rider/presentation/screens/registration/vehicle_details_screen.dart';
import '../../features/rider/presentation/screens/registration/insurance_details_screen.dart';
import '../../features/rider/presentation/screens/registration/bank_details_screen.dart';
import '../../features/rider/presentation/screens/registration/select_delivery_zone_screen.dart';
import '../../features/rider/presentation/screens/registration/review_details_screen.dart';
import '../../features/rider/presentation/screens/registration/under_review_screen.dart';
import '../../features/rider/presentation/screens/registration/approved_screen.dart';
// REMOVED: direct RiderHomeScreen import — no longer routed to directly.
// RiderHomeScreen is now only reached as a tab INSIDE RiderShell.
import '../../features/rider/presentation/screens/trips/trips_list_screen.dart';
import '../../features/customer/presentation/screens/registration/common_information_screen.dart'
    as customer_common_info;
import '../../features/customer/presentation/screens/registration/address_information_screen.dart';
import '../../features/customer/presentation/screens/registration/review_details_screen.dart'
    as customer_review;
import '../../features/customer/presentation/screens/registration/under_review_screen.dart'
    as customer_under_review;
import '../../features/customer/presentation/screens/registration/approved_screen.dart'
    as customer_approved;
import '../../features/customer/presentation/screens/customer_home_placeholder_screen.dart';
import '../../features/rider/presentation/rider_shell.dart';

/// Central onGenerateRoute. Register every new screen here.
class AppRouter {
  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case RouteNames.splash:
      //   return MaterialPageRoute(builder: (_) => const SplashScreen());

      // case RouteNames.mobileEntry:
      //   return MaterialPageRoute(builder: (_) => const MobileEntryScreen());

      // case RouteNames.otpVerification:
      //   return MaterialPageRoute(
      //     builder: (_) => const OtpVerificationScreen(),
      //     settings: settings, // keeps the mobile number argument attached
      //   );

      // case RouteNames.roleSelection:
      //   return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());

      case RouteNames.riderRegistration:
        return MaterialPageRoute(
          builder: (_) => const AadhaarVerificationScreen(),
        );

      case RouteNames.riderSelfieVerification:
        return MaterialPageRoute(
          builder: (_) => const SelfieVerificationScreen(),
        );

      case RouteNames.riderCommonInfo:
        return MaterialPageRoute(
          builder: (_) => const CommonInformationScreen(),
        );

      case RouteNames.riderDrivingLicense:
        return MaterialPageRoute(builder: (_) => const DrivingLicenseScreen());

      case RouteNames.riderVehicleDetails:
        return MaterialPageRoute(builder: (_) => const VehicleDetailsScreen());

      case RouteNames.riderInsuranceDetails:
        return MaterialPageRoute(
          builder: (_) => const InsuranceDetailsScreen(),
        );

      case RouteNames.riderBankDetails:
        return MaterialPageRoute(builder: (_) => const BankDetailsScreen());

      case RouteNames.riderDeliveryZone:
        return MaterialPageRoute(
          builder: (_) => const SelectDeliveryZoneScreen(),
        );

      case RouteNames.riderReviewDetails:
        return MaterialPageRoute(builder: (_) => const ReviewDetailsScreen());

      case RouteNames.riderUnderReview:
        return MaterialPageRoute(builder: (_) => const UnderReviewScreen());

      case RouteNames.riderApproved:
        return MaterialPageRoute(builder: (_) => const ApprovedScreen());

      // CORRECTED: riderHome now routes to RiderShell, which owns the
      // bottom-nav tabs (Home/Trips/Earnings/Profile) AND listens
      // globally for incoming delivery requests — so the request popup
      // can appear no matter which tab the rider is on, and "Go Online"
      // no longer pushes a separate dead-end screen.
      //
      // FIX: this route wasn't passed `settings: settings`, so the
      // resulting route's settings.name was always null instead of
      // '/rider/home' — any code trying to pop back to Rider Home by
      // name (e.g. after Confirm Delivery / Confirm Return) could never
      // find it and ended up with a blank screen. Now it's attached.
      case RouteNames.riderHome:
      return MaterialPageRoute(
      builder: (_) => const RiderShell(),
       settings: settings,
       );

      case RouteNames.riderTrips:
        return MaterialPageRoute(builder: (_) => const TripsListScreen());

      case RouteNames.customerCommonInfo:
        return MaterialPageRoute(
          builder: (_) => const customer_common_info.CommonInformationScreen(),
        );

      case RouteNames.customerAddressInfo:
        return MaterialPageRoute(
          builder: (_) => const AddressInformationScreen(),
        );

      case RouteNames.customerReviewDetails:
        return MaterialPageRoute(
          builder: (_) => const customer_review.ReviewDetailsScreen(),
        );

      case RouteNames.customerUnderReview:
        return MaterialPageRoute(
          builder: (_) => const customer_under_review.UnderReviewScreen(),
        );

      case RouteNames.customerApproved:
        return MaterialPageRoute(
          builder: (_) => const customer_approved.ApprovedScreen(),
        );

      case RouteNames.customerHome:
        return MaterialPageRoute(
          builder: (_) => const CustomerHomePlaceholderScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
