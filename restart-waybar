#!/bin/bash

# Kill all instances of waybar
killall waybar 2>/dev/null

# Wait a moment to ensure all processes are terminated
sleep 0.5

# Check if any waybar processes are still running
if pgrep -x "waybar" > /dev/null; then
    # If processes remain, force kill them
    killall -9 waybar
    sleep 0.5
fi

# Start waybar in the background
waybar &

echo "Waybar has been restarted."
