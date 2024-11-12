import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:internship1/HOME/Home.dart';

class VerifyOtp extends StatefulWidget {
  final String sentOtp;

  const VerifyOtp({Key? key, required this.sentOtp}) : super(key: key);

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  bool _isButtonEnabled = false;
  int _secondsRemaining = 60;
  Timer? _timer;
  String message = "";
  bool buttonBackground = false;
  bool messageColor = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _otpController1.addListener(_onOtpChange);
    _otpController2.addListener(_onOtpChange);
    _otpController3.addListener(_onOtpChange);
    _otpController4.addListener(_onOtpChange);
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController1.dispose();
    _otpController2.dispose();
    _otpController3.dispose();
    _otpController4.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    super.dispose();
  }

  void _onOtpChange() {
    setState(() {
      _isButtonEnabled = _otpController1.text.isNotEmpty &&
          _otpController2.text.isNotEmpty &&
          _otpController3.text.isNotEmpty &&
          _otpController4.text.isNotEmpty;
    });
  }

  void _onFieldChanged(String value, FocusNode nextFocusNode) {
    if (value.length == 1) {
      FocusScope.of(context).requestFocus(nextFocusNode);
    }
  }

  void _verifyOtp() {
    String enteredOtp = _otpController1.text +
        _otpController2.text +
        _otpController3.text +
        _otpController4.text;

    if (enteredOtp == widget.sentOtp) {
      setState(() {
        messageColor = true;
        message = "OTP verified successfully!";
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      setState(() {
        messageColor = false;
        message = "Invalid OTP. Please try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Back", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            const Text(
              "Log In",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            const Text(
              "Enter the 4 digit code that has been sent to your registered number.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 64,
                  width: 64,
                  child: TextField(
                    focusNode: _focusNode1,
                    onChanged: (value) => _onFieldChanged(value, _focusNode2),
                    controller: _otpController1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [LengthLimitingTextInputFormatter(1)],
                  ),
                ),
                SizedBox(
                  height: 64,
                  width: 64,
                  child: TextField(
                    focusNode: _focusNode2,
                    onChanged: (value) => _onFieldChanged(value, _focusNode3),
                    controller: _otpController2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [LengthLimitingTextInputFormatter(1)],
                  ),
                ),
                SizedBox(
                  height: 64,
                  width: 64,
                  child: TextField(
                    focusNode: _focusNode3,
                    onChanged: (value) => _onFieldChanged(value, _focusNode4),
                    controller: _otpController3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [LengthLimitingTextInputFormatter(1)],
                  ),
                ),
                SizedBox(
                  height: 64,
                  width: 64,
                  child: TextField(
                    focusNode: _focusNode4,
                    onChanged: (value) {
                      if (value.length == 1) {
                        _focusNode4.unfocus();
                      }
                      setState(() {
                        buttonBackground = true;
                      });
                    },
                    controller: _otpController4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [LengthLimitingTextInputFormatter(1)],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(message,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: messageColor ? Colors.green : Colors.red)),
            ),
            SizedBox(height: 70),
            Center(
              child: SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled ? _verifyOtp : null,
                  child: Text("Continue"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        buttonBackground ? Colors.orange : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: InkWell(
                onTap: () {
                  if (_secondsRemaining == 0) {
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  _secondsRemaining > 0
                      ? "We can send it again in $_secondsRemaining seconds"
                      : "Resend Code",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
