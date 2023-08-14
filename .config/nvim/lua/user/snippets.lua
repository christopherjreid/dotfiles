local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

-- some shorthands...
local snip = luasnip.snippet
local node = luasnip.snippet_node
local text = luasnip.text_node
local insert = luasnip.insert_node
local func = luasnip.function_node
local choice = luasnip.choice_node
local dynamicn = luasnip.dynamic_node

luasnip.config.set_config {
    history = true,
    -- treesitter-hl has 100, use something higher (default is 200).
    ext_base_prio = 200,
    -- minimal increase in priority.
    ext_prio_increase = 1,
    enable_autosnippets = false,
    store_selection_keys = "<c-s>",
}

local function get_line_iter(str)
    if str:sub(-1) ~= "\n" then
        str = str .. "\n"
    end

    return str:gmatch "(.-)\n"
end
local function box_trim_lines(str)
    local new_str = ""

    for line in get_line_iter(str) do
        line = line:gsub("^%s+", "")
        line = string.gsub(line, "%s+$", "")
        new_str = new_str .. "\n" .. line
    end

    return new_str
end

local date = function()
    return { os.date "%Y-%m-%d" }
end

local pretty_date = function()
    return { os.date("%B %d, %Y") }
end

local filename = function()
    return { vim.fn.expand "%:p" }
end

-- Make sure to not pass an invalid command, as io.popen() may write over nvim-text.
local function bash(_, _, command)
    local file = io.popen(command, "r")
    local res = {}
    for line in file:lines() do
        table.insert(res, line)
    end
    return res
end

luasnip.add_snippets(nil, {
    all = {
        snip({
            trig = "date",
            namr = "Date",
            dscr = "Date in the form of YYYY-MM-DD",
        }, {
            func(date, {}),
        }),
        snip({
            trig = "pwd",
            namr = "PWD",
            dscr = "Path to current working directory",
        }, {
            func(bash, {}, { user_args = { "pwd" } }),
        }),
        snip({
            trig = "filename",
            namr = "Filename",
            dscr = "Absolute path to file",
        }, {
            func(filename, {}),
        }),
        snip({
            trig = "signature",
            namr = "Signature",
            dscr = "Name and Surname",
        }, {
            text "Sergei Bulavintsev",
            insert(0),
        }),
    },
    cpp = {
        snip("struct", {
            text { "struct " },
            insert(1),
            text { "", "{", "" },
            insert(0),
            text { "", "};" }
        }),
        snip("class", {
            text { "class " },
            insert(1),
            text { "", "{", "public:", "" },
            insert(0),
            text { "", "};" }
        }),
    },
    sh = {
        snip("shebang", {
            text { "#!/bin/sh", "" },
            insert(0),
        }),
    },
    python = {
        snip("shebang", {
            text { "#!/usr/bin/env python", "" },
            insert(0),
        }),
    },
    lua = {
        snip("shebang", {
            text { "#!/usr/bin/lua", "", "" },
            insert(0),
        }),
        snip("req", {
            text "require('",
            insert(1, "Module-name"),
            text "')",
            insert(0),
        }),
        snip("func", {
            text "function(",
            insert(1, "Arguments"),
            text { ")", "\t" },
            insert(2),
            text { "", "end", "" },
            insert(0),
        }),
        snip("forp", {
            text "for ",
            insert(1, "k"),
            text ", ",
            insert(2, "v"),
            text " in pairs(",
            insert(3, "table"),
            text { ") do", "\t" },
            insert(4),
            text { "", "end", "" },
            insert(0),
        }),
        snip("fori", {
            text "for ",
            insert(1, "k"),
            text ", ",
            insert(2, "v"),
            text " in ipairs(",
            insert(3, "table"),
            text { ") do", "\t" },
            insert(4),
            text { "", "end", "" },
            insert(0),
        }),
        snip("if", {
            text "if ",
            insert(1),
            text { " then", "\t" },
            insert(2),
            text { "", "end", "" },
            insert(0),
        }),
        snip("M", {
            text { "local M = {}", "", "" },
            insert(0),
            text { "", "", "return M" },
        }),
    },
    markdown = {
        -- Select link, press C-s, enter link to receive snippet
        snip({
            trig = "link",
            namr = "markdown_link",
            dscr = "Create markdown link [txt](url)",
        }, {
            text "[",
            insert(1),
            text "](",
            func(function(_, snip)
                return snip.env.TM_SELECTED_TEXT[1] or {}
            end, {}),
            text ")",
            insert(0),
        }),
        snip({
            trig = "codewrap",
            namr = "markdown_code_wrap",
            dscr = "Create markdown code block from existing text",
        }, {
            text "``` ",
            insert(1, "Language"),
            text { "", "" },
            func(function(_, snip)
                local tmp = {}
                tmp = snip.env.TM_SELECTED_TEXT
                tmp[0] = nil
                return tmp or {}
            end, {}),
            text { "", "```", "" },
            insert(0),
        }),
        snip({
            trig = "codeempty",
            namr = "markdown_code_empty",
            dscr = "Create empty markdown code block",
        }, {
            text "``` ",
            insert(1, "Language"),
            text { "", "" },
            insert(2, "Content"),
            text { "", "```", "" },
            insert(0),
        }),
        snip({
            trig = "meta",
            namr = "Metadata",
            dscr = "Yaml metadata format for markdown",
        }, {
            text { "---", "title: " },
            insert(1, "note_title"),
            text { "", "author: " },
            insert(2, "author"),
            text { "", "date: " },
            func(date, {}),
            text { "", "cathegories: [" },
            insert(3, ""),
            text { "]", "lastmod: " },
            func(date, {}),
            text { "", "tags: [" },
            insert(4),
            text { "]", "comments: true", "---", "" },
            insert(0),
        }),
    },
})
