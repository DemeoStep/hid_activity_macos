# hid_activity_macos

Detect macOS HID activity

## Features

- stream HID events such as mouse activity or keyboard key press on macOS
- request & check accessibility permissions

## Prepare

Your app must not run in sandbox. Change in DebugProfile.entitlements and Release.entitlements:

```
<key>com.apple.security.app-sandbox</key>
	<false/>
```

## Usage

Import this package, create instance and call getActivityStream() to get event stream

```
class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final _hidActivityMacos = HidActivityMacos();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<String> (
          stream: _hidActivityMacos.getActivityStream,
          builder: (context, AsyncSnapshot<String> snapshot) {
            if(snapshot.hasData) {
              return Text(snapshot.data!);
            } else {
              return const Text('Waiting for HID event');
            }
          },
        ),
      ),
    );
  }
}
```