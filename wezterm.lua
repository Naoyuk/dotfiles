local wezterm = require 'wezterm'

local act = wezterm.action

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local edge_background = '#0b0022'
    local background = '#1b1032'
    local foreground = '#808080'

    if tab.is_active then
      background = '#2b2042'
      foreground = '#c0c0c0'
    elseif hover then
      background = '#3b3052'
      foreground = '#909090'
    end

    local edge_foreground = background

    -- ensure that the titles fit in the available space,
    -- and that we have room for the edges.
    local title = wezterm.truncate_right(tab.active_pane.title, max_width - 2)

    return {
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = SOLID_LEFT_ARROW },
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = title },
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = SOLID_RIGHT_ARROW },
    }
  end
)

return {
    -- General appearance
    color_scheme = "Chalk",
    font = wezterm.font 'Comic Code',
    font_size = 16.0,
    window_background_gradient = {
      orientation = 'Vertical',
      colors = {
        '#1a261d',
        '#2b332d',
      },
    },
    window_background_opacity = 0.92,

    -- Window size & padding
    initial_cols = 150,
    initial_rows = 50,
    window_padding = {
      left = 5,
      right = 5,
      top = 0,
      bottom = 0,
    },

    -- Scrollback
    scrollback_lines = 100000,

    -- Key binding

    keys = {

      -- PaneSelect
      -- CTTL + 8 でペインセレクトモードを起動
      { key = '8', mods = 'CTRL', action = act.PaneSelect },

      -- CTRL + 9 でペインセレクトモードに入り、ペインの位置を入れ替えたいIDを入力
      -- ペインの位置を入れ替えた上で、そのペインが選択された状態になる
      {
        key = '9',
        mods = 'CTRL',
        action = act.PaneSelect {
          mode = 'SwapWithActive',
        },
      },
    },
}
