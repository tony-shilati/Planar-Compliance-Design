function cTableResize(~, ~, fig)

panel = findobj(fig, 'Tag', 'hp');
panelout = findobj(fig, 'Tag', 'hpout');

set(panel, 'Units', 'Pixels');
set(panelout, 'Units', 'Pixels');

pSize = get(panel, 'Position');
pSizeout = get(panelout, 'Position');

table = findobj(fig, 'Tag', 'table');
tableout = findobj(fig, 'Tag', 'Kout');

set(panel, 'Units', 'normalized')
set(panelout, 'Units', 'normalized')

w = 0.255*pSize(3);
w2 = 0.255*pSizeout(3);

set(table, 'ColumnWidth', {w w w});
set(tableout, 'ColumnWidth', {w2 w2 w2});


end