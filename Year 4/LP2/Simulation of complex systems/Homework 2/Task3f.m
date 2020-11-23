clear
a = ['a','b','c', 'e','d','a'];
for i = 1:6
    fig(i) = openfig(sprintf('3%s.fig', a(i)));
end
%%
new_fig = figure;
ax_new = gobjects(size(fig));

for i = 1:6
    disp(i)
    ax = subplot(2,3,i);
    ax_old = findobj(fig(i), 'type', 'axes');
    ax_new(i) = copyobj(ax_old, new_fig);
    ax_new(i).YLimMode = 'manual';
    ax_new(i).Position = ax.Position;
    ax_new(i).Position(4) = ax_new(i).Position(4)-0.02;
    delete(ax);
    legend('Simulation data', 'Linear fit', 'interpreter', 'latex')
end
