function f
  cd ~/ghq/github.com/$argv[1]
  ls
end

function __fish_complete_f
  set dirs (find ~/ghq -mindepth 3 -maxdepth 3 -type d)
  echo $dirs | sed -E 's/\s/\n/g' | sed -E 's+/home/ampersand/ghq/([^/]\+)/(.*)+\2\t\1+g'
end

complete -c f -f
complete -c f -a "(__fish_complete_f)"
