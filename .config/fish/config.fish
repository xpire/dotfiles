if status is-interactive
    # Commands to run in interactive sessions can go here
    set -x DISPLAY "$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0"
end
