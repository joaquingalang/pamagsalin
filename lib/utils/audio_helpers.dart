import 'dart:io';
import 'dart:typed_data';

Future<String> saveBufferAsWav(List<int> buffer, int sampleRate, int numChannels) async {
  final dir = await Directory.systemTemp.createTemp();
  final filePath = '${dir.path}/utterance_${DateTime.now().millisecondsSinceEpoch}.wav';
  final wavData = _convertPcmToWav(Uint8List.fromList(buffer), sampleRate, numChannels);
  final file = File(filePath);
  await file.writeAsBytes(wavData, flush: true);
  return filePath;
}

Uint8List _convertPcmToWav(Uint8List pcmData, int sampleRate, int numChannels) {
  final byteRate = sampleRate * numChannels * 2;
  final blockAlign = numChannels * 2;
  final dataLength = pcmData.length;
  final header = BytesBuilder();

  header.add([
    ...'RIFF'.codeUnits,
    ..._intToBytes(36 + dataLength, 4),
    ...'WAVE'.codeUnits,
    ...'fmt '.codeUnits,
    ..._intToBytes(16, 4), // Subchunk1Size
    ..._intToBytes(1, 2), // AudioFormat (PCM)
    ..._intToBytes(numChannels, 2),
    ..._intToBytes(sampleRate, 4),
    ..._intToBytes(byteRate, 4),
    ..._intToBytes(blockAlign, 2),
    ..._intToBytes(16, 2), // BitsPerSample
    ...'data'.codeUnits,
    ..._intToBytes(dataLength, 4),
  ]);
  header.add(pcmData);

  return header.toBytes();
}

List<int> _intToBytes(int value, int bytes) {
  final result = <int>[];
  for (int i = 0; i < bytes; i++) {
    result.add((value >> (8 * i)) & 0xFF);
  }
  return result;
}

List<double> updateDecibalList(List<double> decibals, double newDecibals) {
  decibals.add(newDecibals);
  return decibals.sublist(1, decibals.length);
}

bool hasHighDecibals(List<double> decibals, double thresholdDb) {
  for (double decibal in decibals) {
    if (decibal >= thresholdDb) {
      return true;
    }
  }
  return false;
}