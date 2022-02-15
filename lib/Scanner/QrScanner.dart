// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sm/Master/Global.dart';
import 'package:sm/Scanner/Results.dart';

class QrReader extends StatefulWidget {
  const QrReader({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrReaderState();
}

class _QrReaderState extends State<QrReader> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  bool flash = false;
  bool toggleBtn = false;
  void changeAction(bool param) async {
    if (param) {
      await controller?.pauseCamera();
    } else {
      await controller?.resumeCamera();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size frame = MediaQuery.of(context).size;
    /***Navigates to the next page when data is scanned */
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.settings),
        onPressed: () {
          showCupertinoModalPopup(
              context: context,
              builder: (context) {
                // ignore: avoid_unnecessary_containers
                return BottomSheet(
                    backgroundColor: Colors.transparent,
                    clipBehavior: Clip.antiAlias,
                    enableDrag: true,
                    onClosing: () {},
                    builder: (context) => bottomAction(context));
              });
        },
      ),
      body: Stack(
        children: <Widget>[
          Expanded(flex: 9, child: _buildQrView(context)),
          Positioned(
            bottom: frame.height / 5,
            left: frame.width / 2.3,
            child: CircleAvatar(
              radius: 33,
              child: IconButton(
                iconSize: 30,
                onPressed: () {
                  setState(() {
                    toggleBtn = !toggleBtn;
                    changeAction(toggleBtn);
                  });
                },
                icon: Icon(
                  toggleBtn == false ? Icons.pause : Icons.play_arrow_rounded,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 350.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.green,
          borderRadius: 10,
          borderLength: 10,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      // ignore: unnecessary_null_comparison
      if (scanData != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Results(
              data: '${scanData.code}',
            ),
            fullscreenDialog: true,
          ),
        );
        changeAction(true);
      }

      setState(() {});
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  Widget bottomAction(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        color: Colors.white,
        // ignore: prefer_const_constructors
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(50),
          topRight: const Radius.circular(50),
        ),
      ),
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.flash_on_rounded),
            title: FutureBuilder(
              future: controller?.getFlashStatus(),
              builder: (context, snapshot) {
                return const Text('Flash light');
              },
            ),
            onTap: () async {
              await controller?.toggleFlash();
              Navigator.pop(context);
              setState(() {
                flash = !flash;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(flash ? 'Flash on' : "Flash off")),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera),
            title: FutureBuilder(
              future: controller?.getCameraInfo(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Text('Camera facing ${describeEnum(snapshot.data!)}');
                } else {
                  return const CircularProgressIndicator.adaptive();
                }
              },
            ),
            onTap: () async {
              await controller?.flipCamera();
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
