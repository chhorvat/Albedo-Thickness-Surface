function scatter_CESM_data(forced_x,forced_y,control_x,control_y,months)


%%
scatter(forced_x,forced_y,'b')
hold on


plot(area,Fswabs,'r.'); xlabel('area'); ylabel('Fswabs')
hold; plot(area(1),Fswabs(1),'.'); hold

end