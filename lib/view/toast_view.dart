import 'package:flutter/material.dart';
import 'package:template_app/config/app_theme.dart';

enum ToastStatus { error, success, warning }

class ToastView extends StatelessWidget {
  ToastView({
    Key? key,
    required this.message,
    required this.status,
    required this.removeCustomToast,
  }) : super(key: key);
  final String message;
  final ToastStatus status;
  final VoidCallback removeCustomToast;

  final Map<ToastStatus, Color> color = {
    ToastStatus.success: AppTheme.statsColorSuccess,
    ToastStatus.warning: AppTheme.statusColorWarning,
    ToastStatus.error: AppTheme.statusColorError,
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 1,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: color[status]!.withOpacity(.5),
          ),
          child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildStatusIcon(),
        const SizedBox(width: 12.0),
        Flexible(
          child: Text(
            message,
            softWrap: false,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 18.0),
        InkWell(onTap: removeCustomToast, child: const Icon(Icons.close)),
      ],
    );
  }

  Widget _buildStatusIcon() {
    return Container(
      height: 24,
      width: 24,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: Icon(
        status == ToastStatus.success
            ? Icons.check
            : status == ToastStatus.warning
                ? Icons.info
                : Icons.cancel_outlined,
        color: color[status],
      ),
    );
  }
}
