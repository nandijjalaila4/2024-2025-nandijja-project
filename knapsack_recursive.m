% knapsack_recursive.m
function knapsack_recursive()
    fprintf('=== Knapsack Problem (Recursive) ===\n');
    
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
        max_val = knapsack_recursive_func(weights, values, capacity, length(weights));
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
    title('Knapsack - Computation Time (Recursive)');
    grid on;
    
    % Save results
    save("knapsack_recursive.mat", "times", "max_values", "test_cases");
end

function max_value = knapsack_recursive_func(weights, values, capacity, n)
    % Base case
    if n == 0 || capacity == 0
        max_value = 0;
        return;
    end
    
    % If weight of nth item is more than capacity, skip it
    if weights(n) > capacity
        max_value = knapsack_recursive_func(weights, values, capacity, n-1);
        return;
    end
    
    % Return maximum of two cases:
    % (1) nth item included
    % (2) nth item not included
    include = values(n) + knapsack_recursive_func(weights, values, capacity - weights(n), n-1);
    exclude = knapsack_recursive_func(weights, values, capacity, n-1);
    
    max_value = max(include, exclude);
end