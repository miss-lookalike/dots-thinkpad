local wezterm = require 'wezterm'

local config = wezterm.config_builder()
local act = wezterm.action

-- cosmetic
config.window_background_opacity = 0.3
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 11
config.color_scheme = "Catppuccin Mocha"




-- multiplexing
config.leader = {key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  -- splitting
  {
    mods   = "LEADER",
    key    = "-",
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }
  },
  {
    mods   = "LEADER",
    key    = "=",
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }
  },
    -- rotate panes
  {
    mods = "LEADER",
    key = "Space",
    action = wezterm.action.RotatePanes "Clockwise"
  },

  -- show the pane selection mode, but have it swap the active and selected panes
  {
    mods = 'LEADER',
    key = '0',
    action = wezterm.action.PaneSelect {
      mode = 'SwapWithActive',
    },
  },

  -- movement keys
  {
      mods = "LEADER",
      key = "h",
      action = wezterm.action.ActivatePaneDirection "Left"
  },

  {
      mods = "LEADER",
      key = "j",
      action = wezterm.action.ActivatePaneDirection "Down"
  },

  {
      mods = "LEADER",
      key = "k",
      action = wezterm.action.ActivatePaneDirection "Up"
  },

  {
      mods = "LEADER",
      key = "l",
      action = wezterm.action.ActivatePaneDirection "Right"
  },
  {
      mods = "LEADER",
      key = "LeftArrow",
      action = wezterm.action.AdjustPaneSize { "Left", 5 }
  },
  {
      mods = "LEADER",
      key = "RightArrow",
      action = wezterm.action.AdjustPaneSize { "Right", 5 }
  },
  {
      mods = "LEADER",
      key = "DownArrow",
      action = wezterm.action.AdjustPaneSize { "Down", 5 }
  },
  {
      mods = "LEADER",
      key = "UpArrow",
      action = wezterm.action.AdjustPaneSize { "Up", 5 }
  },
  {
    mods = 'LEADER',
    key = 't',
    action = act.SpawnTab 'CurrentPaneDomain',
  },
}

for i = 1, 9 do
  -- CTRL+ALT + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1),
  })
end


-- tab bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true


-- tmux status
wezterm.on("update-right-status", function(window, _)
    local SOLID_LEFT_ARROW = ""
    local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
    local prefix = ""

    local date = wezterm.strftime("%H:%M %-d-%b-%y");


    if window:leader_is_active() then
        prefix = " " .. utf8.char(0x1f30a) -- ocean wave
        SOLID_LEFT_ARROW = utf8.char(0xe0b2)
    end

    if window:active_tab():tab_id() ~= 0 then
        ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
    end -- arrow color based on if tab is first pane

    window:set_left_status(wezterm.format {
        { Background = { Color = "#b7bdf8" } },
        { Text = prefix },
        ARROW_FOREGROUND,
        { Text = SOLID_LEFT_ARROW }
    })

    window:set_right_status(wezterm.format({
        {Attribute={Italic=false}},
        {Text=""..date},
    }));



end)


return config
