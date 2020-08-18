# colors
set -U fish_color_normal normal
set -U fish_color_command ffcc66
set -U fish_color_quote 99cc99
set -U fish_color_redirection d3d0c8
set -U fish_color_end cc99cc
set -U fish_color_error f2777a
set -U fish_color_param d3d0c8
set -U fish_color_selection white --bold --background=brblack
set -U fish_color_search_match bryellow --background=brblack
set -U fish_color_history_current --bold
set -U fish_color_operator 6699cc
set -U fish_color_escape 66cccc
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_valid_path --underline
set -U fish_color_autosuggestion 747369
set -U fish_color_user brgreen
set -U fish_color_host normal
set -U fish_color_cancel -r
set -U fish_pager_color_completion normal
set -U fish_pager_color_description B3A06D yellow
set -U fish_pager_color_prefix white --bold --underline
set -U fish_pager_color_progress brwhite --background=cyan
set -U fish_color_comment 6699cc
set -U fish_color_match 6699cc
set -g theme_display_date no

# vi bindings
fish_vi_key_bindings
set -Ux EDITOR vim

set PATH /snap/bin /home/mk/.local/bin $PATH

clear

function fish_right_prompt
   #intentionally left blank
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/mk/apps/google-cloud-sdk/path.fish.inc' ]; . '/home/mk/apps/google-cloud-sdk/path.fish.inc'; end
