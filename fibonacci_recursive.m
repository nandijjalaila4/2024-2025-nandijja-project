% fibonacci_recursive.m
function fibonacci_recursive()
    fprintf('=== Fibonacci Problem (Recursive) ===\n');
    
    % Test different n values
    n_values = [10, 15, 20, 25, 30];
    times = zeros(size(n_values));
    fib_values = zeros(size(n_values));
    
    for i = 1:length(n_values)
        n = n_values(i);
        
        fprintf('\nCalculating F(%d)...\n', n);
        
        tic;
        fib_val = fibonacci_recursive_func(n);
        time_taken = toc;
        
        times(i) = time_taken;
        fib_values(i) = fib_val;
        
        fprintf('F(%d) = %d\n', n, fib_val);
        fprintf('Computation time: %.6f seconds\n', time_taken);
    end
    
    % Plot results
    figure;
    subplot(1, 2, 1);
    plot(n_values, fib_values, 'ro-', 'LineWidth', 2, 'MarkerSize', 8);
    xlabel('n');
    ylabel('Fibonacci Value');
    title('Fibonacci Values (Recursive)');
    grid on;
    
    subplot(1, 2, 2);
    plot(n_values, times, 'bo-', 'LineWidth', 2, 'MarkerSize', 8);
    xlabel('n');
    ylabel('Time (seconds)');
    title('Computation Time (Recursive)');
    grid on;
    
    % Save results
    save("fibonacci_recursive.mat", "n_values", "times", "fib_values");
end

function fib = fibonacci_recursive_func(n)
    if n <= 1
        fib = n;
    else
        fib = fibonacci_recursive_func(n-1) + fibonacci_recursive_func(n-2);
    end
end