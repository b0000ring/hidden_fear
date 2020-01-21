local inputActions = {
    menu = {},
    main = {},
    interface = {}
}
inputActions['menu']['return'] = 'return'
inputActions['menu']['escape'] = 'escape'

inputActions['interface']['return'] = 'return'
inputActions['interface']['escape'] = 'escape'

inputActions['main']['up'] = 'move_up'
inputActions['main']['h'] = 'show_help'
inputActions['main']['m'] = 'show_map'
inputActions['main']['i'] = 'show_inventory'
inputActions['main']['escape'] = 'escape'
inputActions['main']['down'] = 'move_down'
inputActions['main']['right'] = 'move_right'
inputActions['main']['left'] = 'move_left'
inputActions['main']['space'] = 'wait'
inputActions['main']['z'] = 'pickup'
inputActions['main']['x'] = 'heal'
inputActions['main']['c'] = 'drop_weapon'

return inputActions