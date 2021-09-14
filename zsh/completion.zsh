#compdef p

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

_p() {
    if [[ $service != p ]]; then
        _call_function - _$service
        return
    fi

    _files -W $PROJECTS -/
}

compdef _p p
