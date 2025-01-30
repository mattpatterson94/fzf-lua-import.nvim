# fzf-lua-import.nvim

For when the lsp fails to identify modules in your codebase. Quickly search for modules and add the import statement to your buffer.

Depends on fzf-lua to extend upon.

## In Action

TODO

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

```
:Import 
```
