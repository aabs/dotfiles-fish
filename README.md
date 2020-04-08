# fishdots

A fish shell [dotfile](https://en.wikipedia.org/wiki/Hidden_file_and_hidden_directory#Unix_and_Unix-like_environments) and plugin framework.  It started out as a simple system to load dotfiles, but over time it has morphed into a system based around plugins that allows unlimited extensibility.

Under the hood, it makes use of [fish shell's](https://fishshell.com/) eventing mechanism to allow extensibility to events, and many key pieces of functionality are scheduled through events.  That means you can hook into those events to provide your own additional functionality.  For example, it use it to keep transcripts of what I do, or to push events through to IFTTT to allow easy CLI tweeting.

## Quick Start

On your command line, you just need to run this:

```shell
curl -skLq bit.ly/fishdots_install | fish
```

To bulk install your preferred plugins. You use the `installfrom` command:

```
plugin installfrom ~/fishdots_plugins.txt
```

you need to create a list of the plugins that you want installed, before invoking `installfrom`.  These can come from any git repo (but it must be a URL that Git understands).  

Here's my spec:

```
https://github.com/aabs/fishdots_checklist.git
https://github.com/aabs/fishdots_clipboard.git
https://github.com/aabs/fishdots_crm.git
https://github.com/aabs/fishdots_devdirs.git
https://github.com/aabs/fishdots_git.git
https://github.com/aabs/fd_idea.git
https://github.com/aabs/fishdots_k8s.git
https://github.com/aabs/fishdots_kafka.git
https://github.com/aabs/fishdots_kops.git
https://github.com/aabs/fishdots_lob.git
https://github.com/aabs/fishdots_nixos.git
https://github.com/aabs/fishdots_notes.git
https://github.com/aabs/fishdots_problem.git
https://github.com/aabs/fishdots_projects.git
https://github.com/aabs/fishdots_sparql.git
https://github.com/aabs/fishdots_tech.git
https://github.com/aabs/fishdots_timekeeping.git
https://github.com/aabs/fishdots_tmux.git
https://github.com/aabs/fishdots_todo.git
https://github.com/aabs/fishdots_transcript.git
```

You can, of course, install these individually as you need them.  Just use the `install` command like this:

```
plugin install https://github.com/aabs/fishdots_checklist.git
```

Now, when you start fish, the fishdots framework will run in the background defining various commands and abbreviations.