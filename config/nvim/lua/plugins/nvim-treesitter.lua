-- Code Tree Support / Syntax Highlighting
return {
  -- https://github.com/nvim-treesitter/nvim-treesitter
  'nvim-treesitter/nvim-treesitter',
  event = 'VeryLazy',
  dependencies = {
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',
  opts = {
    highlight = {
      enable = true,
    },
    indent = { enable = true },
    auto_install = true, -- automatically install syntax support when entering new file type buffer
    ensure_installed = {
      'lua',
    },
  },
  config = function (_, opts)
    local configs = require("nvim-treesitter.configs")
    configs.setup(opts)
    vim.treesitter.query.set('python', 'folds', [[
      [
          (function_definition)
          (class_definition)
          (for_statement)
          (if_statement)
          (with_statement)
          (try_statement)
          (match_statement)

          (import_from_statement)
          (parameters)
          (argument_list)
          (parenthesized_expression)
          (generator_expression)
          (list_comprehension)
          (set_comprehension)
          (dictionary_comprehension)
          (tuple)
          (list)
          (set)
          (dictionary)
          (string)
        ] @fold

        [
          (import_statement)
          (import_from_statement)
        ]+ @fold
    ]])
  end
}

