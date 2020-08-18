# You can override some default options with config.fish:
#
#  set -g theme_short_path yes

function fish_prompt
  set -l last_command_status $status
  set -l cwd

  if test "$theme_short_path" = 'yes'
    set cwd (basename (prompt_pwd))
  else
    set cwd (prompt_pwd)
  end

  set -l ahead    "↑"
  set -l behind   "↓"
  set -l diverged "⥄ "
  set -l dirty    "⨯"
  set -l none     "◦"

  set -l normal_color     (set_color normal)
  set -l directory_color  (set_color $fish_color_quote 2> /dev/null; or set_color brown)
  set -l directory_color  (set_color purple)
  set -l repository_color (set_color $fish_color_cwd 2> /dev/null; or set_color green)
  set -l git_branch_name

  if git_is_repo
    if test "$theme_short_path" = 'yes'
      set root_folder (command git rev-parse --show-toplevel 2> /dev/null)
      set parent_root_folder (dirname $root_folder)
      set cwd (echo $PWD | sed -e "s|$parent_root_folder/||")
    end

    echo -n -s $repository_color (string sub -l 22 (git_branch_name)) $normal_color

    if git_is_touched
      echo -n -s $dirty
    else
      echo -n -s (git_ahead $ahead $behind $diverged $none)
    end

    echo -n -s " "
  end

  echo -n -s $directory_color $cwd " "

  echo -n -s "\$ "
end
