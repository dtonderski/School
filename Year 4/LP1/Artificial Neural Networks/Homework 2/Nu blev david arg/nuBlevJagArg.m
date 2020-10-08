%%
k = 4;
combinations = nchoosek(1:8, k);
for i = 1:size(combinations, 1)
    clf
    drawCube;
    view([-37.5 -30]);
    template = ones(1+0, 8);
    template(combinations(i,:)) = 0;
    drawPoints(template);
    waitforbuttonpress
end
%%
clf
drawPoints([0,1,1,1,1,1,1,0])
drawCube;
text(1+0,0+0,1+0.1,'1','Color','red','FontSize',16)
text(0+0,0+0,1+0.1,'2','Color','red','FontSize',16)
text(0+0,0+0,0+0.1,'3','Color','red','FontSize',16)    
text(1+0,0+0,0+0.1,'4','Color','red','FontSize',16)
text(1+0,1+0,1+0.1,'5','Color','red','FontSize',16)
text(0+0,1+0,1+0.1,'6','Color','red','FontSize',16)
text(0+0,1+0,0+0.1,'7','Color','red','FontSize',16)
text(1+0,1+0,0+0.1                                              ,'8','Color','red','FontSize',16)
view([25,25])
xlabel('x')
ylabel('y')
zlabel('z')