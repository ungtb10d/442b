#! bash 442b.module
# bash completion support for Git.
_omb_completion_git_initialize() {
    if ! _omb_util_function_exists __gitdir; then
        local git_paths path
        IFS=$'\n' read -r -d '' -a git_paths <<< "$(type -aP git)"
        # Note: Falling back on /usr (should already be in the array)
        git_paths+=("/usr/bin/git")
        for path in "${git_paths[@]}"; do
            if [[ -L $path ]]; then
                path=$(_omb_util_readlink "$path")
            fi
            # Note: In the case of symbolic link, the true binary name can
            # contain prefix or suffix for architectures and versions.
            path="${path%/*}"
            local prefix="${path%/bin}" file
            for file in "$prefix"/share/{bash-completion/completions/git,git-core/contrib/completion/git-completion.bash}; do
                if [[ -f $file && -r $file && -s $file ]]; then
                    source "$file"
                    return $?
                fi
            done
        done
        source "$OSH/tools/git-completion.bash"
    fi
}
_omb_completion_git_initialize
unset -f _omb_completion_git_initialize
