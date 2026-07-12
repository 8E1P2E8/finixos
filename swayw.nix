{ pkgs, ... }:

let

multicsImage =
    pkgs.runCommand "Multics-Wallpaper.png"
      {
        nativeBuildInputs = [
          pkgs.imagemagick
          pkgs.freefont_ttf
        ];
      }
      ''
        magick -size 1920x1080 xc:black \
          -fill none -stroke red -strokewidth 3 \
          -font "${pkgs.freefont_ttf}/share/fonts/truetype/FreeSerif.ttf" \
          -gravity center -pointsize 800 -draw "text 0,0 'Ω'" \
          -draw "translate 960,540 scale 2,2 path 'M 0,25.5 L -15.0,-20.6 L 24.3,7.9 L -24.3,7.9 L 15.0,-20.6 Z'" \
          -draw "translate 960,540 circle 0,0 20,0 line -6,0 6,0" \
          -pointsize 1 -draw "text 0,0 'Ἐδραείν'" \
          $out
      '';


# 2. Inject the immutable Nix store path directly into the Sway config string
  swayConfig = pkgs.writeText "sway-config" ''
        # Border settings
        default_border none
        default_floating_border none
        smart_borders on
        smart_gaps on

        # Multics theme — Sway config
    	set $MulticsBackground      000000
    	set $MulticsForeground      ff0000
    	set $MulticsTitleText       bf0000
    	set $MulticsInactiveBorder  800000
    	set $MulticsHighlight       9f0000
    	set $MulticsDisabledText    750000
    	set $MulticsInactiveTitle   880000
    	set $MulticsRedHighlight    c00000
    	set $MulticsRedHover        ff0046
    	set $mod Mod4
    	
    	# Explicitly define foot terminal to ensure it's not empty
    	set $term foot -D $HOME
    	set $menu "wmenu-run -n '#ff0000' -N '#000000' -s '#000000' -S '#ff0000'"

    	output * bg ${multicsImage} fit

    	# Window rules
    	for_window [app_id="foot"] border none
    	for_window [app_id="wlvncc"] fullscreen enable
    	for_window [app_id="wlvncc"] floating disable
    	for_window [app_id="wlvncc"] inhibit_idle focus

    	# Bar (I think)
    	bar {
    	position top
    	status_command  while date +'⛧ %H:%M:%S ⛧ %d-%m-%Y ⛧'; do sleep 1; done
    	colors {
    	background			$MulticsBackground
    	statusline			$MulticsForeground
    	separator			$MulticsForeground
    	focused_workspace		$MulticsForeground	$MulticsBackground	$MulticsForeground
    	inactive_workspace		$MulticsInactiveBorder	$MulticsBackground	$MulticsInactiveBorder
    	urgent_workspace		$MulticsForeground	$MulticsBackground	$MulticsForeground
    	}

    	# Font		
    	font	pango:Monospace 10
    	workspace_buttons	yes
    	binding_mode_indicator	yes
    	}
    	client.focused			$MulticsForeground	$MulticsBackground	$MulticsForeground	$MulticsForeground
    	client.focused_inactive		$MulticsInactiveBorder	$MulticsBackground	$MulticsForeground	$MulticsBackground
    	client.unfocused		$MulticsInactiveBorder	$MulticsBackground	$MulticsForeground	$MulticsBackground
    	client.urgent			$MulticsHighlight	$MulticsBackground	$MulticsForeground	$MulticsHighlight

    	# Keybindings and other configuration
    	bindsym $mod+f			fullscreen
    	bindsym $mod+e			layout		toggle split
    	bindsym $mod+s			layout		stacking
    	bindsym $mod+w			layout		tabbed
    	bindsym $mod+b			splith
    	bindsym $mod+v			splitv
    	bindsym $mod+x					scratchpad show
    	bindsym $mod+Shift+x 		move 		scratchpad
    	bindsym $mod+space		focus mode_	toggle
    	bindsym $mod+Shift+space	floating 	toggle
    	bindsym $mod+Tab		workspace next
    	bindsym $mod+Shift+Tab		workspace prev
    	bindsym $mod+a 			focus 		parent

    	# Keybindings sway default
    	bindsym $mod+Shift+e		exec swaynag -t warning -m 'Exit sway?' -B 'Yes, exit sway' 'swaymsg exit'
    	bindsym $mod+Return		exec $term
    	bindsym $mod+d			exec $menu
    	bindsym $mod+Shift+q		kill
    	bindsym $mod+Shift+c		reload

    	# Switch to specific workspaces
    	bindsym $mod+1 workspace 1
    	bindsym $mod+2 workspace 2
    	bindsym $mod+3 workspace 3
    	bindsym $mod+4 workspace 4
    	bindsym $mod+5 workspace 5
    	bindsym $mod+6 workspace 6
    	bindsym $mod+7 workspace 7
    	bindsym $mod+8 workspace 8
    	bindsym $mod+9 workspace 9
    	bindsym $mod+0 workspace 10

    	# Move focused container to specific workspace
    	bindsym $mod+Shift+1 move container to workspace 1
    	bindsym $mod+Shift+2 move container to workspace 2
    	bindsym $mod+Shift+3 move container to workspace 3
    	bindsym $mod+Shift+4 move container to workspace 4
    	bindsym $mod+Shift+5 move container to workspace 5
    	bindsym $mod+Shift+6 move container to workspace 6
    	bindsym $mod+Shift+7 move container to workspace 7
    	bindsym $mod+Shift+8 move container to workspace 8
    	bindsym $mod+Shift+9 move container to workspace 9
    	bindsym $mod+Shift+0 move container to workspace 10

    	# Movement bindings
    	bindsym $mod+Left		focus left
    	bindsym $mod+Down		focus down
    	bindsym $mod+Up			focus up
    	bindsym $mod+Right		focus right
    	bindsym $mod+Shift+Left		move left
    	bindsym $mod+Shift+Down		move down
    	bindsym $mod+Shift+Up		move up
    	bindsym $mod+Shift+Right	move right

    	# Volume controls
    	bindsym $mod+F1 	exec pactl set-sink-volume @DEFAULT_SINK@ -5%
    	bindsym $mod+F2 	exec pactl set-sink-volume @DEFAULT_SINK@ +5%
    	bindsym $mod+F5 	exec pactl set-sink-mute @DEFAULT_SINK@ toggle
    	bindsym $mod+F6 	exec pactl set-source-mute @DEFAULT_SOURCE@ toggle

    	# Media controls (Native D-Bus via busctl)
    	set $mpris_cmd busctl --user call $(busctl --user list | grep -m1 org.mpris.MediaPlayer2 | awk '{print $1}') /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player
    	bindsym $mod+grave	exec $mpris_cmd PlayPause
    	bindsym $mod+F3		exec $mpris_cmd Previous
    	bindsym $mod+F4		exec $mpris_cmd Next

    	# Resize mode
    	bindsym $mod+r		mode "resize"
    	mode "resize" {
    	bindsym Left  resize shrink width 10px
       	bindsym Down  resize grow   height 10px
    	bindsym Up    resize shrink height 10px
    	bindsym Right resize grow   width 10px
    	bindsym Return mode "default"
    	bindsym Escape mode "default"
    	}

    	# Print Keybind Folders
    	exec_always bash -c		'mkdir -p ~/Pictures/Screenshots'
    	exec_always bash -c		'mkdir -p ~/Documents/Recordings'
    	# Fullscreen screenshot copy
    	bindsym Print			exec bash -c 'grim - | wl-copy'
    	# Area selection: copy + save with timestamp
    	bindsym $mod+Shift+Print	exec bash -c 'AREA=$(slurp); FILE=~/Pictures/Screenshots/screenshot-$(date +%F-%T).png; grim -g "$AREA" "$FILE"; wl-copy < "$FILE"'
    	# Fullscreen screenshot save
    	bindsym $mod+Print		exec bash -c 'FILE=~/Pictures/Screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png; grim "$FILE"; wl-copy < "$FILE"'
    	# Recording toggle (start/stop) - VP9 codec (BSD license)
    	bindsym $mod+Alt+Shift+r	exec bash -c 'if pgrep -x wf-recorder > /dev/null; then pkill -x wf-recorder && notify-send "Recording" "Stopped"; else AREA=$(slurp); FILE=~/Documents/Recordings/recording-$(date +%F-%H-%M-%S).webm; wf-recorder -g "$AREA" -c libvpx-vp9 -p deadline=realtime -f "$FILE" & notify-send "Recording" "Started"; fi'

    	# OCR keybindings - Regular text OCR with tesseract
    	bindsym $mod+Shift+t		exec bash -c 'AREA=$(slurp); grim -g "$AREA" - | tesseract - stdout | wl-copy'
    	bindsym $mod+Alt+t		exec bash -c 'grim - | tesseract - stdout | wl-copy'

    	# Bar and lock keybindings
    	bindsym $mod+Backspace		exec swaymsg bar mode toggle
    	bindsym $mod+L			exec swaylock

    	# VNC switcher
    	bindsym $mod+c exec wayvnc-switcher

    	# Auto-start applications on Sway launch
    	exec $term
    	exec swaybg -i ${multicsImage} -m fill
    	exec_always bash -c 'sleep 2 && echo "Sway session ready with terminal and wallpaper" > /tmp/sway-status.log'
  '';
in
{
  programs.sway = {
    enable = true;
    package = pkgs.sway;
  };

  environment.etc."sway/config".source = swayConfig;
}

