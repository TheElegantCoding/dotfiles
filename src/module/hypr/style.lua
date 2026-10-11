hl.config({
  general = {
    gaps_in = 12,
    gaps_out = 20,
    border_size = 2,
    col = {
      active_border = { colors = { 'rgba(2443d1ee)', 'rgba(CE009Fee)' }, angle = 45 },
      inactive_border = 'rgba(1e2939ee)',
    },
    resize_on_border = false,
    allow_tearing = true,
    layout = 'dwindle',
  },
  decoration = {
    rounding = 16,
    rounding_power = 2,
    active_opacity = 1.0,
    inactive_opacity = 1.0,
    glow = {
      enabled = true,
      range = 15,
      render_power = 3,
      color = { colors = { 'rgba(2443d180)', 'rgba(CE009F80)' }, angle = 45 },
      color_inactive = { colors = { 'rgba(1e2939ee)', 'rgba(1e2939aa)' }, angle = 45 },
    },
    shadow = {
      enabled = true,
      range = 35,
      render_power = 3,
      offset = '0 25',
      color = 0x40000000,
    },
    blur = {
      enabled = true,
      size = 5,
      passes = 1,
      vibrancy = 1,
    },
  },
  animations = {
    enabled = true,
  },
})

hl.curve('fluidSmooth', { type = 'bezier', points = { { 0.16, 1 }, { 0.3, 1 } } })
hl.curve('elasticSwift', { type = 'bezier', points = { { 0.05, 0.9 }, { 0.1, 1.03 } } })
hl.curve('quickSnappy', { type = 'bezier', points = { { 0.1, 0.9 }, { 0.2, 1 } } })

hl.animation({ leaf = 'global', enabled = true, speed = 6, bezier = 'fluidSmooth' })
hl.animation({ leaf = 'border', enabled = true, speed = 5, bezier = 'fluidSmooth' })
hl.animation({ leaf = 'layers', enabled = true, speed = 5, bezier = 'fluidSmooth' })
hl.animation({
  leaf = 'layersIn',
  enabled = true,
  speed = 4,
  bezier = 'elasticSwift',
  style = 'fade',
})
hl.animation({
  leaf = 'layersOut',
  enabled = true,
  speed = 4,
  bezier = 'fluidSmooth',
  style = 'fade',
})
hl.animation({ leaf = 'windows', enabled = true, speed = 5, bezier = 'fluidSmooth' })
hl.animation({
  leaf = 'windowsIn',
  enabled = true,
  speed = 4.5,
  bezier = 'elasticSwift',
  style = 'popin 70%',
})
hl.animation({
  leaf = 'windowsOut',
  enabled = true,
  speed = 4.5,
  bezier = 'fluidSmooth',
  style = 'popin 70%',
})
hl.animation({ leaf = 'fadeIn', enabled = true, speed = 5, bezier = 'fluidSmooth' })
hl.animation({ leaf = 'fadeOut', enabled = true, speed = 5, bezier = 'fluidSmooth' })
hl.animation({ leaf = 'fade', enabled = true, speed = 5, bezier = 'fluidSmooth' })
hl.animation({ leaf = 'fadeLayersIn', enabled = true, speed = 5, bezier = 'fluidSmooth' })
hl.animation({ leaf = 'fadeLayersOut', enabled = true, speed = 5, bezier = 'fluidSmooth' })
hl.animation({
  leaf = 'workspaces',
  enabled = true,
  speed = 5,
  bezier = 'elasticSwift',
  style = 'slidefade',
})
hl.animation({
  leaf = 'workspacesIn',
  enabled = true,
  speed = 5,
  bezier = 'elasticSwift',
  style = 'slidefade',
})
hl.animation({
  leaf = 'workspacesOut',
  enabled = true,
  speed = 5,
  bezier = 'elasticSwift',
  style = 'slidefade',
})
hl.animation({ leaf = 'zoomFactor', enabled = true, speed = 6, bezier = 'quickSnappy' })

hl.config({
  dwindle = {
    preserve_split = true,
  },
})

-- See https://wiki.hypr.land/configuring/layouts/master-layout/ for more
hl.config({
  master = {
    new_status = 'master',
  },
})

-- See https://wiki.hypr.land/configuring/layouts/scrolling-layout/ for more
hl.config({
  scrolling = {
    fullscreen_on_one_column = true,
  },
})