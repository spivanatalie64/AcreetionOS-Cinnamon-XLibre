#!/bin/bash

# Configuration
FLAG_FILE="$HOME/.config/acreetionos-welcome-done"

# Check if the popup has already been shown
if [ ! -f "$FLAG_FILE" ]; then
    # Ensure .config exists
    mkdir -p "$(dirname "$FLAG_FILE")"

    # Display the popup
    zenity --info --title="Welcome to Acreetion OS" --width=600 --text="<b>Welcome to Acreetion OS!</b>

<b>What is XLibre?</b>
XLibre is a modernized fork of the X.Org (X11) Server. It aims to maintain and improve the rock-solid X11 architecture that users have relied on for decades, but with cleaner code and better compatibility for modern hardware.

<b>XLibre vs X11</b>
While XLibre is fully compatible with X11 applications, it is more actively maintained and stripped of legacy 'cruft' that has accumulated in the original X.Org project.

<b>Cinnamon Integration & Updates</b>
We have custom-patched Cinnamon to integrate seamlessly with the XLibre backend. This is achieved through a <b>patching step during the build process</b> that overlays our custom binaries and scripts directly onto the base system. 

As a small team, maintaining the entirety of a desktop environment ourselves is not practical; using targeted patches allows us to revolutionize the experience and port to XLibre without the overhead of maintaining millions of lines of upstream code.

<b>Future Outlook</b>
While we are focused on perfecting the XLibre experience for this version, we have a new developer giving Wayland a try to see how it might fit into our future. We will see what comes of that exploration, but for now, XLibre remains our primary path.

<b>Updates Warning</b>
To maintain system stability, <b>DO NOT manually update Cinnamon packages.</b> Standard upstream updates may break the XLibre integration. We will be handling Cinnamon updates ourselves going forward. In a future update, we will transition to a custom-named package: <b>cinnamon-acreetionos</b>.

<b>Why not Wayland?</b>
We chose XLibre over Wayland because we believe in the stability, versatility, and proven performance of the X11 protocol. Many professional tools, complex multi-monitor setups, and accessibility features still work best on X11. XLibre gives us the best of both worlds: the reliability of X11 with a modern, community-driven codebase."

    # Create the flag file so it doesn't show again
    touch "$FLAG_FILE"
fi
