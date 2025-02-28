function cTableResize(~, ~, fig)

panel = findobj(fig, 'Tag', 'panel');
set(panel, 'Units', 'Pixels');
pSize = get(panel, 'Position');
table = findobj(fig, 'Tag', 'table');
jtable = findobj(fig, 'Tag', 'jout');
set(panel, 'Units', 'normalized')

w = 0.25*pSize(3);

w2 = 0.15*pSize(3);

set(table, 'ColumnWidth', {w w w});
set(jtable, 'ColumnWidth', {w2 w2 w2 w2 w2});




end