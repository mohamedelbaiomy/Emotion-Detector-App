import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tensorflow_lite_flutter/tensorflow_lite_flutter.dart';
import 'main.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CameraController cameraController;
  String output = '';
  String confidence = '';

  @override
  void initState() {
    super.initState();
    loadCamera();
    loadModel();
  }

  loadCamera() {
    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.max,
    );
    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController.startImageStream((imageStream) {
            runModel(imageStream);
          });
        });
      }
    });
  }

  runModel(CameraImage image) async {
    var predections = await Tflite.runModelOnFrame(
      bytesList: image.planes.map((plane) {
        return plane.bytes;
      }).toList(),
      imageHeight: image.height,
      imageWidth: image.width,
      imageMean: 127.5,
      imageStd: 127.5,
      rotation: 90,
      numResults: 1,
      threshold: 0.1,
      asynch: true,
    );
    for (var element in predections!) {
      setState(() {
        output = element['label'];
        confidence =
            (element['confidence'] * 100).toStringAsFixed(0).toString();
      });
    }
  }

  loadModel() async {
    //await Tflite.close();
    await Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: 'assets/labels.txt',
    );
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Emotion Detector"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                child: !cameraController.value.isInitialized
                    ? Container()
                    : AspectRatio(
                        aspectRatio: cameraController.value.aspectRatio,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CameraPreview(cameraController),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  output.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '$confidence %',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Don't forget to contact me on social media",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 30,
                left: 30,
                top: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      var whatsapp = "+201009429689";
                      final Uri url = Uri.parse(
                        "whatsapp://send?phone=$whatsapp&text=ازيك ي محمد",
                      );
                      Future<void> _launchUrl() async {
                        if (!await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        )) {
                          throw 'Could not launch $url';
                        }
                      }

                      _launchUrl();
                    },
                    child: const Icon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.green,
                      size: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final Uri url = Uri.parse(
                        "https://www.facebook.com/Original262003",
                      );
                      Future<void> _launchUrl() async {
                        if (!await launchUrl(
                          url,
                          mode: LaunchMode.externalNonBrowserApplication,
                        )) {
                          throw 'Could not launch $url';
                        }
                      }

                      _launchUrl();
                    },
                    child: const Icon(
                      FontAwesomeIcons.facebook,
                      color: Colors.blue,
                      size: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final Uri url = Uri.parse(
                        "https://play.google.com/store/apps/details?id=customers_app_google_play.com.customers_app_google_play",
                      );
                      Future<void> _launchUrl() async {
                        if (!await launchUrl(
                          url,
                          mode: LaunchMode.externalNonBrowserApplication,
                        )) {
                          throw 'Could not launch $url';
                        }
                      }

                      _launchUrl();
                    },
                    child: const Icon(
                      FontAwesomeIcons.googlePlay,
                      color: Colors.deepOrange,
                      size: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final Uri url = Uri.parse(
                        "https://www.instagram.com/mohamed_elbaiomy262003/?igshid=ZDdkNTZiNTM%3D",
                      );
                      Future<void> _launchUrl() async {
                        if (!await launchUrl(
                          url,
                          mode: LaunchMode.externalNonBrowserApplication,
                        )) {
                          throw 'Could not launch $url';
                        }
                      }

                      _launchUrl();
                    },
                    child: const Icon(
                      FontAwesomeIcons.instagram,
                      color: Colors.deepOrange,
                      size: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final Uri url = Uri.parse(
                        "https://www.linkedin.com/in/mohamed-elbaiomy-7b12b6191",
                      );
                      Future<void> _launchUrl() async {
                        if (!await launchUrl(
                          url,
                          mode: LaunchMode.externalNonBrowserApplication,
                        )) {
                          throw 'Could not launch $url';
                        }
                      }

                      _launchUrl();
                    },
                    child: Icon(
                      FontAwesomeIcons.linkedinIn,
                      color: Colors.blue[300]!,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
