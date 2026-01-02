# TMXDS

## This repository provides:

- `tmxs` $\rightarrow$ Tmux session manager written with pain as I was
trying to learn Shell Script  
(Inspiration: [Sylvan Franklin](https://github.com/SylvanFranklin/.config))
- `tmxd` (Still in development) $\rightarrow$ Tmux directory manager
also written in pain  

## Requirement

- tmux (Of course)
- skim
- ripgrep
- nvim (or other text editor (Feel free to change in code.))

## How to use:

1. Paste these 2 files into your `~/.config/tmux/`.

2. File: `~/.config/tmux/tmux.conf`

```tmux.conf
bind-key m switch-client -T m-prefix
bind-key -T m-prefix i run-shell "tmux new-window -n TMXS ~/.config/tmux/tmxs.sh"
bind-key -T m-prefix d run-shell "tmux new-window -n TMXS ~/.config/tmux/tmxs.sh -de"
bind-key -T m-prefix s run-shell "tmux new-window -n TMXS ~/.config/tmux/tmxs.sh -sw"
bind-key -T m-prefix l switch-client -T d-prefix
bind-key -T d-prefix a run-shell "tmux new-window -n TMXD ~/.config/tmux/tmxd.sh -ap"
bind-key -T d-prefix e run-shell "tmux new-window -n TMXD ~/.config/tmux/tmxd.sh -ed"
bind-key -T d-prefix s run-shell "tmux new-window -n TMXD ~/.config/tmux/tmxd.sh -se"
```

3. Or feel free to add to your application path for better access, so that
you can

```
tmxs # To initialize TMUX in MAIN session easily in your current directory
```
