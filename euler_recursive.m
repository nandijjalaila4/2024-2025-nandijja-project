% euler_recursive.m
function euler_recursive()
    fprintf('=== Euler Method (Recursive) ===\n');
    
    % Parameters
    m = 1;              % mass of the ball (kg)
    g = 9.8;            % gravitational acceleration (m/s^2)
    k = 0.2;            % drag coefficient
    dt = 0.1;           % time step (s)
    t_end = 10;         % total time (s)
    
    % Initialization
    t0 = 0;             % initial time
    v0 = 0;             % initial velocity
    
    % Calculate number of steps
    num_steps = ceil(t_end / dt);
    t = zeros(1, num_steps + 1);
    v = zeros(1, num_steps + 1);
    t(1) = t0;
    v(1) = v0;
    
    fprintf('Parameters:\n');
    fprintf('Mass: %.1f kg\n', m);
    fprintf('Gravity: %.1f m/s²\n', g);
    fprintf('Drag coefficient: %.1f\n', k);
    fprintf('Time step: %.1f s\n', dt);
    fprintf('Total time: %.1f s\n', t_end);
    fprintf('Number of steps: %d\n', num_steps);
    
    % Start timing
    tic;
    
    % Recursive Euler method
    [t, v] = euler_recursive_func(m, g, k, dt, t, v, t0, t_end, 1);
    
    % Stop timing
    computation_time = toc;
    
    % Display results
    fprintf('\nResults:\n');
    fprintf('Final velocity: %.4f m/s\n', v(end));
    fprintf('Computation time: %.4f seconds\n', computation_time);
    fprintf('Number of steps: %d\n', num_steps);
    
    % Plotting the results
    figure;
    plot(t, v, 'b-', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Velocity (m/s)');
    title('Velocity of the Ball Over Time (Recursive Euler Method)');
    grid on;
    
    % Add analytical solution for comparison
    hold on;
    v_analytical = (g/k) * (1 - exp(-k*t));
    plot(t, v_analytical, 'r--', 'LineWidth', 1.5);
    legend('Euler Method', 'Analytical Solution', 'Location', 'southeast');
    
    % Calculate and display error
    final_error = abs(v(end) - v_analytical(end));
    fprintf('Final velocity error: %.6f m/s\n', final_error);
    
    % Close extra figures if more than 10 are open
    figHandles = findobj('Type', 'figure');
    if length(figHandles) > 10
        close(figHandles(1:end-10));
    end
    
    % Save results
    save("euler_recursive.mat", "t", "v", "computation_time", "num_steps", "final_error");
end

function [t, v] = euler_recursive_func(m, g, k, dt, t, v, current_time, t_end, step)
    % Base case: if current time exceeds end time, return
    if current_time >= t_end
        return;
    end
    
    % Calculate next time step
    next_time = current_time + dt;
    
    % Euler method step
    dvdt = g - k * v(step);  % compute the derivative
    v(step + 1) = v(step) + dvdt * dt;  % update velocity
    t(step + 1) = next_time;  % update time
    
    % Display progress for first few steps
    if step <= 5
        fprintf('Step %d: t = %.1f s, v = %.4f m/s\n', step, t(step), v(step));
    elseif step == 6
        fprintf('...\n');
    end
    
    % Recursive call for next step
    [t, v] = euler_recursive_func(m, g, k, dt, t, v, next_time, t_end, step + 1);
end