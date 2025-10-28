% knapsack_dp.m
function knapsack_dp()
    fprintf('=== Knapsack Problem (Dynamic Programming) ===\n');
    
    % Test cases of different sizes
    test_cases = {
        {[2, 3, 4, 5], [3, 4, 5, 6], 5, 'Small'},
        {[1, 3, 4, 5, 2], [1, 4, 5, 7, 3], 8, 'Medium'},
        {[2, 1, 3, 4, 2, 5], [3, 2, 4, 5, 3, 6], 10, 'Large'}
    };
    
    times = zeros(length(test_cases), 1);
    max_values = zeros(length(test_cases), 1);
    
    for i = 1:length(test_cases)
        weights = test_cases{i}{1};
        values = test_cases{i}{2};
        capacity = test_cases{i}{3};
        case_name = test_cases{i}{4};
        
        fprintf('\n%s Test Case:\n', case_name);
        fprintf('Weights: '); fprintf('%d ', weights); fprintf('\n');
        fprintf('Values: '); fprintf('%d ', values); fprintf('\n');
        fprintf('Capacity: %d\n', capacity);
        
        tic;
        max_val = knapsack_dp_func(weights, values, capacity);
        time_taken = toc;
        
        times(i) = time_taken;
        max_values(i) = max_val;
        
        fprintf('Maximum value: %d\n', max_val);
        fprintf('Computation time: %.6f seconds\n', time_taken);
    end
    
    % Plot results
    figure;
    subplot(1, 2, 1);
    bar(max_values);
    set(gca, 'XTickLabel', {'Small', 'Medium', 'Large'});
    ylabel('Maximum Value');
    title('Knapsack - Maximum Values');
    grid on;
    
    subplot(1, 2, 2);
    bar(times);
    set(gca, 'XTickLabel', {'Small', 'Medium', 'Large'});
    ylabel('Time (seconds)');
    title('Knapsack - Computation Time (DP)');
    grid on;
    
    % Save results
    save("knapsack_dp.mat", "times", "max_values", "test_cases");
end

function max_value = knapsack_dp_func(weights, values, capacity)
    n = length(weights);
    % Create DP table
    dp = zeros(n+1, capacity+1);
    
    for i = 1:n+1
        for w = 1:capacity+1
            if i == 1 || w == 1
                dp(i, w) = 0;
            elseif weights(i-1) <= w-1
                dp(i, w) = max(values(i-1) + dp(i-1, w-weights(i-1)), dp(i-1, w));
            else
                dp(i, w) = dp(i-1, w);
            end
        end
    end
    
    max_value = dp(n+1, capacity+1);
end