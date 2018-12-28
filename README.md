# Fishdots

A framework for managing dotfiles inspired by fish and Nix.

## Requirements

- [x] scan for all relevant files under base `dotfiles` dir.
- [x] link all `.symlink` files into `~`
- [x] manage submodules for common shell plugins
- [x] define aliases
- [x] project handling system to allow jumps to hot spots
- [x] manage tasks
- [x] manage notes
- [ ] adapt to local circumstances to add and leave out machine or platform specific scripts
- [x] define a natural order of application *like `init.d` levels(??)*
- [x] apply env variables by context

## Concepts

| Term    | Definition                                                                                       |
| ------- | ------------------------------------------------------------------------------------------------ |
| context | a new mode of working, based around a set of tools, technologies, paths and environment settings |

## Immutability Requirements

To make use of the nix inspired generational model, what is
needed?

- [ ] remove use of `save` and `sync` commands to only apply to plugin data
- [ ] define a protocol for the requesting of save operations from a plugin
- [ ] create an area for generations, within the bootstrap process
- [ ] change the install plugin install commands to create new generation

### Immutability questions

- [ ] What to do about previously installed plugins?
- [ ] How can installation of a new plugin build on top of an existing set of plugins?
- [ ] Should creation and management of symlinks be kept separate from the linkage of the plugins?
- [ ] How do you treat fishdots to the same indirection management process?

## Walkthrough

What would happen when a new user adopts the platform? The worst case
scenario is that they, like me, have been using some previous dotfiles
system for a different shell, that works along similar lines.

### User invokes web install script

``` example
curl http://raw.github.com/blah/fishdots.fish | fish
```

This script not only downloads fishdots latest release, but installs it
along with the set of known recommended plugins (if
desired)

- [ ] create a release of fishdots for download by script
- [ ] create downloader script `fishdots.fish` that downloads everything else

### downloader script is invoked within a fish shell

- [ ] download release zip file to tmp dir
- [ ] unpack release zip into preferred area
- [ ] Invoke the true bootstrapper script in situ
- [ ] establish or locate indirection prerequisites (`gens`, `GEN_HOME` env var, `origin` and `default`)
