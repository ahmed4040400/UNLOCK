import 'package:http/http.dart' as http;

Future<void> sendDataToESP(String data) async {
  const String espIp = "192.168.1.8";
  final Uri url = Uri.parse('http://$espIp/?data=$data');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print('ESP32 Response: ${response.body}');
    } else {
      print('Failed to send data. HTTP Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error connecting to ESP32: $e');
  }
}
