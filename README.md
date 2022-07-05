# hid_activity_macos

Track macOS HID activity

## Features

- stream HID events such as mouse activity or keyboard key press on macOS
- request & check accessibility permissions

## Prepare

Your app must not run in sandbox. Change in DebugProfile.entitlements and Release.entitlements:

```
<key>com.apple.security.app-sandbox</key>
	<false/>
```