import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:template_app/service/dialog_service.dart';
import 'package:template_app/view/button/outlined_button_view.dart';
import 'package:template_app/view/toast_view.dart';

import 'home_viewmodel.dart';
import '../../extension//string_extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel? _viewModel;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (viewModel) async {
        _viewModel = viewModel;
        try {
          await viewModel.loadData();
        } on ErrorLink catch (ex) {
          ex.toString().showAsToast(context, status: ToastStatus.error);
        } on DioError catch (ex) {
          ex.toString().showAsToast(context, status: ToastStatus.error);
        }
      },
      builder: (context, viewModel, child) =>
          _buildScaffold(context, viewModel, child),
    );
  }

  Scaffold _buildScaffold(
      BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TEMPLATE APP"),
      ),
      body: viewModel.isBusy
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                children: [
                  const Text("Template app by momos"),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    overflowButtonSpacing: 5,
                    children: [
                      OutlinedButtonView(
                        key: const Key("submit"),
                        loading: viewModel.busy(viewModel.submitButtonBusyKey),
                        onTap: () async {
                          bool success = await viewModel.onButtonTap();
                          "Success".showAsToast(context,
                              status: ToastStatus.success);
                        },
                        title: "Submit",
                      ),
                      OutlinedButtonView(
                        onTap: () async {
                          final value = await DialogService().showGenericDialog(
                            context: context,
                            title: "Confirm",
                            content: "คุณยืนยันที่จะ ...",
                            optionBuilder: () => {
                              "Confirm": DialogValue(
                                  value: true,
                                  textStyle:
                                      const TextStyle(color: Colors.green)),
                              "Cancel": DialogValue(
                                  value: false,
                                  textStyle: const TextStyle(color: Colors.red))
                            },
                          );
                          debugPrint("VALUE => $value");
                        },
                        title: "Generic Dialog",
                      ),
                      OutlinedButtonView(
                        onTap: () {
                          DialogService().showConfirmDialog(context: context);
                        },
                        title: "Confirm Dialog",
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
