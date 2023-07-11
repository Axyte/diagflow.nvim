local M = {}

local diagflowlazy = require('diagflow.lazy')

M.config = {
    enable = true,
    max_width = 60,
    severity_colors = {
        error = "DiagnosticFloatingError",
        warn = "DiagnosticFloatingWarn",
        info = "DiagnosticFloatingInfo",
        hint = "DiagnosticFloatingHint",
    },
    gap_size = 1,
    scope = 'cursor',  -- 'cursor', 'line'
    placement = 'top', -- top or inline
    padding_top = 0,
    padding_right = 0,
    inline_padding_left = 0, -- padding only for when the placement is inline
    text_align = 'right',    -- 'left', 'right'
}

local error = function(message)
    vim.notify(message, vim.log.levels.ERROR)
end

function M.setup(user_config)
    M.config = vim.tbl_deep_extend('force', {}, M.config, user_config or {})

    -- Validate configuration
    local config = M.config
    if type(config.enable) ~= 'boolean' then
        error('diagflow: Invalid type for "enable" config. Expected boolean, got ' .. type(config.enable))
        return
    end
    if type(config.max_width) ~= 'number' then
        error('diagflow: Invalid type for "max_width" config. Expected number, got ' .. type(config.max_width))
        return
    end
    if type(config.severity_colors) ~= 'table' then
        error('diagflow: Invalid type for "severity_colors" config. Expected table, got ' .. type(config.severity_colors))
        return
    end
    if type(config.gap_size) ~= 'number' then
        error('diagflow: Invalid type for "gap_size" config. Expected number, got ' .. type(config.gap_size))
        return
    end
    if type(config.scope) ~= 'string' or (config.scope ~= 'line' and config.scope ~= 'cursor') then
        error('diagflow: invalid value for "scope" config. expected "line" or "cursor", got ' .. config.scope)
        return
    end
    if type(config.placement) ~= 'string' or (config.placement ~= 'top' and config.placement ~= 'inline') then
        error('diagflow: invalid value for "placement" config. expected "top" or "inline", got ' .. config.placement)
        return
    end
    if type(config.padding_top) ~= 'number' then
        error('diagflow: Invalid type for "padding_top" config. Expected number, got ' .. type(config.padding_top))
        return
    end
    if type(config.padding_right) ~= 'number' then
        error('diagflow: Invalid type for "padding_right" config. Expected number, got ' .. type(config.padding_top))
        return
    end
    if type(config.inline_padding_left) ~= 'number' then
        error('diagflow: Invalid type for "inline_padding_left" config. Expected number, got ' ..
        type(config.inline_padding_left))
        return
    end
    if type(config.text_align) ~= 'string' or (config.text_align ~= 'left' and config.text_align ~= 'right') then
        error('diagflow: Invalid value for "text_align" config. Expected "left" or "right", got ' .. config.text_align)
        return
    end


    diagflowlazy.init(M.config)
end

function M.toggle()
    M.config.enable = not M.config.enable
    if M.config.enable then
        diagflowlazy.init(M.config)
    else
        diagflowlazy.clear()
    end
end

return M
