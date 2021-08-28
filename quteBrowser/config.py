import os

from qutebrowser.api import interceptor

user_name = os.getenv('username')

# test from wits

# Some useful shortcut
# Ctrl + d when a link in history is highlighted
# use m to add web page into quickMark
# ================== Youtube Add Blocking =======================
def filter_yt(info: interceptor.Request):
    """Block the given request if necessary."""
    url = info.request_url
    if (
        url.host() == "www.youtube.com"
        and url.path() == "/get_video_info"
        and "&adformat=" in url.query()
    ):
        info.block()

interceptor.register(filter_yt)
# ================================================================


# ==================  start page and search engine =======================

c.url.start_pages = ["https://news.google.com/topstories?hl=zh-TW&gl=TW&ceid=TW:zh-Hant"]
# c.url.searchengines["g"] = "https://www.google.com/search?q={}"
c.url.searchengines["DEFAULT"] = "https://www.google.com/search?q={}"
c.url.searchengines["j"] = "https://jira.imgdev.bioclinica.com/secure/QuickSearch.jspa?searchString={}"
c.url.searchengines["y"] = "https://www.youtube.com/results?search_query={}"

# ================================================================

c.tabs.position = "top"
# c.completion.open_categories = ['searchengines', 'quickmarks', 'bookmarks', 'history', 'filesystem']
c.completion.open_categories = ["quickmarks", "searchengines", "history", "filesystem"]

c.zoom.default = "135%"
config.unbind('gf') #unbind gf => view source, I always mistakenly hit this key and no idea how to go back
# config.bind('aa', 'set-cmd-text -s :quickmark-add {url} "{title}')
# config.bind('aa', 'set-cmd-text -s :quickmark-load')
# config.bind('ab', 'set-cmd-text :open {http//www.google.com}')

script1_path = f'C:\\Users\\{user_name}\\AppData\\Roaming\\qutebrowser\\config\\js\\standup.js'
script2_path = f'C:\\Users\\{user_name}\\AppData\\Roaming\\qutebrowser\\config\\js\\auto_fill_wits_health.js'
config.bind('x1', f'set-cmd-text -s :jseval --file {script1_path}')
config.bind('x2', f'set-cmd-text -s :jseval --file {script2_path}')

config.bind(',qenv', 'spawn -u -o "qb-env.cmd"')
config.bind(',t', 'spawn -u -o wsl.cmd')
config.bind(',j', 'spawn -u -o git_bash.cmd')

config.bind('<f12>', 'devtools')
config.bind('ww', 'config-source')
config.bind('<Shift-Tab>', 'tab-prev')
config.bind('<Tab>', 'tab-next')
config.bind('<alt-n>', 'set-cmd-text /')

# ====================== Special Format Yanking ===========
config.bind("<alt-c>", "yank inline [{title}]({url})")
#==========================================================

config.bind(';', 'set-cmd-text :')

config.bind('<Ctrl-o>', 'back')
config.bind('<Ctrl-i>', 'forward')

config.bind("<Ctrl-n>", "fake-key <Down>", "command")
config.bind("<Ctrl-p>", "fake-key <Up>", "command")
# config.bind("<Ctrl-u>", "fake-key <Shift-Home><Delete>", "insert")

c.bindings.commands['insert'] = {
    '<ctrl-e>': 'fake-key <End>',
    '<ctrl-a>': 'fake-key <Home>',
    '<ctrl-j>': 'fake-key <Down>',
    '<ctrl-k>': 'fake-key <Up>',
    '<ctrl-f>': 'fake-key <Right>',
    '<ctrl-b>': 'fake-key <Left>',
    '<ctrl-h>': 'fake-key <backspace>',
    '<ctrl-w>': 'fake-key <ctrl-backspace>',
    '<ctrl-u>': 'fake-key <Shift-Home><Delete>',

    # '<ctrl-space>': 'leave-mode',
    # '<ctrl-g>': 'leave-mode;;fake-key <Left>;;fake-key <Right>',
    # '<Return>': 'leave-mode',
    # '<ctrl-w>': 'fake-key <Ctrl-x>;;message-info "cut to clipboard";;leave-mode',
    # '<alt-w>': 'fake-key <Ctrl-c>;;message-info "copy to clipboard";;leave-mode',
    # '<backspace>': 'fake-key <backspace>;;leave-mode',
    # '<alt-x>': 'leave-mode;;set-cmd-text :',
    # '<alt-o>': 'leave-mode;;tab-focus last',
    # '<Tab>': 'fake-key <f1>'
}


 # ====================== font setting ====================================
