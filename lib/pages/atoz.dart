
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';

class ItemTile extends StatelessWidget {
  final int index;
  final List<ItemData> items;
  final bool isTimerEnabled;

  const ItemTile({
    Key? key,
    required this.index,
    required this.items,
    required this.isTimerEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = items[index];
    return Card(
      color: item.backgroundColor,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return _PopupDialog(
                items: items,
                currentIndex: index,
                isAutoNextEnabled: isTimerEnabled,
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                item.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 3),
              SvgPicture.asset(
                item.iconAsset,
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.3,
                alignment: Alignment.center,
              ),
              const SizedBox(height: 3),
              Text(item.description, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

class _PopupDialog extends StatefulWidget {
  final List<ItemData> items;
  final int currentIndex;
  final bool isAutoNextEnabled;

  const _PopupDialog({
    Key? key,
    required this.items,
    required this.currentIndex,
    required this.isAutoNextEnabled,
  }) : super(key: key);

  @override
  _PopupDialogState createState() => _PopupDialogState();
}

class _PopupDialogState extends State<_PopupDialog> {
  late FlutterTts flutterTts;
  late int currentIndex;
  late Timer? timer;
  late bool isAutoNextEnabled;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    currentIndex = widget.currentIndex;
    isAutoNextEnabled = widget.isAutoNextEnabled;

    _speakDescription();
    if (isAutoNextEnabled) {
      timer = Timer.periodic(const Duration(seconds: 3), (Timer t) {
        _nextItem();
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> _speakDescription() async {
    final currentItem = widget.items[currentIndex];
    await flutterTts.setLanguage("EN-IN");
    await flutterTts.speak(currentItem.title);
    await flutterTts.speak(currentItem.description);
  }

  Future<void> _speakText(String text) async {
    await flutterTts.speak(text);
  }

  void _previousItem() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
        _speakDescription();
      }
    });
  }

  void _nextItem() {
    setState(() {
      if (currentIndex < widget.items.length - 1) {
        currentIndex++;
        _speakDescription();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = widget.items[currentIndex];
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Container(
        padding: EdgeInsets.zero,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          color: currentItem.backgroundColor,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                currentItem.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  _speakText(currentItem.description);
                },
                child: SvgPicture.asset(
                  currentItem.iconAsset,
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.5,
                  alignment: Alignment.center,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                currentItem.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _previousItem,
                    child: const Text('Prev'),
                  ),
                  ElevatedButton(
                    onPressed: _nextItem,
                    child: const Text('Next'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(216, 233, 101, 92),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemData {
  final String iconAsset;
  final String title;
  final String description;
  final Color backgroundColor;

  ItemData({
    required this.iconAsset,
    required this.title,
    required this.description,
    required this.backgroundColor,
  });
}

class AtoZ extends StatefulWidget {
  const AtoZ({Key? key}) : super(key: key);

  @override
  State<AtoZ> createState() => _AtoZState();
}

class _AtoZState extends State<AtoZ> {
  bool isTimerEnabled = false;

  List<ItemData> items = [
    // Add your ItemData list here
    // Example:
    ItemData(
      iconAsset: 'assets/images/apple.svg',
      title: 'A - а',
      description: 'Алма',
      backgroundColor: const Color.fromARGB(115, 171, 171, 171),
    ),
    ItemData(
      iconAsset: 'assets/images/rooster.svg',
      title: 'Ә - ә',
      description: 'Әтеш',
      backgroundColor: const Color.fromARGB(115, 215, 118, 118),
    ),
    ItemData(
      iconAsset: 'assets/images/cat.svg',
      title: 'Б - б',
      description: 'Cat',
      backgroundColor: const Color.fromARGB(194, 130, 243, 69),
    ),
    ItemData(
      iconAsset: 'assets/images/dog.svg',
      title: 'В - в',
      description: 'Dog',
      backgroundColor: const Color.fromARGB(115, 215, 199, 118),
    ),
    ItemData(
      iconAsset: 'assets/images/elephant.svg',
      title: 'Г - г',
      description: 'Elephant',
      backgroundColor: const Color.fromARGB(115, 118, 215, 173),
    ),
    ItemData(
      iconAsset: 'assets/images/fish.svg',
      title: 'Ғ - ғ',
      description: 'Fish',
      backgroundColor: const Color.fromARGB(115, 150, 118, 215),
    ),
    ItemData(
      iconAsset: 'assets/images/grapes.svg',
      title: 'Д - д',
      backgroundColor: const Color.fromARGB(115, 215, 118, 175),
      description: 'Grapes',
    ),
    ItemData(
      iconAsset: 'assets/images/horse.svg',
      title: 'Е - е',
      backgroundColor: const Color.fromARGB(115, 157, 215, 118),
      description: 'Horse',
    ),
    ItemData(
      iconAsset: 'assets/images/icecream.svg',
      title: 'Ё - ё',
      backgroundColor: const Color.fromARGB(221, 176, 102, 220),
      description: 'Ice-Cream',
    ),
    ItemData(
      iconAsset: 'assets/images/joker.svg',
      title: 'Ж - ж',
      description: 'Joker',
      backgroundColor: const Color.fromARGB(208, 112, 181, 206),
    ),
    ItemData(
      iconAsset: 'assets/images/king.svg',
      title: 'З - з',
      backgroundColor: const Color.fromARGB(115, 171, 215, 118),
      description: 'King',
    ),
    ItemData(
      iconAsset: 'assets/images/lion.svg',
      title: 'И - и',
      description: 'Lion',
      backgroundColor: const Color.fromARGB(236, 235, 229, 53),
    ),
    ItemData(
      iconAsset: 'assets/images/money.svg',
      title: 'Й - й',
      description: 'Money',
      backgroundColor: const Color.fromARGB(115, 118, 189, 215),
    ),
    ItemData(
      iconAsset: 'assets/images/nest.svg',
      title: 'К - к',
      description: 'Nest',
      backgroundColor: const Color.fromARGB(115, 118, 215, 121),
    ),
    ItemData(
      iconAsset: 'assets/images/orange.svg',
      title: 'Қ - қ',
      description: 'Orange',
      backgroundColor: const Color.fromARGB(115, 215, 189, 118),
    ),
    ItemData(
      iconAsset: 'assets/images/parrot.svg',
      title: 'Л - л',
      backgroundColor: const Color.fromARGB(115, 120, 118, 215),
      description: 'Parrot',
    ),
    ItemData(
      iconAsset: 'assets/images/queen.svg',
      title: 'М - м',
      backgroundColor: const Color.fromARGB(115, 215, 118, 118),
      description: 'Queen',
    ),
    ItemData(
      iconAsset: 'assets/images/rabbit.svg',
      title: 'Н - н',
      description: 'Rabbit',
      backgroundColor: const Color.fromARGB(174, 134, 218, 191),
    ),
    ItemData(
      iconAsset: 'assets/images/shiva.svg',
      title: 'Ң - ң',
      backgroundColor: const Color.fromARGB(170, 156, 216, 145),
      description: 'Shiva',
    ),
    ItemData(
      iconAsset: 'assets/images/table.svg',
      title: 'О - о',
      backgroundColor: const Color.fromARGB(180, 138, 64, 228),
      description: 'Table',
    ),
    ItemData(
      iconAsset: 'assets/images/umbrella.svg',
      title: 'Ө - ө',
      backgroundColor: const Color.fromARGB(189, 212, 127, 220),
      description: 'Umbrella',
    ),
    ItemData(
      iconAsset: 'assets/images/van.svg',
      title: 'П - п',
      backgroundColor: const Color.fromARGB(115, 215, 118, 118),
      description: 'Van',
    ),
    ItemData(
      iconAsset: 'assets/images/window.svg',
      title: 'Р - р',
      backgroundColor: const Color.fromARGB(246, 255, 194, 25),
      description: 'Window',
    ),
    ItemData(
      iconAsset: 'assets/images/xerox.svg',
      title: 'С - с',
      backgroundColor: const Color.fromARGB(115, 0, 236, 71),
      description: 'Xerox',
    ),
    ItemData(
      iconAsset: 'assets/images/yellow.svg',
      title: 'Т - т',
      backgroundColor: const Color.fromARGB(115, 9, 255, 230),
      description: 'Yellow',
    ),
    ItemData(
      iconAsset: 'assets/images/zero.svg',
      title: 'У - у',
      backgroundColor: const Color.fromARGB(155, 81, 0, 255),
      description: 'Zero',
    ),
    ItemData(
      iconAsset: 'assets/images/zero.svg',
      title: 'Ұ - ұ',
      backgroundColor: const Color.fromARGB(155, 81, 0, 255),
      description: 'Zero',
    ),
    ItemData(
      iconAsset: 'assets/images/zero.svg',
      title: 'Ү - ү',
      backgroundColor: const Color.fromARGB(155, 81, 0, 255),
      description: 'Zero',
    ),
    ItemData(
      iconAsset: 'assets/images/zero.svg',
      title: 'Ф - ф',
      backgroundColor: const Color.fromARGB(155, 81, 0, 255),
      description: 'Zero',
    ),
    ItemData(
      iconAsset: 'assets/images/zero.svg',
      title: 'Х - х',
      backgroundColor: const Color.fromARGB(155, 81, 0, 255),
      description: 'Zero',
    ),
    ItemData(
      iconAsset: 'assets/images/zero.svg',
      title: 'Һ - һ',
      backgroundColor: const Color.fromARGB(155, 81, 0, 255),
      description: 'Zero',
    ),
    ItemData(
      iconAsset: 'assets/images/zero.svg',
      title: 'Ц - ц',
      backgroundColor: const Color.fromARGB(155, 81, 0, 255),
      description: 'Zero',
    ),
    ItemData(
      iconAsset: 'assets/images/zero.svg',
      title: 'Ч - ч',
      backgroundColor: const Color.fromARGB(155, 81, 0, 255),
      description: 'Zero',
    ),
    ItemData(
      iconAsset: 'assets/images/zero.svg',
      title: 'Ш - ш',
      backgroundColor: const Color.fromARGB(155, 81, 0, 255),
      description: 'Zero',
    ),
    ItemData(
      iconAsset: 'assets/images/zero.svg',
      title: 'Щ - щ',
      backgroundColor: const Color.fromARGB(155, 81, 0, 255),
      description: 'Zero',
    ),
    ItemData(
      iconAsset: 'assets/images/zero.svg',
      title: 'Ъ - ъ',
      backgroundColor: const Color.fromARGB(155, 81, 0, 255),
      description: 'Zero',
    ),
    ItemData(
      iconAsset: 'assets/images/zero.svg',
      title: 'Ы - ы',
      backgroundColor: const Color.fromARGB(155, 81, 0, 255),
      description: 'Zero',
    ),
    ItemData(
      iconAsset: 'assets/images/zero.svg',
      title: 'І - і',
      backgroundColor: const Color.fromARGB(155, 81, 0, 255),
      description: 'Zero',
    ),
    ItemData(
      iconAsset: 'assets/images/zero.svg',
      title: 'Ь - ь',
      backgroundColor: const Color.fromARGB(155, 81, 0, 255),
      description: 'Zero',
    ),
    ItemData(
      iconAsset: 'assets/images/zero.svg',
      title: 'Э - э',
      backgroundColor: const Color.fromARGB(155, 81, 0, 255),
      description: 'Zero',
    ),
    ItemData(
      iconAsset: 'assets/images/zero.svg',
      title: 'Ю - ю',
      backgroundColor: const Color.fromARGB(155, 81, 0, 255),
      description: 'Zero',
    ),
    ItemData(
      iconAsset: 'assets/images/zero.svg',
      title: 'Я - я',
      backgroundColor: const Color.fromARGB(155, 81, 0, 255),
      description: 'Zero',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'A-Z',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: isTimerEnabled
                        ? MaterialStateProperty.all(Colors.green)
                        : MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                    setState(() {
                      isTimerEnabled = !isTimerEnabled;
                    });
                  },
                  child: const Text(
                    'Auto',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(9),
        child: GridView.count(
          crossAxisCount: MediaQuery.of(context).size.width ~/ 200, // Adjust the value based on screen width
          childAspectRatio: 1.0, // Aspect ratio of items
          children: List.generate(
            items.length,
            (index) => ItemTile(
              index: index,
              items: items,
              isTimerEnabled: isTimerEnabled,
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const AtoZ());
}
