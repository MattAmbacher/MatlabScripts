% set the image size to 15 cm wide and 10 cm tall.
width = 17; length = 8;
set(gcf, 'PaperPositionMode','manual');
set(gcf, 'Units','centimeters'); % for example
pos = get(gcf,'Position');
set(gcf, 'Position',[pos(1) pos(2) width length]);
print(gcf,'-depsc', '-r500', 'initialVelVort.eps');
% size on paper will mirror size on screen
% be aware that if you change the size on screen, then the
% size on paper will change too.