local M = {}

M.auto_hide_status = function()
    vim.api.nvim_create_autocmd('RecordingEnter', {
        pattern = '*',
        callback = function() vim.opt_local.cmdheight = 1 end
    })

    vim.api.nvim_create_autocmd('RecordingLeave', {
        pattern = '*',
        callback = function()
            local timer = vim.loop.new_timer()
            -- NOTE: Timer is here because we need to close cmdheight AFTER
            -- the macro is ended, not during the Leave event
            timer:start(50, 0, vim.schedule_wrap(
                function() vim.opt_local.cmdheight = 0 end))
        end
    })
end

return M
