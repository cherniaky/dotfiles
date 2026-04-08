vim.keymap.set("n", "<leader>gs", "<cmd>vertical botright Git<cr>")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "fugitive",
  callback = function(args)
    -- Save fugitive's original <CR> rhs before we override it
    local original_rhs = nil
    for _, map in ipairs(vim.api.nvim_buf_get_keymap(args.buf, "n")) do
      if map.lhs == "<CR>" then
        original_rhs = map.rhs
        break
      end
    end

    vim.keymap.set("n", "<CR>", function()
      if vim.fn.winnr("$") == 1 then
        -- Only fugitive window — open file in a vertical split to the left
        vim.opt.splitright = false
        local keys = vim.api.nvim_replace_termcodes("gO", true, true, true)
        vim.api.nvim_feedkeys(keys, "m", false)
        -- Restore splitright after the split is created
        vim.defer_fn(function() vim.opt.splitright = true end, 0)
      elseif original_rhs then
        -- Other windows exist — replay fugitive's original <CR> as keystrokes
        local keys = vim.api.nvim_replace_termcodes(original_rhs, true, true, true)
        vim.api.nvim_feedkeys(keys, "n", false)
      end
    end, { buffer = args.buf, nowait = true })
  end,
})
