#!/bin/bash

# Go to workspace 1
i3-msg 'workspace 1'
sleep 0.3

# Open first terminal
i3-msg 'exec ghostty'
sleep 1.5

# Split horizontally and open second terminal (this will be on the right)
i3-msg 'split h'
sleep 0.3
i3-msg 'exec ghostty'
sleep 1.5

# Focus RIGHT terminal, split vertically, open third terminal
i3-msg 'focus right'
sleep 0.3
i3-msg 'split v'
sleep 0.3
i3-msg 'exec ghostty'

