import 'dart:io';
import 'dart:typed_data';

void main() {
  // Create placeholder images
  _createPlaceholderImage('assets/images/english_beginner.jpg');
  _createPlaceholderImage('assets/images/english_intermediate.jpg');
  _createPlaceholderImage('assets/images/english_advanced.jpg');

  // Create placeholder audio files
  _createPlaceholderAudio('assets/audio/eng_beg_1_1.mp3');
  _createPlaceholderAudio('assets/audio/eng_beg_1_2.mp3');
  _createPlaceholderAudio('assets/audio/eng_int_1_1.mp3');
  _createPlaceholderAudio('assets/audio/eng_int_1_2.mp3');
  _createPlaceholderAudio('assets/audio/eng_adv_1_1.mp3');
  _createPlaceholderAudio('assets/audio/eng_adv_1_2.mp3');

  // Create placeholder video files
  _createPlaceholderVideo('assets/video/eng_beg_1_1.mp4');
  _createPlaceholderVideo('assets/video/eng_beg_1_2.mp4');
  _createPlaceholderVideo('assets/video/eng_int_1_1.mp4');
  _createPlaceholderVideo('assets/video/eng_int_1_2.mp4');
  _createPlaceholderVideo('assets/video/eng_adv_1_1.mp4');
  _createPlaceholderVideo('assets/video/eng_adv_1_2.mp4');

  print('Placeholder assets created successfully!');
}

void _createPlaceholderImage(String path) {
  final file = File(path);
  if (!file.existsSync()) {
    file.createSync(recursive: true);
    // Create a simple placeholder image with text
    final imageData = '''
      <svg width="400" height="300" xmlns="http://www.w3.org/2000/svg">
        <rect width="400" height="300" fill="#f0f0f0"/>
        <text x="50%" y="50%" font-family="Arial" font-size="24" fill="#333" text-anchor="middle">
          ${path.split('/').last.split('.').first}
        </text>
      </svg>
    ''';
    file.writeAsStringSync(imageData);
  }
}

void _createPlaceholderAudio(String path) {
  final file = File(path);
  if (!file.existsSync()) {
    file.createSync(recursive: true);
    // Create a simple placeholder audio file
    final audioData = Uint8List(1024); // 1KB of silence
    file.writeAsBytesSync(audioData);
  }
}

void _createPlaceholderVideo(String path) {
  final file = File(path);
  if (!file.existsSync()) {
    file.createSync(recursive: true);
    // Create a simple placeholder video file
    final videoData = Uint8List(1024 * 1024); // 1MB of placeholder data
    file.writeAsBytesSync(videoData);
  }
} 