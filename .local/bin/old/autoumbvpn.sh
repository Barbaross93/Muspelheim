#!/usr/bin/expect -f

log_user 0

set pass [exec pass sshthanos]

spawn nmcli -a con up UMB
expect "Enter 'yes' to accept, 'no' to abort; anything else to view:"
send "yes\r"
expect "GROUP:"
send "SOM-MultiFactor\r"
expect "Username:"
send "cullen.ross\r"
expect "Password:"
send "$pass\r"
expect "Password:"
send "push\r"
expect " ~ ■"
