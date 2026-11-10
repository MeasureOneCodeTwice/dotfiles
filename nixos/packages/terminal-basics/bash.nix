{config, pkgs, ...}:
{
    # Get bash to send OSC 7 signal on directory change
    # to update tmux status line.
    programs.bash.interactiveShellInit = ''
    __update_terminal_cwd() {
      printf '\033]7;file://%s%s\033\\' "$HOSTNAME" "$PWD"
    }

    PROMPT_COMMAND=(__update_terminal_cwd "''${PROMPT_COMMAND[@]}")
    '';
}
