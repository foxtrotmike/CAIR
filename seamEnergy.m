function e = seamEnergy(E,seam)
[rows, ~]=size(E);
e = 0;
for i=1:rows
    e = e+E(i,seam(i));
end
e = e/rows;