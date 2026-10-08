import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/onboarding/application/onboarding_controller.dart';
import 'package:garir_khata/features/onboarding/presentation/widgets/onboarding_scaffold.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/presentation/widgets/vehicle_labels.dart';
import 'package:go_router/go_router.dart';

class VehicleDetailsPage extends ConsumerStatefulWidget {
  const VehicleDetailsPage({super.key});

  @override
  ConsumerState<VehicleDetailsPage> createState() => _VehicleDetailsPageState();
}

class _VehicleDetailsPageState extends ConsumerState<VehicleDetailsPage> {
  late final TextEditingController _nickname;
  late final TextEditingController _brand;
  late final TextEditingController _model;
  late final TextEditingController _variant;
  late final TextEditingController _year;
  late final TextEditingController _color;
  late final TextEditingController _registration;
  late final TextEditingController _engineCapacity;
  late final TextEditingController _engineNumber;
  late final TextEditingController _chassisNumber;
  late final TextEditingController _purchasePrice;
  String? _error;

  @override
  void initState() {
    super.initState();
    final draft = ref.read(onboardingControllerProvider);
    _nickname = TextEditingController(text: draft.nickname);
    _brand = TextEditingController(text: draft.brand);
    _model = TextEditingController(text: draft.model);
    _variant = TextEditingController(text: draft.variant);
    _year = TextEditingController(text: draft.modelYear?.toString() ?? '');
    _color = TextEditingController(text: draft.color);
    _registration = TextEditingController(text: draft.registrationNumber);
    _engineCapacity = TextEditingController(text: draft.engineCapacity);
    _engineNumber = TextEditingController(text: draft.engineNumber);
    _chassisNumber = TextEditingController(text: draft.chassisNumber);
    _purchasePrice = TextEditingController(
      text: draft.purchasePriceMajor?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _nickname.dispose();
    _brand.dispose();
    _model.dispose();
    _variant.dispose();
    _year.dispose();
    _color.dispose();
    _registration.dispose();
    _engineCapacity.dispose();
    _engineNumber.dispose();
    _chassisNumber.dispose();
    _purchasePrice.dispose();
    super.dispose();
  }

  void _persistDraft() {
    final controller = ref.read(onboardingControllerProvider.notifier);
    final int? year = int.tryParse(_year.text.trim());
    final double? price = double.tryParse(_purchasePrice.text.trim());
    controller.updateBasicInfo(
      nickname: _nickname.text,
      brand: _brand.text,
      model: _model.text,
      variant: _variant.text,
      modelYear: year,
      color: _color.text,
      clearModelYear: _year.text.trim().isEmpty,
    );
    controller.updateRegistrationInfo(
      registrationNumber: _registration.text,
      engineCapacity: _engineCapacity.text,
      engineNumber: _engineNumber.text,
      chassisNumber: _chassisNumber.text,
      purchasePriceMajor: price,
      clearPurchasePrice: _purchasePrice.text.trim().isEmpty,
    );
  }

  bool get _canContinue {
    return _nickname.text.trim().isNotEmpty || _model.text.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final draft = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);

    return OnboardingScaffold(
      step: 5,
      totalSteps: 7,
      title: l10n.addVehicleBasicTitle,
      subtitle: l10n.vehicleDetailsSubtitle,
      primaryLabel: l10n.commonContinue,
      isPrimaryEnabled: _canContinue,
      onBack: () {
        _persistDraft();
        context.go('/onboarding/vehicle-type');
      },
      onPrimary: () {
        _persistDraft();
        if (!_canContinue) {
          setState(() => _error = l10n.validationNicknameOrModel);
          return;
        }
        setState(() => _error = null);
        context.go('/onboarding/odometer');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  TextField(
                    controller: _nickname,
                    decoration: InputDecoration(
                      labelText: l10n.fieldNickname,
                      hintText: l10n.fieldNicknameHint,
                    ),
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextField(
                    controller: _brand,
                    decoration: InputDecoration(labelText: l10n.fieldBrand),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextField(
                    controller: _model,
                    decoration: InputDecoration(labelText: l10n.fieldModel),
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextField(
                    controller: _variant,
                    decoration: InputDecoration(labelText: l10n.fieldVariant),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextField(
                    controller: _year,
                    decoration: InputDecoration(labelText: l10n.fieldModelYear),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  DropdownButtonFormField<FuelType>(
                    // ignore: deprecated_member_use
                    value: draft.fuelType,
                    decoration: InputDecoration(labelText: l10n.fieldFuelType),
                    items: [
                      for (final FuelType type in FuelType.values)
                        DropdownMenuItem(
                          value: type,
                          child: Text(fuelTypeLabel(context, type)),
                        ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        controller.updateBasicInfo(fuelType: value);
                      }
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextField(
                    controller: _color,
                    decoration: InputDecoration(labelText: l10n.fieldColor),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.registrationSection,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.sensitiveDataNote,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextField(
                    controller: _registration,
                    decoration: InputDecoration(
                      labelText: l10n.fieldRegistration,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextField(
                    controller: _engineCapacity,
                    decoration: InputDecoration(
                      labelText: l10n.fieldEngineCapacity,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextField(
                    controller: _engineNumber,
                    decoration: InputDecoration(
                      labelText: l10n.fieldEngineNumber,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextField(
                    controller: _chassisNumber,
                    decoration: InputDecoration(
                      labelText: l10n.fieldChassisNumber,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  DropdownButtonFormField<OwnershipType?>(
                    // ignore: deprecated_member_use
                    value: draft.ownershipType,
                    decoration: InputDecoration(labelText: l10n.fieldOwnership),
                    items: [
                      DropdownMenuItem<OwnershipType?>(
                        value: null,
                        child: Text(l10n.optionalNotSet),
                      ),
                      for (final OwnershipType type in OwnershipType.values)
                        DropdownMenuItem(
                          value: type,
                          child: Text(ownershipTypeLabel(context, type)),
                        ),
                    ],
                    onChanged: (value) {
                      controller.updateRegistrationInfo(
                        ownershipType: value,
                        clearOwnershipType: value == null,
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextField(
                    controller: _purchasePrice,
                    decoration: InputDecoration(
                      labelText: l10n.fieldPurchasePrice,
                      prefixText: '৳ ',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              _error!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
        ],
      ),
    );
  }
}
