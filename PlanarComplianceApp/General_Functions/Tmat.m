function [T] = Tmat(Xshift, Yshift, theta_d)

T = [cosd(theta_d), sind(theta_d), -Yshift;
    -sind(theta_d), cosd(theta_d),  Xshift;
    0, 0, 1];

end