local M = {}

function M.config()
  local palettes = {
    ['black-metal-dark-funeral'] = {
      -- name: Black Metal (Dark Funeral)
      -- author: metalelf0 (https://github.com/metalelf0)
      base00 = "#000000",
      base01 = "#121212",
      base02 = "#222222",
      base03 = "#333333",
      base04 = "#999999",
      base05 = "#c1c1c1",
      base06 = "#999999",
      base07 = "#c1c1c1",
      base08 = "#5f8787",
      base09 = "#aaaaaa",
      base0A = "#5f81a5",
      base0B = "#d0dfee",
      base0C = "#aaaaaa",
      base0D = "#888888",
      base0E = "#999999",
      base0F = "#444444",
    },
    ['classic-dark'] = {
      -- name: Classic Dark
      -- author: Jason Heeris (http://heeris.id.au)
      base00 = "#151515",
      base01 = "#202020",
      base02 = "#303030",
      base03 = "#505050",
      base04 = "#B0B0B0",
      base05 = "#D0D0D0",
      base06 = "#E0E0E0",
      base07 = "#F5F5F5",
      base08 = "#AC4142",
      base09 = "#D28445",
      base0A = "#F4BF75",
      base0B = "#90A959",
      base0C = "#75B5AA",
      base0D = "#6A9FB5",
      base0E = "#AA759F",
      base0F = "#8F5536",
    },
    ['classic-light'] = {
      -- name: Classic Light
      -- author: Jason Heeris (http://heeris.id.au)
      base00 = "#F5F5F5",
      base01 = "#E0E0E0",
      base02 = "#D0D0D0",
      base03 = "#B0B0B0",
      base04 = "#505050",
      base05 = "#303030",
      base06 = "#202020",
      base07 = "#151515",
      base08 = "#AC4142",
      base09 = "#D28445",
      base0A = "#F4BF75",
      base0B = "#90A959",
      base0C = "#75B5AA",
      base0D = "#6A9FB5",
      base0E = "#AA759F",
      base0F = "#8F5536",
    },
    ['grayscale-dark'] = {
      -- name: Grayscale Dark
      -- author: Alexandre Gavioli (https://github.com/Alexx2/)
      base00 = "#101010",
      base01 = "#252525",
      base02 = "#464646",
      base03 = "#525252",
      base04 = "#ababab",
      base05 = "#b9b9b9",
      base06 = "#e3e3e3",
      base07 = "#f7f7f7",
      base08 = "#7c7c7c",
      base09 = "#999999",
      base0A = "#a0a0a0",
      base0B = "#8e8e8e",
      base0C = "#868686",
      base0D = "#686868",
      base0E = "#747474",
      base0F = "#5e5e5e",
    },
    ['grayscale-light'] = {
      -- name: Grayscale Light
      -- author: Alexandre Gavioli (https://github.com/Alexx2/)
      base00 = "#f7f7f7",
      base01 = "#e3e3e3",
      base02 = "#b9b9b9",
      base03 = "#ababab",
      base04 = "#525252",
      base05 = "#464646",
      base06 = "#252525",
      base07 = "#101010",
      base08 = "#7c7c7c",
      base09 = "#999999",
      base0A = "#a0a0a0",
      base0B = "#8e8e8e",
      base0C = "#868686",
      base0D = "#686868",
      base0E = "#747474",
      base0F = "#5e5e5e",
    },
    ['greenscreen'] = {
      -- name: Green Screen
      -- author: Chris Kempson (http://chriskempson.com)
      base00 = "#001100",
      base01 = "#003300",
      base02 = "#005500",
      base03 = "#007700",
      base04 = "#009900",
      base05 = "#00bb00",
      base06 = "#00dd00",
      base07 = "#00ff00",
      base08 = "#007700",
      base09 = "#009900",
      base0A = "#007700",
      base0B = "#00bb00",
      base0C = "#005500",
      base0D = "#009900",
      base0E = "#00bb00",
      base0F = "#005500",
    },
    ['onedark-base16'] = {
      -- name: OneDark
      -- author: Lalit Magant (http://github.com/tilal6991)
      base00 = "#282c34",
      base01 = "#353b45",
      base02 = "#3e4451",
      base03 = "#545862",
      base04 = "#565c64",
      base05 = "#abb2bf",
      base06 = "#b6bdca",
      base07 = "#c8ccd4",
      base08 = "#e06c75",
      base09 = "#d19a66",
      base0A = "#e5c07b",
      base0B = "#98c379",
      base0C = "#56b6c2",
      base0D = "#61afef",
      base0E = "#c678dd",
      base0F = "#be5046",
    },
    ['solarized-dark'] = {
      -- name: Solarized Dark
      -- author: Ethan Schoonover (modified by aramisgithub)
      base00 = "#002b36",
      base01 = "#073642",
      base02 = "#586e75",
      base03 = "#657b83",
      base04 = "#839496",
      base05 = "#93a1a1",
      base06 = "#eee8d5",
      base07 = "#fdf6e3",
      base08 = "#dc322f",
      base09 = "#cb4b16",
      base0A = "#b58900",
      base0B = "#859900",
      base0C = "#2aa198",
      base0D = "#268bd2",
      base0E = "#6c71c4",
      base0F = "#d33682",
    },
    ['solarized-light'] = {
      -- name: Solarized Light
      -- author: Ethan Schoonover (modified by aramisgithub)
      base00 = "#fdf6e3",
      base01 = "#eee8d5",
      base02 = "#93a1a1",
      base03 = "#839496",
      base04 = "#657b83",
      base05 = "#586e75",
      base06 = "#073642",
      base07 = "#002b36",
      base08 = "#dc322f",
      base09 = "#cb4b16",
      base0A = "#b58900",
      base0B = "#859900",
      base0C = "#2aa198",
      base0D = "#268bd2",
      base0E = "#6c71c4",
      base0F = "#d33682",
    },
    ['purple-and-pink'] = {
      -- author: yuma140902
      base00 = "#081245", -- "hsl(230 80% 15%)", -- default background
      base01 = "#25085e", -- "hsl(260 85% 20%)", -- lighter background
      base02 = "#5c0a5c", -- "hsl(300 80% 20%)", -- selection background
      base03 = "#6d527a", -- "hsl(280 20% 40%)", -- comments, invisibles, line highlighting
      base04 = "#af8bc1", -- "hsl(280 30% 65%)", -- dark foreground
      base05 = "#dfc6ec", -- "hsl(280 50% 85%)", -- default foreground
      base06 = "#f5ebfa", -- "hsl(280 60% 95%)", -- light foreground
      base07 = "#7359a6", -- "hsl(260 30% 50%)", -- light background
      base08 = "#d98cbf", -- "hsl(320 50% 70%)", -- variables
      base09 = "#d98cd9", -- "hsl(300 50% 70%)", -- constants
      base0A = "#bf8cd9", -- "hsl(280 50% 70%)", -- classes
      base0B = "#a68cd9", -- "hsl(260 50% 70%)", -- strings
      base0C = "#8c8cd9", -- "hsl(240 50% 70%)", -- support, regular expressions, escape characters
      base0D = "#8ca6d9", -- "hsl(220 50% 70%)", -- functions
      base0E = "#8cbfd9", -- "hsl(200 50% 70%)", -- keywords
      base0F = "#8cb3d9", -- "hsl(210 50% 70%)", -- deprecated
    }
  }

  local scheme_names = vim.tbl_keys(palettes)
  table.insert(scheme_names, 'onedark')

  -- mini.nvimで起動のたびに異なるbase16 colorschemeを使用する
  -- https://zenn.dev/kawarimidoll/articles/c2367b1e2e0849
  vim.api.nvim_create_user_command(
    'MiniScheme',
    function(opts)
      local key = opts.fargs[1]

      if key == 'onedark' then
        vim.cmd('colorscheme onedark')
        return
      elseif vim.tbl_contains(scheme_names, key) then
        vim.g.scheme_name = key
      else
        math.randomseed(os.time())
        vim.g.scheme_name = scheme_names[math.random(#scheme_names)]
      end

      require('mini.base16').setup({
        palette = palettes[vim.g.scheme_name],
        use_cterm = true,
      })
    end,
    {
      nargs = '?',
      complete = function() return scheme_names end
    }
  )

  vim.api.nvim_create_autocmd({ 'VimEnter' }, {
    pattern = '*',
    command = 'MiniScheme',
    once = true
  })
end

return M
