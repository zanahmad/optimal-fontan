function mean_values = compute_mean(T, dt, t_plot, timeseries)

	 [m ~] = size(timeseries); 
	 mean_values = zeros(m,1);
	 ind = find((t_plot(end)-3*T) < t_plot & t_plot < t_plot(end));
	 mean_values = (dt/(3*T)).*sum(timeseries(:,ind), 2);

end