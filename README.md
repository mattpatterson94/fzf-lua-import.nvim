> [!IMPORTANT]
> This has been archived in favour of [fzf-import-cli](https://github.com/mattpatterson94/fzf-import-cli). Please use that instead (follow the instructions for setting up in nvim).

# fzf-lua-import.nvim

For when the lsp fails to identify modules in your codebase. Quickly search for modules and add the import statement to your buffer.

Depends on fzf-lua to extend upon.

## In Action

### Inline

https://github.com/user-attachments/assets/844e9dc6-1859-43b7-b4b2-4a610bf03036


### Live grep

https://github.com/user-attachments/assets/02664751-ec79-4d58-b395-f2f8f7e87396


## Installation

Install [ripgrep](https://github.com/BurntSushi/ripgrep).

Using Lazy:

```lua
  {
    'mattpatterson94/fzf-lua-import.nvim',
    dependencies = { "ibhagwan/fzf-lua" },
    opts = {
      ...
    },
  },
```

## Supported Languages

* JavaScript
* Typescript

## Configuration

`fzf-lua-import.nvim` requires no configuration out of the box, but you can tweak it in the following ways:

```lua
require("fzf-lua-import").setup()
```

## Usage


### Commands

```lua
-- perform a live grep for import
:FzfImport live_grep
-- search for the word under the cursor
:FzfImport grep_cword
```

### Default keymap

```lua
<leader>ci - live grep
<leader>cI - grep_cword
```
