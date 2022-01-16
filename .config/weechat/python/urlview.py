# This weechat plugin pipes the current weechat buffer through urlview
#
# Usage:
# /urlview
#
# History:
# 10-04-2015: Version 1.0.0: initial release
# 12-21-2015: Version 1.0.1: reverse text passed to urlview
# 12-22-2015: Version 1.0.2: remove weechat color from messages
# 10-23-2016: Version 1.0.3: allows setting urlscan or urlview to handle urls
# 02-14-2020: Version 1.0.4: fixes buffer issues when using urlscan


import distutils.spawn
import os
import pipes
import weechat


def urlview(data, buf, args):
    infolist = weechat.infolist_get("buffer_lines", buf, "")
    lines = []
    while weechat.infolist_next(infolist) == 1:
        lines.append(
            weechat.string_remove_color(
                weechat.infolist_string(infolist, "message"),
                ""
            )
        )

    weechat.infolist_free(infolist)

    if not lines:
        weechat.prnt(buf, "No URLs found")
        return weechat.WEECHAT_RC_OK

    if not weechat.config_is_set_plugin("command"):
        weechat.config_set_plugin("command", "urlview")
    command = weechat.config_get_plugin("command")

    if distutils.spawn.find_executable(command) is None:
        weechat.prnt(buf, "%s is not installed" % command)
        return weechat.WEECHAT_RC_ERROR

    if command == 'urlscan':
        # urlscan doesn't parse the first line of text that is piped to it; to
        # ensure that we don't miss a url we pad with a newline.
        lines.insert(0, '\n')
        text = "\n".join(lines)
    else:
        # Reverse lines when using urlview; w/o the context that urlscan
        # provides, it's easier to find the correct url if the most recent one
        # in chat is the one that's at the top of the list.
        text = "\n".join(reversed(lines))

    response = os.system("echo %s | %s" % (pipes.quote(text), command))
    if response != 0:
        weechat.prnt(buf, "No URLs found")

    weechat.command(buf, "/window refresh")

    return weechat.WEECHAT_RC_OK


def main():
    if not weechat.register("urlview", "Keith Smiley", "1.0.2", "MIT",
                            "Use urlview or urlscan on the current buffer",
                            "", ""):
        return weechat.WEECHAT_RC_ERROR

    weechat.hook_command("urlview",
                         "Pass the current buffer to urlview or urlscan", "",
                         "", "", "urlview", "")


if __name__ == "__main__":
    main()
