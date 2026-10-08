import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:garir_khata/core/providers/core_providers.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/onboarding/application/onboarding_draft.dart';
import 'package:garir_khata/features/settings/application/settings_controller.dart';
import 'package:garir_khata/features/vehicles/application/use_cases/add_vehicle.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/domain/validation/vehicle_validator.dart';

class OnboardingController extends Notifier<OnboardingDraft> {
  @override
  OnboardingDraft build() => const OnboardingDraft();

  void reset() => state = const OnboardingDraft();

  void setVehicleType(VehicleType type) {
    state = state.copyWith(vehicleType: type);
  }

  void updateBasicInfo({
    String? nickname,
    String? brand,
    String? model,
    String? variant,
    int? modelYear,
    FuelType? fuelType,
    String? color,
    bool clearModelYear = false,
  }) {
    state = state.copyWith(
      nickname: nickname,
      brand: brand,
      model: model,
      variant: variant,
      modelYear: modelYear,
      fuelType: fuelType,
      color: color,
      clearModelYear: clearModelYear,
    );
  }

  void updateRegistrationInfo({
    String? registrationNumber,
    String? engineCapacity,
    String? engineNumber,
    String? chassisNumber,
    OwnershipType? ownershipType,
    DateTime? purchaseDate,
    double? purchasePriceMajor,
    bool clearOwnershipType = false,
    bool clearPurchaseDate = false,
    bool clearPurchasePrice = false,
  }) {
    state = state.copyWith(
      registrationNumber: registrationNumber,
      engineCapacity: engineCapacity,
      engineNumber: engineNumber,
      chassisNumber: chassisNumber,
      ownershipType: ownershipType,
      purchaseDate: purchaseDate,
      purchasePriceMajor: purchasePriceMajor,
      clearOwnershipType: clearOwnershipType,
      clearPurchaseDate: clearPurchaseDate,
      clearPurchasePrice: clearPurchasePrice,
    );
  }

  void setOdometer(int odometer) {
    state = state.copyWith(currentOdometer: odometer);
  }

  VehicleInput toInput() {
    final int? pricePaisa = state.purchasePriceMajor == null
        ? null
        : (state.purchasePriceMajor! * 100).round();
    return VehicleInput(
      nickname: state.nickname,
      vehicleType: state.vehicleType,
      fuelType: state.fuelType,
      currentOdometer: state.currentOdometer,
      brand: state.brand,
      model: state.model,
      variant: state.variant,
      modelYear: state.modelYear,
      registrationNumber: state.registrationNumber,
      purchaseDate: state.purchaseDate,
      purchasePricePaisa: pricePaisa,
      engineCapacity: state.engineCapacity,
      engineNumber: state.engineNumber,
      chassisNumber: state.chassisNumber,
      color: state.color,
      ownershipType: state.ownershipType,
    );
  }

  Future<Result<Vehicle>> submit() async {
    final AddVehicle useCase = AddVehicle(
      repository: ref.read(vehicleRepositoryProvider),
      uuidGenerator: ref.read(uuidGeneratorProvider),
      clock: ref.read(clockProvider),
    );
    final Result<Vehicle> result = await useCase(toInput());
    if (result case Success(:final data)) {
      await ref
          .read(settingsControllerProvider.notifier)
          .setSelectedVehicleId(data.id);
      await ref.read(settingsControllerProvider.notifier).completeOnboarding();
      ref.invalidate(activeVehiclesProvider);
      ref.invalidate(selectedVehicleProvider);
    }
    return result;
  }
}

final onboardingControllerProvider =
    NotifierProvider<OnboardingController, OnboardingDraft>(
      OnboardingController.new,
    );
