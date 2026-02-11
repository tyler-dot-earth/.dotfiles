# git-hunks - non-interactive selective hunk staging
# https://github.com/rockorager/git-hunks

# Add git-hunks to PATH if it exists as a submodule
GIT_HUNKS_DIR="${0:A:h}/../../git-hunks"
if [[ -d "$GIT_HUNKS_DIR" && -x "$GIT_HUNKS_DIR/git-hunks" ]]; then
  export PATH="$GIT_HUNKS_DIR:$PATH"
fi

# Optional: Create aliases for common operations
# alias ghl='git hunks list'
# alias gha='git hunks add'
