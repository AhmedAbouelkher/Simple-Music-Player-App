import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';

class MoreOptionsPanel {
  buildPanelSwitch(BuildContext context) {
    if (isMaterial(context)) {
      _androidPopupContent(context);
      return;
    }

    showPlatformModalSheet(
      context: context,
      builder: (context) {
        return PlatformWidget(
          cupertino: (_, __) => _cupertinoSheetContent(context),
        );
      },
    );
  }

  Widget _cupertinoSheetContent(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(
        'Control Panel Users',
        style: Theme.of(context).textTheme.headline6,
      ),
      message: const Text(
          'Please select the panel users type from the options below.'),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: const Text(
            'Shuffle',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          onPressed: () {},
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'Agents',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          onPressed: () {},
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text('Cancel'),
        isDefaultAction: true,
        onPressed: () {},
      ),
    );
  }

  void _androidPopupContent(BuildContext context) {
    return PlatformActionSheet().displaySheet(
      context: context,
      title: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Control Panel Users',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
      message: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: const Text(
            'Please select the panel users type from the options below.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      actions: [
        ActionSheetAction(
          text: "Shuffle",
          onPressed: () {},
        ),
        ActionSheetAction(
          text: "Agents",
          onPressed: () {},
        ),
        ActionSheetAction(
          text: "Cancel",
          onPressed: () => Navigator.pop(context),
          isCancel: true,
          defaultAction: true,
        )
      ],
    );
  }
}
