function [X_vec,Y_vec,vq,Nper] = make_grid_pcolor(x,y,z,varargin)

if ~isempty(varargin)
    dx = varargin{1};
    dy = varargin{2};
    
    X_vec = floor(min(x(:))):dx:ceil(max(x(:)));
    Y_vec = floor(min(y(:))):dy:ceil(max(y(:)));
    
else
    
    
    X_vec = linspace(floor(min(x)),ceil(max(x)),25);
    Y_vec = linspace(floor(min(y)),ceil(max(y)),26);
    
    
end
%% 
vq = griddata(x,y,z,X_vec',Y_vec);
% X_vec is 1 by n
% Y_vec is 1 by m
% vq is m by n
% So we plot pcolor(X_vec,Y_vec,vq)

% vals are the reported values
% x and y are NUM by 1 each
vals = [x y];
% These are the edges of each grid respectively. 
ctrs = {X_vec,Y_vec};

% hist3 returns n by m, so we have to transpose it
Nper = hist3(vals,ctrs)'; 





end