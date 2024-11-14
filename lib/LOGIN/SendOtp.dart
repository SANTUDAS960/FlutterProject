import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:internship1/LOGIN/VerifyOtp.dart';

class OTPService {
  final String accountSid = 'ACe32d201b9exxxxxxxxxxx3703e9996ac';
  final String authToken = 'a1f07bf92425698fa7cxxxxxxxx21b3d22';
  final String twilioNumber = '+18597803908';

  String generateOtp() {
    final random = Random();
    return (random.nextInt(9000) + 1000).toString(); // Generates a 4-digit OTP
  }

  Future<void> sendOtp(String phoneNumber, BuildContext context) async {
    String otp = generateOtp();
    String messageBody = 'Your OTP is $otp';

    final url = Uri.parse(
        'https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json');

    final response = await http.post(
      url,
      headers: {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$accountSid:$authToken'))}',
      },
      body: {
        'From': twilioNumber,
        'To': phoneNumber,
        'Body': messageBody,
      },
    );

    if (response.statusCode == 201) {
      print('OTP sent successfully to $phoneNumber');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VerifyOtp(sentOtp: otp)),
      );
    } else {
      print('Failed to send OTP: ${response.statusCode} - ${response.body}');
    }
  }
}
