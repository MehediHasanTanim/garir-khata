import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/domain/validation/vehicle_validator.dart';
import 'package:garir_khata/features/vehicles/presentation/widgets/vehicle_labels.dart';
import 'package:go_router/go_router.dart';

/// Shared add/edit vehicle form used outside the first-run onboarding flow.
class VehicleFormPage extends ConsumerStatefulWidget {
  const VehicleFormPage({this.vehicleId, super.key});

  final String? vehicleId;

  bool get isEditing => vehicleId != null;

  @override
  ConsumerState<VehicleFormPage> createState() => _VehicleFormPageState();
}

class _VehicleFormPageState extends ConsumerState<VehicleFormPage> {
  final _nickname = TextEditingController();
  final _brand = TextEditingController();
  final _model = TextEditingController();
  final _variant = TextEditingController();
  final _year = TextEditingController();
  final _color = TextEditingController();
  final _registration = TextEditingController();
  final _engineCapacity = TextEditingController();
  final _engineNumber = TextEditingController();
  final _chassisNumber = TextEditingController();
  final _odometer = TextEditingController();
  final _purchasePrice = TextEditingController();

  VehicleType _vehicleType = VehicleType.motorcycle;
  FuelType _fuelType = FuelType.petrol;
  OwnershipType? _ownershipType;
  bool _hydrated = false;
  bool _saving = false;
  String? _error;

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
    _odometer.dispose();
    _purchasePrice.dispose();
    super.dispose();
  }

  void _hydrate(Vehicle vehicle) {
    if (_hydrated) {
      return;
    }
    _hydrated = true;
    _nickname.text = vehicle.nickname;
    _brand.text = vehicle.brand ?? '';
    _model.text = vehicle.model ?? '';
    _variant.text = vehicle.variant ?? '';
    _year.text = vehicle.modelYear?.toString() ?? '';
    _color.text = vehicle.color ?? '';
    _registration.text = vehicle.registrationNumber ?? '';
    _engineCapacity.text = vehicle.engineCapacity ?? '';
    _engineNumber.text = vehicle.engineNumber ?? '';
    _chassisNumber.text = vehicle.chassisNumber ?? '';
    _odometer.text = '${vehicle.currentOdometer}';
    if (vehicle.purchasePricePaisa != null) {
      _purchasePrice.text = (vehicle.purchasePricePaisa! / 100).toStringAsFixed(
        0,
      );
    }
    _vehicleType = vehicle.vehicleType;
    _fuelType = vehicle.fuelType;
    _ownershipType = vehicle.ownershipType;
  }

  VehicleInput _toInput() {
    final double? price = double.tryParse(_purchasePrice.text.trim());
    return VehicleInput(
      nickname: _nickname.text,
      vehicleType: _vehicleType,
      fuelType: _fuelType,
      currentOdometer: int.tryParse(_odometer.text.trim()) ?? -1,
      brand: _brand.text,
      model: _model.text,
      variant: _variant.text,
      modelYear: int.tryParse(_year.text.trim()),
      registrationNumber: _registration.text,
      purchasePricePaisa: price == null ? null : (price * 100).round(),
      engineCapacity: _engineCapacity.text,
      engineNumber: _engineNumber.text,
      chassisNumber: _chassisNumber.text,
      color: _color.text,
      ownershipType: _ownershipType,
    );
  }

  Future<void> _save() async {
    setState(() {
      _saving = true;
      _error = null;
    });
    final input = _toInput();
    final result = widget.isEditing
        ? await saveExistingVehicle(ref, id: widget.vehicleId!, input: input)
        : await saveNewVehicle(ref, input);

    if (!mounted) {
      return;
    }
    setState(() => _saving = false);
    result.when(
      success: (vehicle) {
        if (widget.isEditing) {
          context.pop();
        } else {
          context.go('/vehicles/${vehicle.id}');
        }
      },
      failure: (error) => setState(() => _error = error.message),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (widget.isEditing) {
      final asyncVehicle = ref.watch(vehicleByIdProvider(widget.vehicleId!));
      asyncVehicle.whenData((vehicle) {
        if (vehicle != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() => _hydrate(vehicle));
            }
          });
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? l10n.editVehicle : l10n.addVehicle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          DropdownButtonFormField<VehicleType>(
            // ignore: deprecated_member_use
            value: _vehicleType,
            decoration: InputDecoration(labelText: l10n.fieldVehicleType),
            items: [
              for (final VehicleType type in VehicleType.values)
                DropdownMenuItem(
                  value: type,
                  child: Text(vehicleTypeLabel(context, type)),
                ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => _vehicleType = value);
              }
            },
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _nickname,
            decoration: InputDecoration(labelText: l10n.fieldNickname),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _brand,
            decoration: InputDecoration(labelText: l10n.fieldBrand),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _model,
            decoration: InputDecoration(labelText: l10n.fieldModel),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _variant,
            decoration: InputDecoration(labelText: l10n.fieldVariant),
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
            value: _fuelType,
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
                setState(() => _fuelType = value);
              }
            },
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _odometer,
            decoration: InputDecoration(
              labelText: l10n.fieldCurrentOdometer,
              suffixText: 'km',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            enabled: !widget.isEditing,
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _registration,
            decoration: InputDecoration(labelText: l10n.fieldRegistration),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _color,
            decoration: InputDecoration(labelText: l10n.fieldColor),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _engineCapacity,
            decoration: InputDecoration(labelText: l10n.fieldEngineCapacity),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _engineNumber,
            decoration: InputDecoration(labelText: l10n.fieldEngineNumber),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _chassisNumber,
            decoration: InputDecoration(labelText: l10n.fieldChassisNumber),
          ),
          const SizedBox(height: AppSpacing.sm),
          DropdownButtonFormField<OwnershipType?>(
            // ignore: deprecated_member_use
            value: _ownershipType,
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
            onChanged: (value) => setState(() => _ownershipType = value),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _purchasePrice,
            decoration: InputDecoration(
              labelText: l10n.fieldPurchasePrice,
              prefixText: '৳ ',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          if (_error != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              _error!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(l10n.commonSave),
          ),
        ],
      ),
    );
  }
}
