import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/flashcard_provider.dart';

class FlashcardScreen extends StatefulWidget {
  final String language;
  final String level;

  const FlashcardScreen({
    super.key,
    required this.language,
    required this.level,
  });

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final PageController _pageController = PageController();
  bool _isCardFlipped = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Generate flashcards when the screen is first loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FlashcardProvider>().generateFlashcards(
        language: widget.language,
        level: widget.level,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _flipCard() {
    setState(() {
      _isCardFlipped = !_isCardFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.language} Flashcards'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              final provider = context.read<FlashcardProvider>();
              provider.generateFlashcards(
                language: widget.language,
                level: widget.level,
              );
            },
          ),
        ],
      ),
      body: Consumer<FlashcardProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${provider.error}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      provider.generateFlashcards(
                        language: widget.language,
                        level: widget.level,
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final flashcards = provider.flashcards;
          if (flashcards.isEmpty) {
            return const Center(
              child: Text('No flashcards available'),
            );
          }

          return PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
                _isCardFlipped = false;
              });
            },
            itemCount: flashcards.length,
            itemBuilder: (context, index) {
              final flashcard = flashcards[index];
              return GestureDetector(
                onTap: _flipCard,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    width: double.infinity,
                    height: 200,
                    child: Card(
                      elevation: 4,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return RotationTransition(
                            turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                            child: child,
                          );
                        },
                        child: Center(
                          key: ValueKey<bool>(_isCardFlipped),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _isCardFlipped ? flashcard.translation : flashcard.word,
                                  style: Theme.of(context).textTheme.headlineSmall,
                                  textAlign: TextAlign.center,
                                ),
                                if (!_isCardFlipped && flashcard.pronunciation.isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    flashcard.pronunciation,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontStyle: FontStyle.italic,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}