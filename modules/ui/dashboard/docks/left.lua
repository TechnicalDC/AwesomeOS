local wibox = require("wibox")

return wibox.widget {
    nil,
    require("modules.ui.tasklist.tasklist"),
    nil,
    expand = "none",
    layout = wibox.layout.align.vertical
}
