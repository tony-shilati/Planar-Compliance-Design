function [ xmin,xmax ] = getP4Limits( ax )

L1 = makeFuncFromLine('L1',ax);
L2 = makeFuncFromLine('L2',ax);
L3 =makeFuncFromLine('L3',ax);

P23 = @(x) L3(x) - L2(x);
P13 = @(x) L1(x) - L3(x);

[x1,~] = fzero(P23,0);
[x2,~] = fzero(P13,0);

xmin = min(x1,x2);
xmax = max(x1,x2);



end