font_size = 13
c.fonts.hints = f'{font_size + 2}pt Hack Nerd Font Mono'
c.fonts.statusbar = f'{font_size}pt Hack Nerd Font Mono'
c.fonts.downloads = f'{font_size}pt Hack Nerd Font Mono'
c.fonts.contextmenu = f'{font_size}pt Hack Nerd Font Mono'
c.fonts.tabs.selected = f'{font_size}pt Hack Nerd Font Mono'
c.fonts.tabs.unselected = f'{font_size}pt Hack Nerd Font Mono'
c.fonts.completion.entry = f'{font_size}pt Hack Nerd Font Mono'
c.fonts.completion.category = f'{font_size}pt Hack Nerd Font Mono'


 # ---------------------------------------------------------------------------






 # ---------------------------------------------------------------------------
 # ====================== default setting ====================================
 # ---------------------------------------------------------------------------


# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html
# :set

# Change the argument to True to still load settings configured via autoconfig.yml
config.load_autoconfig(False)

# Which cookies to accept. With QtWebEngine, this setting also controls
# other features with tracking capabilities similar to those of cookies;
# including IndexedDB, DOM storage, filesystem API, service workers, and
# AppCache. Note that with QtWebKit, only `all` and `never` are
# supported as per-domain values. Setting `no-3rdparty` or `no-
# unknown-3rdparty` per-domain on QtWebKit will have the same effect as
# `all`. If this setting is used with URL patterns, the pattern gets
# applied to the origin/first party URL of the page making the request,
# not the request URL. With QtWebEngine 5.15.0+, paths will be stripped
# from URLs, so URL patterns using paths will not match. With
# QtWebEngine 5.15.2+, subdomains are additionally stripped as well, so
# you will typically need to set this setting for `example.com` when the
# cookie is set on `somesubdomain.example.com` for it to work properly.
# To debug issues with this setting, start qutebrowser with `--debug
# --logfilter network --debug-flag log-cookies` which will show all
# cookies being set.
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')

# Which cookies to accept. With QtWebEngine, this setting also controls
# other features with tracking capabilities similar to those of cookies;
# including IndexedDB, DOM storage, filesystem API, service workers, and
# AppCache. Note that with QtWebKit, only `all` and `never` are
# supported as per-domain values. Setting `no-3rdparty` or `no-
# unknown-3rdparty` per-domain on QtWebKit will have the same effect as
# `all`. If this setting is used with URL patterns, the pattern gets
# applied to the origin/first party URL of the page making the request,
# not the request URL. With QtWebEngine 5.15.0+, paths will be stripped
# from URLs, so URL patterns using paths will not match. With
# QtWebEngine 5.15.2+, subdomains are additionally stripped as well, so
# you will typically need to set this setting for `example.com` when the
# cookie is set on `somesubdomain.example.com` for it to work properly.
# To debug issues with this setting, start qutebrowser with `--debug
# --logfilter network --debug-flag log-cookies` which will show all
# cookies being set.
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set('content.cookies.accept', 'all', 'devtools://*')

# Value to send in the `Accept-Language` header. Note that the value
# read from JavaScript is always the global value.
# Type: String
config.set('content.headers.accept_language', '', 'https://matchmaker.krunker.io/*')

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value. With QtWebEngine
# between 5.12 and 5.14 (inclusive), changing the value exposed to
# JavaScript requires a restart.
# Type: FormatString
config.set(
    'content.headers.user_agent',
    'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}',
    'https://web.whatsapp.com/')

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value. With QtWebEngine
# between 5.12 and 5.14 (inclusive), changing the value exposed to
# JavaScript requires a restart.
# Type: FormatString
config.set(
    'content.headers.user_agent',
    'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version} Edg/{upstream_browser_version}',
    'https://accounts.google.com/*')

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value. With QtWebEngine
# between 5.12 and 5.14 (inclusive), changing the value exposed to
# JavaScript requires a restart.
# Type: FormatString
config.set('content.headers.user_agent',
           'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36',
           'https://*.slack.com/*')

config.set('content.headers.user_agent', 'Mozilla/5.0 (X11; Linux x86_64; rv:57.0) Gecko/20100101 Firefox/77.0', 'https://accounts.google.com/*')
# Load images automatically in web pages.
# Type: Bool
config.set('content.images', True, 'chrome-devtools://*')

# Load images automatically in web pages.
# Type: Bool
config.set('content.images', True, 'devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome-devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')
