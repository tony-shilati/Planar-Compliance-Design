function cTableResize(~, ~, fig)

panel = findobj(fig, 'Tag', 'panel');
set(panel, 'Units', 'Pixels');
pSize = get(panel, 'Position');
set(panel, 'Units', 'normalized')
table = findobj(fig, 'Tag', 'table');
jtable = findobj(fig, 'Tag', 'jout');
set(panel, 'Units', 'normalized')

w = 0.255*pSize(3);

w2 = 0.23*pSize(3);

set(table, 'ColumnWidth', {w w w});
set(jtable, 'ColumnWidth', {w2 w2 w2 w2});




end