function cTableResize(~, ~, fig)

panel = findobj(fig, 'Tag', 'hp');
set(panel, 'Units', 'Pixels');
pSize = get(panel, 'Position');
table = findobj(fig, 'Tag', 'table');
set(panel, 'Units', 'normalized')

w = 0.255*pSize(3);

set(table, 'ColumnWidth', {w w w});


end