import 'dart:io';

import 'package:biyi_advanced_features/biyi_advanced_features.dart';
import 'package:biyi_app/generated/locale_keys.g.dart';
import 'package:biyi_app/includes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, this.onDismiss});

  final VoidCallback? onDismiss;

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Configuration get _configuration => localDb.configuration;

  // bool _launchAtStartupIsEnabled = false;

  @override
  void initState() {
    localDb.privateEngines.addListener(_handleChanged);
    localDb.privateOcrEngines.addListener(_handleChanged);
    super.initState();
    _init();
  }

  @override
  void dispose() {
    localDb.privateEngines.removeListener(_handleChanged);
    localDb.privateOcrEngines.removeListener(_handleChanged);
    super.dispose();
  }

  void _handleChanged() {
    if (mounted) setState(() {});
  }

  Future<void> _init() async {
    // if (kIsMacOS || kIsWindows) {
    //   _launchAtStartupIsEnabled = await launchAtStartup.isEnabled();
    // }
    setState(() {});
  }

  Widget _buildBody(BuildContext context) {
    return PreferenceList(
      children: [
        PreferenceListSection(
          title: Text(t('pref_section_title_input_settings')),
          children: [
            PreferenceListRadioItem<String>(
              value: kInputSettingSubmitWithEnter,
              groupValue: _configuration.inputSetting,
              title: Text(t('pref_item_title_submit_with_enter')),
              onChanged: (newValue) {
                _configuration.inputSetting = newValue;
              },
            ),
            PreferenceListRadioItem<String>(
              value: kInputSettingSubmitWithMetaEnter,
              groupValue: _configuration.inputSetting,
              title: Text(
                t(
                  kIsMacOS
                      ? 'pref_item_title_submit_with_meta_enter_mac'
                      : 'pref_item_title_submit_with_meta_enter',
                ),
              ),
              onChanged: (newValue) {
                _configuration.inputSetting = newValue;
              },
            ),
          ],
        ),
        // PreferenceListSection(
        //   title: Text(t('pref_section_title_advanced')),
        //   children: [
        //     PreferenceListSwitchItem(
        //       value: _launchAtStartupIsEnabled,
        //       title: Text(t('pref_item_title_launch_at_startup')),
        //       onChanged: (newValue) async {
        //         if (newValue) {
        //           LaunchAtStartup.instance.enable();
        //         } else {
        //           LaunchAtStartup.instance.disable();
        //         }
        //         _launchAtStartupIsEnabled = await launchAtStartup.isEnabled();
        //         setState(() {});
        //       },
        //     ),
        //   ],
        // ),
        PreferenceListSection(
          title: Text(t('pref_section_title_others')),
          children: [
            PreferenceListItem(
              title: Text(t('pref_item_title_about')),
              onTap: () async {
                Uri url = Uri.parse('https://github.com/biyidev/biyi');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              },
            ),
          ],
        ),
        PreferenceListSection(
          children: [
            PreferenceListItem(
              title: Container(
                margin: EdgeInsets.zero,
                width: double.infinity,
                child: Text(
                  t('pref_item_title_exit_app'),
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
              accessoryView: Container(),
              onTap: () async {
                return showDialog<void>(
                  context: context,
                  builder: (BuildContext ctx) {
                    return CustomAlertDialog(
                      title: Text(t('exit_app_dialog.title')),
                      actions: <Widget>[
                        CustomDialogAction(
                          child: Text(LocaleKeys.cancel.tr()),
                          onPressed: () async {
                            Navigator.of(ctx).pop();
                          },
                        ),
                        CustomDialogAction(
                          child: Text(LocaleKeys.ok.tr()),
                          onPressed: () async {
                            await trayManager.destroy();
                            exit(0);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 20,
              ),
              child: Text(
                t(
                  'text_version',
                  args: [
                    sharedEnv.appVersion,
                    '${sharedEnv.appBuildNumber}',
                  ],
                ),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(t('title')),
        leading: widget.onDismiss != null
            ? CustomAppBarCloseButton(
                onPressed: widget.onDismiss,
              )
            : null,
      ),
      body: _buildBody(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }

  String t(String key, {List<String> args = const []}) {
    return 'page_settings.$key'.tr(args: args);
  }
}
