import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:organizzer/resources/constants.dart';
import 'package:organizzer/presenter/components/main_icon_button.dart';
import 'package:organizzer/utils/copy_to_clipboard.dart';
import 'package:organizzer/utils/abrir_url.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key});

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  final controller = MobileScannerController();
  String? scanneado;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              if (capture.barcodes.isEmpty) return;
              setState(() {
                scanneado = capture.barcodes.first.rawValue;
              });
            },
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(kMainPadding),
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Row(
                    children: [
                      MainIconButton.back(
                        onTap: () => context.pop(),
                      ),
                      Spacer(),
                      ValueListenableBuilder(
                        valueListenable: controller.torchState,
                        builder: (context, state, child) {
                          return MainIconButton(
                            icon: state == TorchState.on ? Icons.flashlight_on : Icons.flashlight_off,
                            onTap: () => controller.toggleTorch(),
                          );
                        },
                      ),
                    ],
                  ),
                  Spacer(),
                  Material(
                    borderRadius: BorderRadius.circular(kMainBorderRadius),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kMainPadding,
                        vertical: kMainPadding,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              scanneado ?? 'Nada ainda...',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: kMainPadding),
                          GestureDetector(
                            onTap: () async {
                              try {
                                if (scanneado == null) return;
                                await abrirUrl(scanneado!);
                              } finally {
                                //
                              }
                            },
                            child: Icon(Icons.open_in_new),
                          ),
                          const SizedBox(width: kMainPadding),
                          GestureDetector(
                            onTap: () {
                              if (scanneado == null) return;
                              copyToClipboard(scanneado!);
                            },
                            child: Icon(Icons.copy),
                          ),
                          // IconButton(
                          //   onPressed: () async {
                          //     try {
                          //       if (scanneado == null) return;
                          //       await abrirUrl(scanneado!);
                          //     } finally {
                          //       //
                          //     }
                          //   },
                          //   icon: Icon(Icons.open_in_new),
                          // ),
                          // IconButton(
                          //   onPressed: () {
                          //     if (scanneado == null) return;
                          //     copyToClipboard(scanneado!);
                          //   },
                          //   icon: Icon(Icons.copy),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
