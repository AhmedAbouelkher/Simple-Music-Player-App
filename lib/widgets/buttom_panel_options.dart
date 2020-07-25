import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';
import 'package:provider/provider.dart';
import 'package:simple_music_player/Controllers/songs_control_panel.dart';

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
    final sondProvider = Provider.of<SongsControlPanel>(context, listen: false);
    return CupertinoActionSheet(
      title: Text(
        'More options',
        style: TextStyle(
          fontSize: 14,
        ),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: const Text(
            'Shuffle',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            sondProvider.playPlaylist(shuffle: true);
            Navigator.pop(context);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'Share',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text('Cancel'),
        isDefaultAction: true,
        onPressed: () => Navigator.pop(context),
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
            'More options',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ),
      actions: [
        ActionSheetAction(
          text: "Shuffle",
          onPressed: () {},
        ),
        ActionSheetAction(
          text: "Share",
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
