% runge_kutta_recursive.m
function runge_kutta_recursive()
    fprintf('=== Runge-Kutta Method (Recursive) ===\n');
    tic;
    
    % Parameters
    f = @(t, v) 9.8 - 0.2*v;
    t0 = 0;
    v0 = 0;
    h = 2;
    tn = 50;
    
    % Initialize arrays
    n = ceil((tn - t0)/h);
    t = zeros(1, n+1);
    v = zeros(1, n+1);
    t(1) = t0;
    v(1) = v0;
    
    % Recursive Runge-Kutta
    [t, v] = rk2_recursive_func(f, t, v, t0, tn, h, 1);
    
    % Results
    time_taken = toc;
    
    fprintf('Final velocity: %.4f m/s\n', v(end));
    fprintf('Computation time: %.4f seconds\n', time_taken);
    fprintf('Number of steps: %d\n', n);
    
    % Plot results
    figure;
    plot(t, v, 'b-', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Velocity (m/s)');
    title('Velocity of the Ball Over Time (Recursive RK2)');
    grid on;
    
    % Save results
    save("runge_kutta_recursive.mat", "t", "v", "time_taken");
end

function [t, v] = rk2_recursive_func(f, t, v, t_current, t_end, h, step)
    % Base case
    if t_current >= t_end
        return;
    end
    
    % Runge-Kutta 2nd order
    k1 = h * f(t_current, v(step));
    k2 = h * f(t_current + h, v(step) + k1);
    v(step + 1) = v(step) + 0.5 * (k1 + k2);
    t(step + 1) = t_current + h;
    
    fprintf('Step %d: t = %.1f, v = %.4f\n', step, t(step), v(step));
    
    % Recursive call
    [t, v] = rk2_recursive_func(f, t, v, t_current + h, t_end, h, step + 1);
end