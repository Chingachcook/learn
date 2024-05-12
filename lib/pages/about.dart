import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Біз туралы',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Балаларға арналған оқу қолданбасы',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Версиясы: 1.1.0',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Жасаған: Батырбаев Шыңғыс',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Сипаттама:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              AppConstants.description,
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 6.0),
            // const Text(
            //   'Source code:',
            //   style: TextStyle(
            //     fontSize: 20.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // GestureDetector(
            //   onTap: () {
            //     _launchURL(context, "https://github.com/VaibhavCodeClub/learn");
            //   },
            //   child: SvgPicture.asset(
            //     'assets/images/git.svg',
            //     width: 32.0,
            //     height: 32.0,
            //     color: Theme.of(context).brightness == Brightness.dark
            //         ? Colors.white
            //         : Colors.black,
            //   ),
            // ),
            const SizedBox(height: 16.0),
            const Text(
              'Кері байланыс:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _launchURL(context, "https://github.com/chingachcook");
                  },
                  child: SvgPicture.asset(
                    'assets/images/github.svg',
                    width: 32.0,
                    height: 32.0,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                const SizedBox(width: 16.0),
                GestureDetector(
                  onTap: () {
                    _launchURL(context, "mailto:batirbaevchingiz@gmail.com");
                  },
                  child: SvgPicture.asset(
                    'assets/images/email.svg',
                    width: 32.0,
                    height: 32.0,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black ,
                  ),
                ),
                const SizedBox(width: 16.0),
                GestureDetector(
                  onTap: () {
                    _launchURL(
                        context, "https://www.linkedin.com/in/chingiz-batirbaev/");
                  },
                  child: SvgPicture.asset(
                    'assets/images/linkedin.svg',
                    width: 32.0,
                    height: 32.0,
                  ),
                ),
                const SizedBox(width: 16.0),
                GestureDetector(
                  onTap: () {
                    _launchURL(context, "https://www.instagram.com/cbec.be/");
                  },
                  child: SvgPicture.asset(
                    'assets/images/instagram.svg',
                    width: 32.0,
                    height: 32.0,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(BuildContext context, String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      throw '$url іске қосылмады';
    }
  }
}
