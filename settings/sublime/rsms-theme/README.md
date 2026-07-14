# rsms Sublime Text theme

Bright-only, pruned copy of [rsms/sublime-theme](https://github.com/rsms/sublime-theme).

The UI theme uses [Inter](https://rsms.me/inter/) and
[JetBrains Mono](https://www.jetbrains.com/lp/mono/).

## Recommended settings

In your `Packages/User/Preferences.sublime-settings`:

```js
"font_face": "JetBrains Mono",
"font_size": 14.0,
"font_options": [ "no_calt" ],
"line_padding_bottom": 1,
"line_padding_top": 0,
"highlight_line": false,
"show_tab_close_buttons": false,
"fold_buttons": false,
```

When in fullscreen, the square tab styles works much better than the default rounded ones:

```js
"file_tab_style": "square",
```
