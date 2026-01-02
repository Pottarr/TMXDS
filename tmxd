#!/usr/bin/env bash

CONFIG="$HOME/.config/tmux/dir_list"

# --------------------------------------------------
# Append directory
# --------------------------------------------------

# Will be use in TMXS with TMUX key bind for only -ap|--append-dir
# without extra trailing arguments
append_dir() {
    [[ -f "$CONFIG" ]] || {
        mkdir -p "$(dirname "$CONFIG")"
        touch "$CONFIG"
    }

    local TARGET

    case $# in
        1)
            TARGET="$PWD"
            ;;
        2)
            TARGET=$(realpath "$2")
            [[ -n "$TARGET" ]] || return 1
            ;;
        *)
            echo "Usage: -ap|--append-dir [dir]" >&2
            return 1
            ;;
    esac

    [[ -d "$TARGET" ]] || {
        echo "Not a directory: $TARGET" | less
        return 1
    }

    if ! rg -q -F -x "$TARGET" "$CONFIG"; then
        echo "$TARGET" >> "$CONFIG"
        echo "Added $TARGET" | less
    else
        echo "Directory already exists" | less
        return 1
    fi
}

# --------------------------------------------------
# Delete directory
# --------------------------------------------------

# Will never be used in TMXS command from TMUX key bind
delete_dir() {
    [[ -f "$CONFIG" ]] || {
        echo "No directory list exists." | less
        return 1
    }

    local TARGET ESC

    case $# in
        1)
            [[ -s "$CONFIG" ]] || {
                echo "No directories to delete." | less
                return 1
            }
            TARGET=$(sk < "$CONFIG") || return 1
            [[ -n "$TARGET" ]] || return 1
            ;;
        2)
            TARGET="$1"
            ;;
        *)
            echo "Usage: delete_dir [directory]" | less
            return 1
            ;;
    esac

    if ! rg -q -F -x "$TARGET" "$CONFIG"; then
        echo "Directory not found in ~/.config/tmux/dir_list" >&2
        return 1
    fi

    ESC=$(printf '%s\n' "$TARGET" | sed 's/[\/&]/\\&/g')
    sed -i "/^$ESC$/d" "$CONFIG"
    echo "Deleted $TARGET"
}

# --------------------------------------------------
# Edit list
# --------------------------------------------------

# Can be use in both inside or outside TMUX
edit_dir() {
    nvim "$CONFIG"
}

# --------------------------------------------------
# Select directory
# --------------------------------------------------
select_dir() {
    local SESSIONS
    SESSIONS=$(tmux ls 2>/dev/null || true)
    if [[ -z "$SESSIONS" ]]; then
        echo "No tmux sessions found." > /dev/null
        exit 1
    fi

    [[ -n "$TMUX" ]] || {
        echo "Must be inside a tmux session." >&2
        return 1
    }

    [[ -f "$CONFIG" && -s "$CONFIG" ]] || {
        echo "No directories to select from ~/.config/tmux/dir_list" > /dev/null
        return 1
    }

    local TARGET

    case $# in
        0)
            TARGET=$(sk < "$CONFIG") || return 1
            [[ -n "$TARGET" ]] || return 1
            ;;
        1)
            TARGET="$1"
            ;;
        *)
            echo "Usage: -se|--select-dir [directory]" > /dev/null
            return 1
            ;;
    esac

    tmux switch-client -c "$TARGET"
}

# --------------------------------------------------
# CLI
# --------------------------------------------------
if [[ $# -eq 0 ]]; then
    echo "Usage:"
    echo "  -ap | --append-dir [directory]"
    echo "  -de | --delete-dir [directory]"
    echo "  -ed | --edit-dir"
    echo "  -se | --select-dir [directory]"
    exit 1
fi

case "$1" in
    -ap|--append-dir)
        append_dir "$@"
        ;;
    -de|--delete-dir)
        delete_dir "$@"
        ;;
    -ed|--edit-dir)
        [[ $# -eq 1 ]] || {
            echo "edit-dir takes no arguments" > /dev/null
            exit 1
        }
        edit_dir
        ;;
    -se|--select-dir)
        select_dir "$@"
        ;;
    *)
        echo "Unknown option: $1" > /dev/null
        exit 1
        ;;
esac

