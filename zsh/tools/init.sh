for f in ${0:A:h}/*.sh(N); do
  [[ "$f" != "${0:A:h}/init.sh" ]] && source "$f"
done
