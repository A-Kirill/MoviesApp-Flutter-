import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:movies_fltr/storage/theme_notifier.dart';
import 'package:movies_fltr/supporting/supporting_methods.dart';
import 'package:movies_fltr/ui/separator.dart';
import 'package:provider/provider.dart';

import '../storage/storage_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int languageControlValue = 0;
  int themeControlValue = 0;

  @override
  void initState() {
    getLanguageCode();
    getThemeMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: buildBackgroundDecoration(context),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    translate('settings.appearance'),
                    style: const TextStyle(color: Colors.blueGrey),
                  ),
                ),
                Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.white),
                    height: 200,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            translate('settings.language_title'),
                            style: const TextStyle(color: Colors.blueGrey),
                          ),
                          languageControl(),
                          const Separator(),
                          Text(
                            translate('settings.theme'),
                            style: const TextStyle(color: Colors.blueGrey),
                          ),
                          themeControl(),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget languageControl() {
    return SizedBox(
      width: double.infinity,
      child: CupertinoSlidingSegmentedControl(
          groupValue: languageControlValue,
          children: <int, Widget>{
            0: Text(translate('settings.language.en')),
            1: Text(translate('settings.language.ru')),
          },
          onValueChanged: (value) {
            setState(() {
              languageControlValue = value.hashCode;
              languageControlValue == 0
                  ? changeLocale(context, 'en')
                  : changeLocale(context, 'ru');
            });
            Phoenix.rebirth(context);
          }),
    );
  }

  Widget themeControl() {
    ThemeNotifier themeProvider = Provider.of<ThemeNotifier>(context, listen: false);
    return SizedBox(
      width: double.infinity,
      child: CupertinoSlidingSegmentedControl(
          groupValue: themeControlValue,
          children: <int, Widget>{
            0: Text(translate('settings.light')),
            1: Text(translate('settings.dark')),
          },
          onValueChanged: (value) {
            setState(() {
              themeControlValue = value.hashCode;
              themeControlValue == 0
                  ? themeProvider.setLightMode()
                  : themeProvider.setDarkMode();
            });
          }),
    );
  }

  Future getLanguageCode() async {
    var pref = StorageManager();
    await pref.getPreferredLocale().then((value) => {
          if (value.languageCode == 'ru') {
              setState(() {
                languageControlValue = 1;
              })
            } else {
              setState(() {
                languageControlValue = 0;
              })
            }
        });
  }

  Future getThemeMode() async {
    var pref = StorageManager();
    await pref.getThemeIsDark().then((value) => {
      if (value == true) {
        setState(() {
          themeControlValue = 1;
        })
      } else {
        setState(() {
          themeControlValue = 0;
        })
      }
    });
  }
}
