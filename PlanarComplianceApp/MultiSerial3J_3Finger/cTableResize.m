function cTableResize(~, ~, fig)

panel = findobj(fig, 'Tag', 'hp');
panelout = findobj(fig, 'Tag', 'hpout');

set(panel, 'Units', 'Pixels');
set(panelout, 'Units', 'Pixels');

pSize = get(panel, 'Position');
pSizeout = get(panelout, 'Position');

table = findobj(fig, 'Tag', 'table');
tableout = findobj(fig, 'Tag', 'Kout');
jtable1 = findobj(fig, 'Tag', 'jout1');
jtable2 = findobj(fig, 'Tag', 'jout2');
jtable3 = findobj(fig, 'Tag', 'jout3');
ctable1 = findobj(fig, 'Tag', 'cout1');

set(panel, 'Units', 'normalized')
set(panelout, 'Units', 'normalized')

w = 0.255*pSize(3);
w2 = 0.255*pSizeout(3);
w3 = 0.259*pSizeout(3);
w4 = 0.185*pSizeout(3);
w5 = 0.205*pSizeout(3);



set(table, 'ColumnWidth', {w w w});
set(tableout, 'ColumnWidth', {w2 w2 w2});
set(jtable1, 'ColumnWidth', {w4 w4 w4 w4});
set(jtable2, 'ColumnWidth', {w3 w3 w3});
set(jtable3, 'ColumnWidth', {w3 w3 w3});
set(ctable1, 'ColumnWidth', {w5 w5 w5});



end