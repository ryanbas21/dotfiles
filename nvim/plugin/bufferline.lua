local ok, bufferline = pcall(require, "bufferline")
if not ok then
    return
end


vim.opt.termguicolors = true
bufferline.setup{}

diagnostics_indicator = function(count, level, diagnostics_dict, context)
  local s = " "
  for e, n in pairs(diagnostics_dict) do local sym = e == "error" and " "
      or (e == "warning" and " " or "" )
    s = s .. n .. sym
  end
  return s
end

local keymap = vim.keymap.set
keymap('n', '[b', '<cmd>BufferLineCycleNext<CR>', { noremap = true})
keymap('n', ']b', '<cmd>BufferLineCyclePrev<CR>', { noremap = true })

-- " These commands will sort buffers by directory, language, or a custom criteria
keymap('n', '<leader>bse', function()
                              bufferline.sort_buffers_by('extension')
                            end 
      )
keymap('n', '<leader>bsd', function()
                            bufferline.sort_buffers_by('directory')
                          end
      )
keymap('n', '<leader>bst', function()
                            bufferline.sort_buffers_by('tabs')
                          end
      )

keymap('n', '<leader>1', function()
                            bufferline.go_to_buffer('1', true)
                          end
      )
keymap('n', '<leader>2', function()
                            bufferline.go_to_buffer('2', true)
                          end
      )
keymap('n', '<leader>3', function()
                            bufferline.go_to_buffer('3', true)
                          end
      )
keymap('n', '<leader>4', function()
                            bufferline.go_to_buffer('4', true)
                          end
      )
keymap('n', '<leader>5', function()
                            bufferline.go_to_buffer('5', true)
                          end
      )
keymap('n', '<leader>6', function()
                            bufferline.go_to_buffer('6', true)
                          end
      )
keymap('n', '<leader>7', function()
                            bufferline.go_to_buffer('7', true)
                          end
      )
keymap('n', '<leader>8', function()
                            bufferline.go_to_buffer('8', true)
                          end
      )
keymap('n', '<leader>9', function()
                            bufferline.go_to_buffer('9', true)
                          end
      )
keymap('n', '<leader>0', function()
                            bufferline.go_to_buffer('-1', true)
                          end
      )
