# Fishdots Commands, Functions and Abbreviations

## Commands

### `fishdot` command

This is the primary entrypoint into fishdots itself.  Normally plugins will create their own commands using the same pattern.

#### `fishdots home`

cd to fishdots directory


#### `fishdots save`

save all new or modified files in folder locally

#### `fishdots sync`

save all files in folder back to origin repo

#### `fishdots update`

get the latest version of fishdots and each of its plugins

#### `fishdots help`

display list of options for the `fishdots` command.

#### `plugin home`

Go to the plugin root folder. Typically this will be `~/.config/fishdots/plugins`.

#### `plugin install  <url> <name>`

install the plugin identified by the git repo path using the name supplied

#### `plugin uninstall <name>`

Remove the plugin by name

#### `plugin ls`

list all installed plugins

#### `plugin sync`

save and push any changed plugins to their origins

#### `plugin help`

Displays commands and options for handling plugins.

## Useful Functions

### `fd_menu`



### `fishdots_search <root_path> <pattern>`

find file by full text search

### `fishdots_find <root_path> <pattern>`

find item by name

### `fishdots_find_select <root_path> <pattern>`

find item by name and select using menu

### `fishdots_search_select <root_path> <pattern>`

find item by full text search and select using menu

### `mcd <path>`

Creates a folder and then goes into that folder

### `pubkey`

copies your default public key into the clipboard

## Abbreviations

- **`fd`** =>  `fishdots`
- **`fdh`** => `fishdots home`
- **`fdp`** => `plugin home`
