# dotfiles-fish
My fish shell dotfiles, loosely modeled on holman/dotfiles

## Requirements

- [X] scan for all relevant files under base `dotfiles` dir.
- [X] link all `.symlink` files into `~`
- [ ] manage submodules for common shell plugins
- [X] define aliases
- [X] project handling system to allow jumps to hot spots
- [X] manage tasks
- [ ] manage notes
- [ ] adapt to local circumstances to add and leave out machine or platform specific scripts
- [X] define a natural order of application *like `init.d` levels(??)*
- [ ] apply env variables by context


## Concepts

- *context* - a new mode of working, based around a set of tools, technologies, paths and environment settings

## Tasks

- [ ] Define a SQLite3 database wrapper to get and set context variables
- [ ] Define a set of standard functions for getting, setting envs, vars, and functions etc