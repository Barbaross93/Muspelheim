#!/usr/bin/env python3


# def konda(c, options={}):
def konda(c):
    palette = {
        "background": "#1c1c1c",
        "background-alt": "#262626",
        "background-attention": "#262626",
        "border": "#af875f",
        "current-line": "#424242",
        "selection": "#af875f",
        "foreground": "#dfdfaf",
        "foreground-alt": "#626262",
        "foreground-attention": "#af5f5f",
        "comment": "#878787",
        "cyan": "#57875f",
        "green": "#87875f",
        "orange": "#dfaf87",
        "blue": "#87afaf",
        "purple": "#af8787",
        "red": "#af5f5f",
        "yellow": "#af875f",
    }

    # spacing = options.get("spacing", {"vertical": 20, "horizontal": 12})

    # padding = options.get(
    #    "padding",
    #    {
    #        "top": spacing["vertical"],
    #        "right": spacing["horizontal"],
    #        "bottom": spacing["vertical"],
    #        "left": spacing["horizontal"],
    #    },
    # )
    c.colors.webpage.bg = palette["background"]

    c.colors.completion.category.bg = palette["background"]

    c.colors.completion.category.border.bottom = palette["border"]

    c.colors.completion.category.border.top = palette["border"]

    c.colors.completion.category.fg = palette["foreground"]

    c.colors.completion.even.bg = palette["background"]

    c.colors.completion.odd.bg = palette["background-alt"]

    c.colors.completion.fg = palette["foreground"]

    c.colors.completion.item.selected.bg = palette["selection"]

    c.colors.completion.item.selected.border.bottom = palette["selection"]

    c.colors.completion.item.selected.border.top = palette["selection"]

    c.colors.completion.item.selected.fg = palette["foreground"]

    c.colors.completion.match.fg = palette["orange"]

    c.colors.completion.scrollbar.bg = palette["background"]

    c.colors.completion.scrollbar.fg = palette["foreground"]

    c.colors.downloads.bar.bg = palette["background"]

    c.colors.downloads.error.bg = palette["background"]

    c.colors.downloads.error.fg = palette["red"]

    c.colors.downloads.stop.bg = palette["background"]

    c.colors.downloads.start.fg = palette["foreground"]

    c.colors.downloads.stop.fg = palette["green"]

    c.colors.downloads.system.bg = "none"

    c.colors.hints.bg = palette["background"]

    c.colors.hints.fg = palette["purple"]

    c.hints.border = "1px solid " + palette["background-alt"]

    c.colors.hints.match.fg = palette["foreground-alt"]

    c.colors.keyhint.bg = palette["background"]

    c.colors.keyhint.fg = palette["purple"]

    c.colors.keyhint.suffix.fg = palette["selection"]

    c.colors.messages.error.bg = palette["background"]

    c.colors.messages.error.border = palette["background-alt"]

    c.colors.messages.error.fg = palette["red"]

    c.colors.messages.info.bg = palette["background"]

    c.colors.messages.info.border = palette["background-alt"]

    c.colors.messages.info.fg = palette["comment"]

    c.colors.messages.warning.bg = palette["background"]

    c.colors.messages.warning.border = palette["background-alt"]

    c.colors.messages.warning.fg = palette["red"]

    c.colors.prompts.bg = palette["background"]

    c.colors.prompts.border = "1px solid " + palette["background-alt"]

    c.colors.prompts.fg = palette["cyan"]

    c.colors.prompts.selected.bg = palette["selection"]

    c.colors.statusbar.caret.bg = palette["background"]

    c.colors.statusbar.caret.fg = palette["orange"]

    c.colors.statusbar.caret.selection.bg = palette["background"]

    c.colors.statusbar.caret.selection.fg = palette["orange"]

    c.colors.statusbar.command.bg = palette["background"]

    c.colors.statusbar.command.fg = palette["blue"]

    c.colors.statusbar.command.private.bg = palette["background"]

    c.colors.statusbar.command.private.fg = palette["foreground-alt"]

    c.colors.statusbar.insert.bg = palette["background-attention"]

    c.colors.statusbar.insert.fg = palette["foreground-attention"]

    c.colors.statusbar.normal.bg = palette["background"]

    c.colors.statusbar.normal.fg = palette["foreground"]

    c.colors.statusbar.passthrough.bg = palette["background"]

    c.colors.statusbar.passthrough.fg = palette["orange"]

    c.colors.statusbar.private.bg = palette["background-alt"]

    c.colors.statusbar.private.fg = palette["foreground-alt"]

    c.colors.statusbar.progress.bg = palette["background"]

    c.colors.statusbar.url.error.fg = palette["red"]

    c.colors.statusbar.url.fg = palette["foreground"]

    c.colors.statusbar.url.hover.fg = palette["cyan"]

    c.colors.statusbar.url.success.http.fg = palette["green"]

    c.colors.statusbar.url.success.https.fg = palette["green"]

    c.colors.statusbar.url.warn.fg = palette["yellow"]

    # c.statusbar.padding = padding

    c.colors.tabs.bar.bg = palette["current-line"]

    c.colors.tabs.even.bg = palette["current-line"]

    c.colors.tabs.even.fg = palette["foreground"]

    c.colors.tabs.indicator.error = palette["red"]

    c.colors.tabs.indicator.start = palette["orange"]

    c.colors.tabs.indicator.stop = palette["green"]

    c.colors.tabs.indicator.system = "none"

    c.colors.tabs.odd.bg = palette["current-line"]

    c.colors.tabs.odd.fg = palette["foreground"]

    c.colors.tabs.selected.even.bg = palette["background"]

    c.colors.tabs.selected.even.fg = palette["foreground"]

    c.colors.tabs.selected.odd.bg = palette["background"]

    c.colors.tabs.selected.odd.fg = palette["foreground"]

    c.colors.tabs.pinned.even.bg = palette["current-line"]

    c.colors.tabs.pinned.even.fg = palette["foreground"]

    c.colors.tabs.pinned.odd.bg = palette["current-line"]

    c.colors.tabs.pinned.odd.fg = palette["foreground"]

    c.colors.tabs.pinned.selected.even.bg = palette["background"]

    c.colors.tabs.pinned.selected.even.fg = palette["foreground"]

    c.colors.tabs.pinned.selected.odd.bg = palette["background"]

    c.colors.tabs.pinned.selected.odd.fg = palette["foreground"]

    # c.tabs.padding = padding
    # c.tabs.indicator.width = 1
    # c.tabs.favicons.scale = 1
