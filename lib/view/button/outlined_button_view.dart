import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:template_app/config/app_theme.dart';

class OutlinedButtonView extends StatefulWidget {
  const OutlinedButtonView({
    Key? key,
    required this.onTap,
    required this.title,
    this.textStyle,
    this.width,
    this.height,
    this.radius,
    this.borderColor,
    this.backgroundColor,
    this.padding,
    this.disabled = false,
    this.prefixIcon,
    this.loading = false,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final double? radius;
  final Color? borderColor;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final bool? disabled;
  final Widget? prefixIcon;
  final bool? loading;

  @override
  State<OutlinedButtonView> createState() => _OutlinedButtonViewState();
}

class _OutlinedButtonViewState extends State<OutlinedButtonView> {
  final pushSubject = BehaviorSubject<void>();
  late StreamSubscription<void> pushSubscription;

  @override
  void initState() {
    super.initState();
    pushSubscription = pushSubject.stream
        .debounceTime(const Duration(milliseconds: 1000))
        .listen((event) {
      widget.onTap();
    });
  }

  @override
  void dispose() {
    pushSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: !widget.disabled! ? 1 : 0.3,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 80.0,
        ),
        width: widget.width,
        height: widget.height ?? 40,
        child: widget.prefixIcon == null
            ? _buildOutLinedButton()
            : _buildOutLinedButtonIcon(),
      ),
    );
  }

  OutlinedButton _buildOutLinedButton() {
    return OutlinedButton(
      onPressed: () {
        !widget.disabled! || !widget.loading! ? pushSubject.add(null) : null;
      },
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 4.0),
        ),
        side:
            BorderSide(color: widget.borderColor ?? AppTheme.primaryBlueColor),
        backgroundColor: widget.backgroundColor,
      ),
      child: _buildBodyButton(),
    );
  }

  OutlinedButton _buildOutLinedButtonIcon() {
    return OutlinedButton.icon(
      icon: Flexible(
        child: SizedBox(height: 24, width: 24, child: widget.prefixIcon!),
      ),
      onPressed: !widget.disabled! ? widget.onTap : null,
      label: _buildBodyButton(),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 4.0),
        ),
        side: BorderSide(
            color: widget.backgroundColor ?? AppTheme.primaryBlueColor),
        backgroundColor: widget.backgroundColor,
      ),
    );
  }

  Widget _buildBodyButton() {
    return Padding(
        padding: widget.padding ??
            EdgeInsets.symmetric(
                vertical: 10, horizontal: widget.prefixIcon == null ? 16 : 0),
        child: FittedBox(
          fit: BoxFit.contain,
          child: widget.loading != null && widget.loading!
              ? const CircularProgressIndicator()
              : Text(
                  widget.title,
                  style: widget.textStyle ??
                      const TextStyle(
                        color: AppTheme.primaryBlueColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
        ));
  }
}
