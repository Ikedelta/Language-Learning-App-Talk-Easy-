import 'package:flutter/foundation.dart';
import 'package:easy_talk/models/flashcard.dart';
import 'package:easy_talk/services/flashcard_service.dart';

class FlashcardProvider extends ChangeNotifier {
  final FlashcardService _flashcardService;
  List<Flashcard> _flashcards = [];
  bool _isLoading = false;
  String? _error;

  FlashcardProvider({FlashcardService? flashcardService})
      : _flashcardService = flashcardService ?? FlashcardService();

  List<Flashcard> get flashcards => _flashcards;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> generateFlashcards({
    required String language,
    required String level,
    String mode = 'flashcards',
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _flashcards = await _flashcardService.generateFlashcards(
        language: language,
        level: level,
        mode: mode,
      );

      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearFlashcards() {
    _flashcards = [];
    _error = null;
    notifyListeners();
  }
} 