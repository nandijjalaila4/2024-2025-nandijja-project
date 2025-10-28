% fibonacci_dp.m
function fibonacci_dp()
    fprintf('=== Fibonacci Problem (Dynamic Programming) ===\n');
    
    % Test different n values
    n_values = [10, 15, 20, 25, 30, 35, 40, 45, 50];
    times = zeros(size(n_values));
    fib_values = zeros(size(n_values));
    
    for i = 1:length(n_values)
        n = n_values(i);
        
        fprintf('\nCalculating F(%d)...\n', n);
        
        tic;
        fib_val = fibonacci_dp_func(n);
        time_taken = toc;
        
        times(i) = time_taken;
        fib_values(i) = fib_val;
        
        fprintf('F(%d) = %d\n', n, fib_val);
        fprintf('Computation time: %.6f seconds\n', time_taken);
    end
    
    % Plot results
    figure;
    subplot(1, 2, 1);
    semilogy(n_values, fib_values, 'ro-', 'LineWidth', 2, 'MarkerSize', 8);
    xlabel('n');
    ylabel('Fibonacci Value (Log Scale)');
    title('Fibonacci Values (DP) - Log Scale');
    grid on;
    
    subplot(1, 2, 2);
    plot(n_values, times, 'bo-', 'LineWidth', 2, 'MarkerSize', 8);
    xlabel('n');
    ylabel('Time (seconds)');
    title('Computation Time (DP)');
    grid on;
    
    % Save results
    save("fibonacci_dp.mat", "n_values", "times", "fib_values");
end

function fib = fibonacci_dp_func(n)
    if n <= 1
        fib = n;
        return;
    end
    
    fib_vals = zeros(1, n+1);
    fib_vals(1) = 0;
    fib_vals(2) = 1;
    
    for i = 3:n+1
        fib_vals(i) = fib_vals(i-1) + fib_vals(i-2);
    end
    
    fib = fib_vals(n+1);
end