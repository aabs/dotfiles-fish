# dotfiles-fish
My fish shell dotfiles, loosely modeled on holman/dotfiles

## Requirements

* scan for all relevant files under base `dotfiles` dir.
* link all `.symlink` files into `~`
* manage submodules for common shell plugins
* define aliases
* project handling system to allow jumps to hot spots
* manage tasks
* manage notes
* adapt to local circumstances to add and leave out machine or platform specific scripts
* define a natural order of application *like `init.d` levels(??)*
* apply env variables by context


## Concepts

- *context* - a new mode of working, based around a set of tools, technologies, paths and environment settings

## Ideas

### Convention Orientation

Define a standard model for what is provided in a context, plus
a standard approach for entering and leaving a context along with
a means to plug in to that operating model to allow extension of the
model by other users.

Q: What would be required to allow context specific settings to be defined?
A. Name spaces for `env`, `function`, `path`, `alias`.

### System Database

Make use of a small local in-memory database to contain relevant info needed to tailor the shell experience.  Step 0 of the boot process would be to insert context configs into the DB. Further activities would then call on the DB for further info.

## Tasks

- [ ] Define a SQLite3 database wrapper to get and set context variables
- [ ] Define a set of standard functions for getting, setting envs, vars, and functions etc