import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internship1/LOGIN/VerifyOtp.dart';
import 'SendOtp.dart'; // Import the SendOtp file

class OtpLogin extends StatefulWidget {
  const OtpLogin({super.key});

  @override
  State<OtpLogin> createState() => _OtpLoginState();
}

class _OtpLoginState extends State<OtpLogin> {
  String selectedCountryCode = "+91"; // Default country code
  final TextEditingController phoneNumberController = TextEditingController();
  bool isContinueButton = true; // Flag to toggle button text
  final OTPService otpService = OTPService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Back",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text(
                "Log In",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enter your mobile number. We will send a\nconfirmation code to your number.",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    DropdownButton<String>(
                      value: selectedCountryCode,
                      items: <String>['+91', '+1', '+44', '+61', '+81']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCountryCode = newValue!;
                        });
                      },
                      underline: SizedBox(), // Removes the default underline
                    ),
                    VerticalDivider(color: Colors.grey),
                    Expanded(
                      child: TextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        controller: phoneNumberController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Mobile Number',
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (isContinueButton) {
                      // Step 1: Validate phone number
                      if (_checkNumber(phoneNumberController.text) == true) {
                        setState(() {
                          isContinueButton = false; // Change to "Send OTP"
                        });
                      }
                    } else {
                      // Step 2: Send OTP on "Send OTP" click
                      String phoneNumber =
                          selectedCountryCode + phoneNumberController.text;
                      otpService.sendOtp(phoneNumber, context).then((_) {
                        Fluttertoast.showToast(
                          msg: "OTP sent successfully to $phoneNumber",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.green,
                        );
                      }).catchError((error) {
                        Fluttertoast.showToast(
                          msg: "Failed to send OTP",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.red,
                        );
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.orange,
                  ),
                  child: Text(
                    isContinueButton ? "Continue" : "Send OTP",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 200),
              // login with another way.
              // another way
              const SizedBox(
                height: 20,
              ),
              const Center(
                  child: Text(
                "Or login with via social networks",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              )),
              const SizedBox(height: 10),
              // Drawable Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Add your button functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.orange, // Button color
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/image/google.png",
                        height: 30,
                        width: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 13),
                        child: Text(
                          "Login with Gmail",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Drawable Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Add your button functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.orange, // Button color
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/image/facebook.png",
                        height: 30,
                        width: 33,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 13),
                        child: Text(
                          "Login with Facebook",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
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

  bool? _checkNumber(String _phonenumber) {
    if (_phonenumber.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter the Phone Number",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
      );
      return false;
    } else if (_phonenumber.length != 10) {
      Fluttertoast.showToast(
        msg: "Please Enter 10 digit Phone Number",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
      );
      return false;
    } else if (_phonenumber.isNotEmpty &&
        !(_phonenumber[0] == '9' ||
            _phonenumber[0] == '7' ||
            _phonenumber[0] == '8' ||
            _phonenumber[0] == '6')) {
      Fluttertoast.showToast(
        msg: "Please Enter Valid Phone Number",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
      );
      return false;
    }
    return true;
  }
}
