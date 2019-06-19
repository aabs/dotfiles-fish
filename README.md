# fishdots
My fish shell dotfiles, plus a plugin framework and event dispatching mechanism
allowing plugins to work together.

## Tasks

* [ ] Use fishdots events as a decoupling mechanism between plugins
* [ ] create a directory of standard events
* [ ] create a way to get the list of standard events
* [ ] 

## Concepts

- *context* - a new mode of working, based around a set of tools, technologies,
  paths and environment settings


## Completed Requirements
- [X] scan for all relevant files under base `dotfiles` dir.
- [X] link all `.symlink` files into `~`
- [X] manage submodules for common shell plugins
- [X] define aliases
- [X] project handling system to allow jumps to hot spots
- [X] manage tasks
- [X] manage notes
- [X] adapt to local circumstances to add and leave out machine or platform
  specific scripts
- [X] define a natural order of application *like `init.d` levels(??)*
- [X] apply env variables by context

