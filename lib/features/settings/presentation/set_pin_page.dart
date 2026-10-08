import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/ui/app_states.dart';
import 'package:garir_khata/core/ui/async_result_feedback.dart';
import 'package:garir_khata/features/settings/application/app_lock_controller.dart';
import 'package:go_router/go_router.dart';

class SetPinPage extends ConsumerStatefulWidget {
  const SetPinPage({this.changeMode = false, super.key});

  final bool changeMode;

  @override
  ConsumerState<SetPinPage> createState() => _SetPinPageState();
}

class _SetPinPageState extends ConsumerState<SetPinPage> {
  final _current = TextEditingController();
  final _pin = TextEditingController();
  final _confirm = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _current.dispose();
    _pin.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.changeMode ? l10n.changePin : l10n.setPinTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          if (widget.changeMode)
            TextField(
              controller: _current,
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(labelText: l10n.currentPin),
            ),
          TextField(
            controller: _pin,
            obscureText: true,
            keyboardType: TextInputType.number,
            maxLength: 6,
            decoration: InputDecoration(labelText: l10n.newPin),
          ),
          TextField(
            controller: _confirm,
            obscureText: true,
            keyboardType: TextInputType.number,
            maxLength: 6,
            decoration: InputDecoration(labelText: l10n.confirmPin),
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            onPressed: _busy ? null : _submit,
            child: Text(_busy ? l10n.commonLoading : l10n.commonSave),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final l10n = context.l10n;
    if (_pin.text != _confirm.text) {
      showSaveFeedback(context, success: false, message: l10n.pinMismatch);
      return;
    }
    setState(() => _busy = true);
    final lock = ref.read(appLockControllerProvider.notifier);
    final result = widget.changeMode
        ? await lock.changePin(
            currentPin: _current.text.trim(),
            newPin: _pin.text.trim(),
          )
        : await lock.setPin(_pin.text.trim());
    setState(() => _busy = false);
    if (!mounted) {
      return;
    }
    presentAsyncResult(
      context,
      result,
      successMessage: l10n.commonSuccess,
      onSuccess: () {
        if (mounted) {
          context.pop();
        }
      },
    );
  }
}
