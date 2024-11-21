local wezterm = require 'wezterm'

local act = wezterm.action

local function basename(s)
	return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local nerd_icons = {
      nvim = wezterm.nerdfonts.custom_vim,
      vim = wezterm.nerdfonts.custom_vim,
      bash = wezterm.nerdfonts.dev_terminal,
      zsh = wezterm.nerdfonts.dev_terminal,
      ssh = wezterm.nerdfonts.mdi_server,
      top = wezterm.nerdfonts.mdi_monitor,
      docker = wezterm.nerdfonts.dev_docker,
      node = wezterm.nerdfonts.dev_nodejs_small,
	}

    local zoomed = ''
    if tab.active_pane.is_zoomed then
        zoomed = '[Z]'
    end
    local pane = tab.active_pane
    local process_name = basename(pane.foreground_process_name)
    local icon = nerd_icons[process_name]
    local cwd = basename(pane.current_working_dir)
    local title = cwd .. '  | ' .. process_name
    if icon ~= nil then
		title = icon .. '  ' .. zoomed .. title
	end
    return {
		{ Text = ' ' .. title .. ' ' },
	}
  end
);

-- 右ステータスのカスタマイズ
wezterm.on('update-right-status', function(window, pane)
  local cells = {};
  -- 現在のディレクトリ
  local cwd_uri = pane:get_current_working_dir()
  if cwd_uri then
    cwd_uri = cwd_uri:sub(8);
    local slash = cwd_uri:find('/')
    local cwd = ''
    local hostname = ''
    if slash then
      hostname = cwd_uri:sub(1, slash-1)
      local dot = hostname:find('[.]')
      if dot then
        hostname = hostname:sub(1, dot-1)
      end
      cwd = cwd_uri:sub(slash)

      table.insert(cells, cwd);
      table.insert(cells, leader);
    end
  end

  -- 時刻表示
  local date = wezterm.strftime('%a %b %-d %H:%M');
  table.insert(cells, date);

  -- バッテリー
  for _, b in ipairs(wezterm.battery_info()) do
    table.insert(cells, string.format('%.0f%%', b.state_of_charge * 100))
  end

  -- The filled in variant of the < symbol
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

  -- The powerline < symbol
  local LEFT_ARROW = utf8.char(0xe0b3);

  -- Color palette for the backgrounds of each cell
  local colors = {
    '#3c1361',
    '#52307c',
    '#663a82',
    '#7c5295',
    '#b491c8',
  };

  -- Foreground color for the text across the fade
  local text_fg = '#c0c0c0';

  -- The elements to be formatted
  local elements = {};
  -- How many cells have been formatted
  local num_cells = 0;

  -- Translate a cell into elements
  function push(text, is_last)
    local cell_no = num_cells + 1
    table.insert(elements, { Foreground = { Color = text_fg } })
    table.insert(elements, { Background = { Color = colors[cell_no] } })
    table.insert(elements, { Text = ' ' .. text .. ' ' })
    if not is_last then
      table.insert(elements, { Foreground = { Color = colors[cell_no + 1] } })
      table.insert(elements, { Text = SOLID_LEFT_ARROW })
    end
    num_cells = num_cells + 1
  end

  while #cells > 0 do
    local cell = table.remove(cells, 1)
    push(cell, #cells == 0)
  end

  window:set_right_status(wezterm.format(elements));
end);

return {
    -- General appearance
    color_scheme = 'Chalk',
    font = wezterm.font 'Comic Code',
    font_size = 16.0,
    window_background_gradient = {
      orientation = 'Vertical',
      colors = {
        '#1a261d',
        '#2b332d',
      },
    },
    window_background_opacity = 0.97,

    -- Window size & padding
    initial_cols = 200,
    initial_rows = 80,
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

    -- SSH domains
    ssh_domains = {
        {
            name = 'mts.server',
            remote_address = '191.101.81.240',
            username = 'naoyuki',
        },
    },
}
