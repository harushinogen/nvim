---------
-- Rei --
---------
local Color, colors, Group, groups, styles = require('colorbuddy').setup()

-- Use Color.new(<name>, <#rrggbb>) to create new colors
-- They can be accessed through colors.<name>
Color.new('orange', '#e27521')
Color.new('sky', '#c2c5e9')
Color.new('wall', '#cfc3b9')
Color.new('nightsky', '#403e72')
Color.new('nightcloud', '#54517a')
Color.new('grey', '#dddbdb')
Color.new('purple', '#555490')
Color.new('morningsky', '#8490c7')
Color.new('cardboard', '#caa979')
Color.new('gold', '#ebbc61')
Color.new('bg2', '#504945')

-- Define highlights in terms of `colors` and `groups`
-- Group.new('Function', colors.yellow, colors.background, styles.bold)
Group.new('Warning', colors.gold, colors.bg2)
Group.new('Danger', colors.orange)
-- --
-- Group.new('Statement', colors.orange, nil, nil)
-- Group.new('Constant', colors.sky, nil, nil)
-- Group.new('Special', colors.gold, nil, nil)
-- Group.new('Type', colors.nightsky, nil, nil)
-- Group.new('typescriptIdentifierName', colors.morningsky, nil, nil)
-- -- -- Define highlights in relative terms of other colors
-- -- Group.new('Error', colors.red:light(), nil, styles.bold)
-- Group.new('TSComment', colors.wall, nil, styles.italic)
-- Group.new('TSString', colors.sky, nil, nil)
-- Group.new('TSVariable', colors.morningsky, nil, nil)
-- Group.new('TSFunction', colors.sky, nil, nil)
-- Group.new('TSPunctDelimiter', colors.gold, nil, nil)
-- Group.new('TSField', colors.gold, nil, nil)
-- Group.new('TSPunctBracket', colors.grey, nil, nil)
-- Group.new('TSConstBuiltin', colors.purple, nil, nil)