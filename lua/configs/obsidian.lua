return {
  workspaces = {
    {
      name = "Notes",
      path = "~/Documents/wikiNotes",
    },
  },
  completion = {
    nvim_cmp = true,
    min_chars = 2,
  },

  ui = {
   checkboxes = {
      [" "] = { order = 1, char = "󰄱", hl_group = "ObsidianTodo" },
      ["o"] = { order = 2, char = "󰰱", hl_group = "ObsidianTilde" },
      ["X"] = { order = 3, char = "", hl_group = "ObsidianDone" },
    }
  },

  mappings = {
    -- "Obsidian follow"
    ["<cr>"] = require("obsidian.mappings").smart_action(),
    -- Toggle check-boxes "obsidian done"
    ["<leader>ch"] = {
      action = function()
        return require("obsidian.util").toggle_checkbox()
      end,
      opts = { buffer = true },
    },
    ["<leader><leader>"] = {
      action = function()
        return "<cmd>ObsidianQuickSwitch<CR>"
      end,
      opts = { expr = true },
    },
    -- Create a new newsletter issue
    ["<leader>on"] = {
      action = function()
        return require("obsidian").commands.new_note("Newsletter-Issue")
      end,
      opts = { buffer = true },
    },
    ["<leader>ot"] = {
      action = function()
        return require("obsidian").util.insert_template("Newsletter-Issue")
      end,
      opts = { buffer = true },
    },
  },

  new_notes_location = "current_dir",

  note_frontmatter_func = function(note)
    -- This is equivalent to the default frontmatter function.
    if note.title then
      note:add_alias(note.title)
    end
    local out = { id = note.id, title = note.aliases, tags = note.tags }

    -- `note.metadata` contains any manually added fields in the frontmatter.
    -- So here we just make sure those fields are kept in the frontmatter.
    if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
      for k, v in pairs(note.metadata) do
        out[k] = v
      end
    end
    return out
  end,

  note_id_func = function(title)
    -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
    -- In this case a note with the title 'My new note' will be given an ID that looks
    -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
    local suffix = ""
    if title ~= nil then
      -- If title is given, transform it into valid file name.
      suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      -- If title is nil, just add 4 random uppercase letters to the suffix.
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
    end
    return tostring(os.time()) .. "-" .. suffix
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

  preferred_link_style = "wiki",

  templates = {
    subdir = "templates",
    date_format = "%Y-%m-%d-%a",
    time_format = "%H:%M",
    tags = "",
  },
}
