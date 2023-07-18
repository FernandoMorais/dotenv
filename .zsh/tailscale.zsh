# Starting Tailscale daemon automatically if not running...
RUNNING=`ps aux | grep tailscaled | grep -v grep`
if [ -z "$RUNNING" ]; then
    sudo tailscaled > /dev/null 2>&1 &
    disown
fi

