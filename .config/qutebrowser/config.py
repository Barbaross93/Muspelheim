#!/usr/bin/env python3
import alduin.draw

# Load existing settings made via :set
config.load_autoconfig()

# everforest.draw.konda(c, {"spacing": {"vertical": 5, "horizontal": 8}})
alduin.draw.konda(c)

c.fonts.hints = "10pt monospace"
c.fonts.keyhint = "10pt monospace"
c.fonts.prompts = "10pt monospace"
c.fonts.downloads = "10pt monospace"
c.fonts.statusbar = "10pt monospace"
c.fonts.contextmenu = "10pt monospace"
c.fonts.messages.info = "10pt monospace"
c.fonts.debug_console = "10pt monospace"
c.fonts.completion.entry = "10pt monospace"
c.fonts.completion.category = "10pt monospace"
c.url.start_pages = "~/.config/qutebrowser/startpage/index.html"
c.url.default_page = "~/.config/qutebrowser/startpage/index.html"
c.editor.command = ["/usr/bin/st", "-e", "/usr/bin/vim {}"]

c.colors.webpage.darkmode.enabled = False

# config.set("colors.webpage.darkmode.enabled", False)
# Toggle darkmode css
config.bind(
    ",t",
    'config-cycle content.user_stylesheets ~/.config/qutebrowser/alduin/alduin-all-sites.css ""',
)

# Qute-pass keubindings
config.bind(
    ",pp",
    "spawn --userscript qute-pass -d ddmenu",
)

config.bind(
    ",pu",
    "spawn --userscript qute-pass --username-only -d ddmenu",
)

config.bind(
    ",m",
    "spawn mpv {url}",
)

config.bind(
    ",M",
    "hint links spawn mpv {hint-url}",
)

config.bind(
    ",pP",
    "spawn --userscript qute-pass --password-only -d ddmenu",
)

# Open download
config.bind(
    ",d",
    "spawn --userscript open_download",
)

# Cycle inputs
config.bind(
    "gi",
    "jseval -q -f ~/.config/qutebrowser/cycle-inputs.js",
)
