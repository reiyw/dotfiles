function _fzf_cd_ghq() {
    local root="$(ghq root)"
    local repo="$(ghq list | fzf --preview="readme-or-lsd ${root}/{1}" --reverse --height 75%)"
    local dir="${root}/${repo}"
    [ -n "${dir}" ] && cd "${dir}"
    zle accept-line
    zle reset-prompt
}
zle -N _fzf_cd_ghq
bindkey "^]" _fzf_cd_ghq
