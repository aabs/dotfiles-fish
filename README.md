# fishdots
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


## Immutability Requirements

To make use of the nix inspired generational model, what is needed?

- [ ] remove use of `save` and `sync` commands to only apply to plugin data
- [ ] define a protocol for the requesting of save operations from a plugin
- [ ] create an area for generations, within the bootstrap process
- [ ] change the install plugin install commands to create new generation


### Immutability questions

- [ ] What to do about previously installed plugins?  
- [ ] How can installation of a new plugin build on top of an existing set of plugins?
- [ ] Should creation and management of symlinks be kept separate from the linkage of the plugins?
- [ ] How do you treat fishdots to the same indirection management process?