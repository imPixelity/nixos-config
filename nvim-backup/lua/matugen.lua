 local M = {}

 function M.setup()
   require('base16-colorscheme').setup {
     -- Background tones
     base00 = '#14140c', -- Default Background
     base01 = '#202018', -- Lighter Background (status bars)
     base02 = '#2b2a21', -- Selection Background
     base03 = '#93917d', -- Comments, Invisibles
     -- Foreground tones
     base04 = '#cac7b1', -- Dark Foreground (status bars)
     base05 = '#e6e3d5', -- Default Foreground
     base06 = '#e6e3d5', -- Light Foreground
     base07 = '#e6e3d5', -- Lightest Foreground
     -- Accent colors
     base08 = '#ffb4ab', -- Variables, XML Tags, Errors
     base09 = '#a5eb94', -- Integers, Constants
     base0A = '#cbc991', -- Classes, Search Background
     base0B = '#e0de63', -- Strings, Diff Inserted
     base0C = '#93d783', -- Regex, Escape Chars
     base0D = '#cecc53', -- Functions, Methods
     base0E = '#cbc991', -- Keywords, Storage
     base0F = '#93000a', -- Deprecated, Embedded Tags
   }
 end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
