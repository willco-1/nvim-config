#!/usr/bin/env bash

set_bspwm_config() {
		bspc config border_width 0
		bspc config top_padding 57
		bspc config bottom_padding 2
		bspc config normal_border_color "#9893a5"
		bspc config active_border_color "#56949f"
		bspc config focused_border_color "#286983"
		bspc config presel_feedback_color "#b4637a"
		bspc config left_padding 2
		bspc config right_padding 2
		bspc config window_gap 6
}

set_term_config() {
		cat > "$HOME"/.config/alacritty/colors.toml <<- _EOF_
[colors.primary]
background = "#0d0d0d"
foreground = "#ebdbb2"

[colors.cursor]
cursor = "#56949f"
text   = "#faf4ed"

[colors.normal]
black   = "#575279"
red     = "#c4365a"
green   = "#1a7a4a"
yellow  = "#d97b00"
blue    = "#1d7ea8"
magenta = "#7c4fa8"
cyan    = "#c0627a"
white   = "#6e6a86"

[colors.bright]
black   = "#6e6a86"
red     = "#e05275"
green   = "#2aad6b"
yellow  = "#f0a030"
blue    = "#3aa0cc"
magenta = "#9e6fd0"
cyan    = "#e07090"
white   = "#575279"
_EOF_
}

set_picom_config() {
		sed -i "$HOME"/.config/bspwm/picom.conf \
			-e "s/normal = .*/normal =  { fade = true; shadow = true; }/g" \
			-e "s/shadow-color = .*/shadow-color = \"#000000\"/g" \
			-e "s/corner-radius = .*/corner-radius = 6/g" \
			-e "s/\".*:class_g = 'Alacritty'\"/\"100:class_g = 'Alacritty'\"/g" \
			-e "s/\".*:class_g = 'FloaTerm'\"/\"95:class_g = 'FloaTerm'\"/g"
}

set_dunst_config() {
		sed -i "$HOME"/.config/bspwm/dunstrc \
		-e "s/transparency = .*/transparency = 0/g" \
		-e "s/frame_color = .*/frame_color = \"#56949f\"/g" \
		-e "s/separator_color = .*/separator_color = \"#b4637a\"/g" \
		-e "s/font = .*/font = JetBrainsMono Nerd Font Medium 10/g" \
		-e "s/foreground='.*'/foreground='#56949f'/g"

		sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
		cat >> "$HOME"/.config/bspwm/dunstrc <<- _EOF_
				[urgency_low]
				timeout = 3
				background = "#faf4ed"
				foreground = "#575279"

				[urgency_normal]
				timeout = 6
				background = "#faf4ed"
				foreground = "#575279"

				[urgency_critical]
				timeout = 0
				background = "#b4637a"
				foreground = "#faf4ed"
_EOF_
}

launch_bars() {
		polybar -q will-bar -c ${rice_dir}/config.ini &
}

set_bspwm_config
set_term_config
set_picom_config
set_dunst_config
launch_bars
