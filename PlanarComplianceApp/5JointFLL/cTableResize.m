function cTableResize(~, ~, fig)

panel = findobj(fig, 'Tag', 'panel');
set(panel, 'Units', 'Pixels');
pSize = get(panel, 'Position');
set(panel, 'Units', 'normalized')
table = findobj(fig, 'Tag', 'table');
jtable1 = findobj(fig, 'Tag', 'jout1');
jtable2 = findobj(fig, 'Tag', 'jout2');

set(panel, 'Units', 'normalized')

w = 0.255*pSize(3);

w2 = 0.17*pSize(3);

w3 = 0.255*pSize(3);

set(table, 'ColumnWidth', {w w w});
set(jtable1, 'ColumnWidth', {w2 w2 w2});
set(jtable2, 'ColumnWidth', {w3 w3 w3});




end