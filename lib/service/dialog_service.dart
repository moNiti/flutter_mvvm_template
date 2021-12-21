import 'package:flutter/material.dart';

typedef DialogOptionBuilder<T> = Map<String, DialogValue> Function();

class DialogValue {
  final TextStyle? textStyle;
  final bool value;

  DialogValue({this.textStyle, required this.value});
}

class DialogService {
  static final DialogService _dialogService = DialogService._internal();
  factory DialogService() {
    return _dialogService;
  }
  DialogService._internal();

  Future<T?> showGenericDialog<T>({
    required BuildContext context,
    required String title,
    required String content,
    required DialogOptionBuilder optionBuilder,
  }) {
    final options = optionBuilder();
    return showDialog<T>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: options.keys.map((key) {
            final DialogValue dialogValue = options[key]!;
            return TextButton(
                onPressed: () => Navigator.of(context).pop(dialogValue.value),
                child: Text(
                  key,
                  style: dialogValue.textStyle,
                ));
          }).toList(),
        );
      },
    );
  }

  Future<T?> showConfirmDialog<T>({
    required BuildContext context,
    String? title,
    String? content,
  }) async {
    return showGenericDialog<T>(
        context: context,
        title: title ?? "คุณยืนยัน",
        content: content ?? "คุณยืนยัน",
        optionBuilder: () => {
              "Confirm": DialogValue(
                  value: true, textStyle: const TextStyle(color: Colors.green)),
              "Cancel": DialogValue(
                  value: false, textStyle: const TextStyle(color: Colors.red))
            });
  }
}
