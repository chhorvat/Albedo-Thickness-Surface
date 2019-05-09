function add_bg_hatch 

cmap = get(gcf,'colormap');

xl = get(gca,'xlim'); 
yl = get(gca,'ylim'); 

xval = linspace(xl(1),xl(end),100); 
yval = linspace(yl(1),yl(end),100);

x = [xval xval(end) + 0*yval fliplr(xval) xval(1) + 0*yval];
y = [yval(1) + 0*xval yval yval(end) + 0*xval fliplr(yval)];
hp = patch(x,y,'r','facecolor','none','EdgeColor',cmap(1,:)); 
h2 = hatchfill2(hp,'cross','HatchSpacing',4,'EdgeColor',[.4 .4 .4],'HatchLineWidth',.125);
uistack(hp,'bottom'); 
uistack(h2,'bottom'); 

end
