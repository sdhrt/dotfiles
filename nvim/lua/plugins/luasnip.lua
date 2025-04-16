local ls = require("luasnip")
-- some shorthands...
local snip = ls.snippet
-- local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
-- local func = ls.function_node
-- local choice = ls.choice_node
-- local dynamicn = ls.dynamic_node

require("luasnip.loaders.from_vscode").lazy_load()
require('luasnip').filetype_extend("javascript", { "javascriptreact", "typescriptreact" })
require('luasnip').filetype_extend("javascript", { "html" })

ls.add_snippets(nil, {
    c = {
        snip({
                trig = "template",
                namr = "Template",
                dscr = "Template for C"
            },
            {
                text({ "#include <stdio.h>" }),
                text({ "", "int main(){" }),
                text({ "", "\t" }),
                insert(0),
                text({ "", "\t", "return 0;" }),
                text({ "", "}" })
            }),
    },
    cpp = {
        snip({
                trig = "cp",
                namr = "Competitive Programming Template",
                dscr = "Template for C++"
            },
            {
                text({ "#include <bits/stdc++.h>" }),
                text({ "", "using namespace std;" }),
                text({ "", "\t" }),
                text({ "", "int main(){" }),
                text({ "", "\t" }),
                insert(0),
                text({ "", "\t", "return 0;" }),
                text({ "", "}" })
            }),
        snip({
                trig = " template",
                namr = "Template",
                dscr = "Template for C++"
            },
            {
                text({ "#include <iostream>" }),
                text({ "", "using namespace std;" }),
                text({ "", "\t" }),
                text({ "", "int main(){" }),
                text({ "", "\t" }),
                insert(0),
                text({ "", "\t", "return 0;" }),
                text({ "", "}" })
            }),
        snip({
                trig = "leetcode",
                namr = "Leetcode Class Template",
                dscr = "Template for C++"
            },
            {
                text({ "#include <bits/stdc++.h>" }),
                text({ "", "using namespace std;" }),
                text({ "", "\t" }),
                text({ "", "class Solution { public: };" }),
                text({ "", "int main(){" }),
                text({ "", "\t" }),
                insert(0),
                text({ "", "\t", "return 0;" }),
                text({ "", "}" })
            }),
    }
})
