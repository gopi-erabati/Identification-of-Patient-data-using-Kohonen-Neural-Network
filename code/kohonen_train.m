function [weights, clu_control] = kohonen_train( train_data, learn_rate, proj_num )
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %kohonen_train function is used to train the network with the given data
% %   It calculates the synaptic weights depending on the train data
% %   with a given learning rate and following a exp decay learning rate
%
% Inputs
%     train_data          data to train the network
%     learn_rate          initial learn rate
%     proj_num            This variable is only to print proper cluster
%                         for project type and not related to algorithm
%
% Output
%     weights             Synaptic weights after convergence
%     clu_control         this output is to know which cluster is control/patient
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example
% train_data = [1 1 0 0; 0 0 0 1;1 0 0 0; 0 0 1 1];
% learn_rate = 0.9;
% weights = kohonen_train( train_data, learn_rate, 1 );

%% definig  variables required for training
%to make two clusters of train data
cluster = 2;

%learning rate
alpha = learn_rate;

%intial random synaptic weights between (0,1)
weights = rand(size(train_data,2),cluster);

% these variable used to calculate convergence error
weights1 = [];
j=2;

%number of cycles of training
n_iter = 100;

%% training starts
for i = 1:1:n_iter
    for nsub = 1:size(train_data,1)
        
        % to calculate distnaces of node and data
        distance1 = norm(train_data(nsub,:)-weights(:,1)')^2;
        distance2 = norm(train_data(nsub,:)-weights(:,2)')^2;
        
        % to claculate nearest node and update weights accordingly
        if distance1 < distance2
            weights(:,1) = weights(:,1) + alpha*(train_data(nsub,:)' - weights(:,1));
            if nsub == 1
                clu_control = 1;
            end
        else
            weights(:,2) = weights(:,2) + alpha*(train_data(nsub,:)' - weights(:,2));
            if nsub == 1
                clu_control = 2;
            end
        end
    end
    
    %to exp decay learning rate in cycles of training
    alpha = alpha * exp(-i/n_iter);
    
    %% this part of code is to calculate the convergence error
    %and if error is less than certain threshold training cycles stops
    weights1 = [weights1 weights];
    if i ~= 1
        err =  sum(sum(weights1(:,j-1:j) - weights1(:,j+1:j+2))); %to claculate convergence error
        
        % this part of code is to chnage the figure for two projects
        figure(proj_num)
        
        %to plot the error vs iterations
        scatter(i-1,err,'b*')
        xlabel('iterations'),ylabel('weight convergence error')
        title(['weight convergence of project ',num2str(proj_num)]);
        hold on;
        pause(1e-6);
        j = j + 2;
        
        %to check if error is less than a selected low threshold
        if err < 1e-35
            disp(['Synaptic weights converged after ',num2str(i),' iterations']);
            if proj_num == 1
                disp(['The synaptic weights after convergence is',10]);
                disp(weights);
            end
            break;
        end
    end
end



end

