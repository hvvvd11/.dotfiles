local M = {}

M.format = function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local result = {}
    local i = 1

    while i <= #lines do
        local line = lines[i]

        -- Does this line start a {% call block?
        local indent = line:match("^(%s*){%%[-]?%s*call[%s%w_:]")
        if not indent then
            indent = line:match("^(%s*){%%[-]?%s*call%s*$")
        end

        if indent then
            -- Collect everything from {% call ... to the closing %}
            local collected = line
            local end_line = i

            -- Check if this line already contains the closing %}
            if not collected:match("%%}") then
                end_line = i + 1
                while end_line <= #lines do
                    collected = collected .. " " .. lines[end_line]
                    if lines[end_line]:match("%%}") then
                        break
                    end
                    end_line = end_line + 1
                end
            end

            -- Split off anything after %} (like {% endcall %})
            local call_part, after_close = collected:match("^(.-%s*%%})(.*)")

            if call_part then
                -- Extract macro and args from the collected call block
                local macro, args = call_part:match(
                    "call%s+([%w_:]+)%((.+)%)"
                )

                if macro and args then
                    -- Parse args
                    local arg_list = {}
                    for arg in args:gmatch("[^,]+") do
                        local trimmed = arg:match("^%s*(.-)%s*$")
                        if trimmed and trimmed ~= "" then
                            table.insert(arg_list, trimmed)
                        end
                    end

                    -- Write formatted output
                    table.insert(result, indent .. "{% call")
                    table.insert(result, indent .. "    " .. macro .. "(")
                    for j, arg in ipairs(arg_list) do
                        local suffix = j < #arg_list and "," or ""
                        table.insert(result, indent .. "        " .. arg .. suffix)
                    end
                    table.insert(result, indent .. "    )")
                    table.insert(result, indent .. "%}")

                    -- Handle {% endcall %} - could be inline or on next lines
                    local found_endcall = false

                    -- Check if endcall was on the same collected line
                    if after_close and after_close:match("{%%[-]?%s*endcall%s*[-]?%%}") then
                        found_endcall = true
                    end

                    i = end_line + 1

                    -- If not found inline, look at following lines
                    if not found_endcall then
                        while i <= #lines and lines[i]:match("^%s*$") do
                            i = i + 1
                        end
                        if i <= #lines and lines[i]:match("^%s*{%%[-]?%s*endcall%s*[-]?%%}%s*$") then
                            found_endcall = true
                            i = i + 1
                        end
                    end

                    if found_endcall then
                        table.insert(result, indent .. "{% endcall %}")
                        table.insert(result, "")
                        -- Skip any existing blank lines after endcall
                        while i <= #lines and lines[i]:match("^%s*$") do
                            i = i + 1
                        end
                    end
                else
                    -- Couldn't parse, keep original
                    table.insert(result, line)
                    i = i + 1
                end
            else
                table.insert(result, line)
                i = i + 1
            end
        else
            table.insert(result, line)
            i = i + 1
        end
    end

    vim.api.nvim_buf_set_lines(0, 0, -1, false, result)
end

return M
