import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakeriot/controllPage.dart';

import 'loginpage.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 171, 174),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to  MUSIC PLAYER ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 60,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(BluetoothSpeakerControlScreen());
                        },
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(20),
                            color: Colors.white,
                          ),
                          child: const Center(
                            child: Text(
                              'Controller',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offAll(const LoginPage());
                          //logout success snackbar
                          Get.snackbar(
                            'Logout Success',
                            'You have been logged out',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor:
                                const Color.fromARGB(206, 255, 255, 255),
                            colorText: Colors.black,
                          );
                        },
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(20),
                            color: Colors.white,
                          ),
                          child: const Center(
                            child: Text(
                              'LogOut',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
