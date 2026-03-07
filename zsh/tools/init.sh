ZSH_TOOLS_DIR="${${(%):-%N}:A:h}"

for f in "$ZSH_TOOLS_DIR"/*.sh(N); do
  [[ "$f" != "$ZSH_TOOLS_DIR/init.sh" ]] && source "$f"
done
