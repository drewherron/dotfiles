"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filename: autoload/lightline/colorscheme/aldalome.vim   "
" Author: Drew Herron                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:black = [ '#000000', 0 ]
let s:silver = [ '#c0c0c0', 7 ]
let s:gray = [ '#808080', 8]
let s:yellow = [ '#ffff00', 11 ]
let s:fuchsia = [ '#ff00ff', 13 ]
let s:dfuchsia = [ '#660066', 89 ]
let s:red = [ '#ff0000', 9 ]
let s:dred = [ '#660000', 88 ]
let s:white = [ '#ffffff', 15 ]
let s:P1 = [ '#43e600', 10 ]
let s:dP1 = [ '#2c9900', 22 ]
let s:P3 = [ '#ffb700', 214 ]
let s:dP3 = [ '#b38000', 130 ]
let s:P5 = [ '#3d00ff', 12 ]
let s:dP5 = [ '#240099', 17 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left = [ [ s:black, s:P1 ], [ s:black, s:silver ] ]
let s:p.normal.middle = [ [ s:silver, s:dP1 ] ]
let s:p.normal.right = [ [ s:black, s:P1 ], [ s:silver, s:dP1 ] ]
let s:p.normal.error = [ [ s:black, s:red ] ]
let s:p.normal.warning = [ [ s:black, s:yellow ] ]

let s:p.insert.left = [ [ s:black, s:P3 ], [ s:black, s:silver ] ]
let s:p.insert.middle = [ [ s:silver, s:dP3 ] ]
let s:p.insert.right = [ [ s:black, s:P3 ], [ s:silver, s:dP3 ] ]

let s:p.replace.left = [ [ s:white, s:red ], [ s:black, s:silver ] ]
let s:p.replace.middle = [ [ s:silver, s:dred ] ]
let s:p.replace.right = [ [ s:silver, s:red ], [ s:silver, s:dred ] ]

let s:p.visual.left = [ [ s:black, s:fuchsia ], [ s:black, s:silver ] ]
let s:p.visual.middle = [ [ s:silver, s:dfuchsia ] ]
let s:p.visual.right = [ [ s:black, s:fuchsia ], [ s:silver, s:dfuchsia ] ]

let s:p.inactive.left =  [ [ s:silver, s:gray ], [ s:gray, s:black ] ]
let s:p.inactive.middle = [ [ s:silver, s:black ] ]
let s:p.inactive.right = [ [ s:silver, s:gray ], [ s:gray, s:black ] ]

let s:p.tabline.left = [ [ s:silver, s:black ] ]
let s:p.tabline.tabsel = [ [ s:silver, s:dP1 ] ]
let s:p.tabline.middle = [ [ s:silver, s:black ] ]
let s:p.tabline.right = copy(s:p.normal.right)

let g:lightline#colorscheme#aldalome#palette = lightline#colorscheme#flatten(s:p)
