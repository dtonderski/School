load('edgeData.mat')
k_array = [4:9];
N_box_array = zeros(length(k_array),1);

for i = 1:length(k_array)
    k = k_array(i);
    epsilon = 1/2^k;
    box_data = zeros(1/epsilon);

    for i_box_x = 1:size(box_data,1)
        i_edge_data_x_start = ceil((i_box_x-1)*epsilon*512+1);
        i_edge_data_x_stop = ceil(i_box_x*epsilon*512);
        %fprintf('start is %d, stop is %d\n', i_edge_data_x_start, i_edge_data_x_stop)
        for i_box_y = 1:size(box_data,1)
            i_edge_data_y_start = ceil((i_box_y-1)*epsilon*512+1);
            i_edge_data_y_stop = ceil(i_box_y*epsilon*512);
            if any(any(edgeData(i_edge_data_x_start:i_edge_data_x_stop, i_edge_data_y_start:i_edge_data_y_stop) == 1))
                box_data(i_box_x, i_box_y) = 1;
            end
        end
    end
    N_box_array(i) = sum(sum(box_data));
end