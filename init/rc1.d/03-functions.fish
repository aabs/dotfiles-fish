function install_plugin -a git_url name
   git clone $git_url $FISHDOTS_PLUGINS_HOME/$name
end

function remove_plugin -a name
  # just delete it
  if test -e "$FISHDOTS_PLUGINS_HOME/$name"
    rm -rf "$FISHDOTS_PLUGINS_HOME/$name"
  end
end

function list_plugins
  for p in (find $FISHDOTS_PLUGINS_HOME -maxdepth 1 -mindepth 1 -type d)
    echo (basename $p)
  end
end