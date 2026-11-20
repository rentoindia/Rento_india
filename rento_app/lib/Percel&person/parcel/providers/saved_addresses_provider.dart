import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/saved_address_model.dart';

class SavedAddressesState {
  const SavedAddressesState({required this.addresses, this.selectedId});

  final List<SavedAddressModel> addresses;
  final String? selectedId;

  SavedAddressModel? get selected {
    if (selectedId == null) return null;
    for (final address in addresses) {
      if (address.id == selectedId) return address;
    }
    return null;
  }

  SavedAddressesState copyWith({
    List<SavedAddressModel>? addresses,
    String? selectedId,
  }) {
    return SavedAddressesState(
      addresses: addresses ?? this.addresses,
      selectedId: selectedId ?? this.selectedId,
    );
  }
}

class SavedAddressesNotifier extends StateNotifier<SavedAddressesState> {
  SavedAddressesNotifier()
    : super(
        const SavedAddressesState(
          addresses: [
            SavedAddressModel(
              id: 'home',
              type: SavedAddressType.home,
              flatHouseBuilding: 'Door No. 12, Ground Floor, 8th Avenue',
              streetAreaLandmark: 'Anna Nagar West',
              cityStatePin: 'Chennai — 600040',
              phone: '+91 98765 43210',
              latitude: 13.0891,
              longitude: 80.2101,
            ),
            SavedAddressModel(
              id: 'work',
              type: SavedAddressType.work,
              flatHouseBuilding:
                  'Quantum Innovations, 2nd Floor, RMZ Trade Building',
              streetAreaLandmark: 'RMCO Industrial Estate, Ambattur',
              cityStatePin: 'Chennai — 600058',
              phone: '+91 98765 43210',
              latitude: 13.1143,
              longitude: 80.1548,
            ),
            SavedAddressModel(
              id: 'other',
              type: SavedAddressType.other,
              flatHouseBuilding: 'No. 5, Kamerojan Salai',
              streetAreaLandmark: 'Saidapet',
              cityStatePin: 'Chennai — 600015',
              phone: '+91 98765 43210',
              latitude: 13.0206,
              longitude: 80.2226,
            ),
          ],
          selectedId: 'home',
        ),
      );

  void select(String id) {
    state = state.copyWith(selectedId: id);
  }

  void add(SavedAddressModel address) {
    state = state.copyWith(
      addresses: [...state.addresses, address],
      selectedId: address.id,
    );
  }
}

final savedAddressesProvider =
    StateNotifierProvider<SavedAddressesNotifier, SavedAddressesState>(
      (ref) => SavedAddressesNotifier(),
    );
