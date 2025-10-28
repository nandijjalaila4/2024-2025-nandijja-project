% fixed_point_recursive.m
function fixed_point_recursive()
    fprintf('=== Fixed Point Iteration (Recursive) ===\n');
    tic;
    
    % Parameters
    f = @(x) x^3 - x - 2;
    g = @(x) (x+2)^(1/3);
    x0 = 1;
    err = 5e-4;
    max_iter = 100;
    
    % Recursive fixed point
    x = fixed_point_recursive_func(g, x0, err, max_iter, 1);
    
    % Results
    time_taken = toc;
    xref = fzero(f, 1.6);
    
    fprintf('Root: %.4f\n', x);
    fprintf('Reference root: %.4f\n', xref);
    fprintf('Computation time: %.4f seconds\n', time_taken);
    fprintf('Error: %.6f\n', abs(x - xref));
    
    % Save results
    save("fixed_point_recursive.mat", "x", "time_taken", "xref");
end

function x = fixed_point_recursive_func(g, x, err, max_iter, iter)
    % Check maximum iterations
    if iter > max_iter
        warning('Maximum iterations reached');
        x = NaN;
        return;
    end
    
    % Fixed point iteration
    x_new = g(x);
    fprintf('Iteration %d: x = %.4f\n', iter, x_new);
    
    % Check convergence
    if abs(x_new - x) < err
        x = x_new;
    else
        x = fixed_point_recursive_func(g, x_new, err, max_iter, iter + 1);
    end
end