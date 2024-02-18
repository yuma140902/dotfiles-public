local M = {}

function M.config()
  require 'obsidian'.setup {
    workspaces = { {
      name = "Main Vault",
      path = '~/OneDrive/Obsidian/main',
    } },

    notes_subdir = 'Notes',
    log_level = vim.log.levels.DEBUG,
    new_notes_location = "notes_subdir",
    preferred_link_style = "wiki",
    disable_frontmatter = false,
    sort_by = "modified",
    sort_reversed = true,
    open_notes_in = 'current',

    daily_notes = {
      folder = 'デイリー',
      date_format = '%Y-%m-%d'
    },

    completion = {
      nvim_cmp = true,
      min_chars = 1,
    },

    mappings = {
      ["gf"] = {
        action = function()
          return require 'obsidian'.util.gf_passthrough()
        end,
        opts = {
          noremap = true,
          expr = true,
          buffer = true,
          desc = "[Obsidian.nvim] Open note under cursor"
        }
      },
      ["<leader>c"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = {
          buffer = true,
          desc = "[Obsidian.nvim] Toggle checkbox"
        },
      },
    },

    templates = {
      subdir = '_templates',
      date_format = '%Y-%m-%d-%a',
      time_format = '%H:%M',
    },

    backlinks = {
      height = 10,
      wrap = true
    },

    tags = {
      height = 10,
      wrap = true
    },

    picker = {
      name = "telescope.nvim",
      mappings = {
        new = "<C-x>",
        insert_link = "<C-l>"
      }
    },

    ui = {
      enable = true,
      update_debounce = 200,
      checkboxes = {
        [" "] = { char = "", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
        ["/"] = { char = "", hl_group = "ObsidianProgress" },
        ["-"] = { char = "󰜺", hl_group = "ObsidianCancel" },
      },
      bullets = { char = "•", hl_group = "ObsidianBullet" },
      external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
      reference_text = { hl_group = "ObsidianRefText" },
      highlight_text = { hl_group = "ObsidianHighlightText" },
      tags = { hl_group = "ObsidianTag" },
      hl_groups = {
        -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
        ObsidianTodo = { bold = true, fg = "#f78c6c" },
        ObsidianDone = { bold = true, fg = "#89ddff" },
        ObsidianProgress = { bold = true, fg = "#f78c6c" },
        ObsidianCancel = { bold = true, fg = "#ff5370" },
        ObsidianBullet = { bold = true, fg = "#89ddff" },
        ObsidianRefText = { underline = true, fg = "#c792ea" },
        ObsidianExtLinkIcon = { fg = "#c792ea" },
        ObsidianTag = { italic = true, fg = "#89ddff" },
        ObsidianHighlightText = { bg = "#75662e" },
      },
    },

    attachments = {
      img_folder = "Notes/_assets"
    },

    note_id_func = function(title)
      -- そのまま
      return title
    end,
    wiki_link_func = function(opts)
      if opts.id == nil then
        return string.format("[[%s]]", opts.label)
      elseif opts.label ~= opts.id then
        return string.format("[[%s|%s]]", opts.id, opts.label)
      else
        return string.format("[[%s]]", opts.id)
      end
    end,
    markdown_link_func = function(opts)
      return string.format("[%s](%s)", opts.label, opts.path)
    end,
    image_name_func = function()
      -- Prefix image names with timestamp.
      return string.format("%s-", os.time())
    end,
    follow_url_func = function(url)
      if vim.fn.has 'unix' == 1 then
        vim.fn.jobstart { 'xdg-open', url }
      elseif vim.fn.has 'win32' == 1 then
        vim.fn.jobstart { 'explorer.exe', url }
      else
        vim.fn.jobstart { 'open', url }
      end
    end,
  }
end

return M
