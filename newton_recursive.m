% newton_recursive.m
function newton_recursive()
    fprintf('=== Newton-Raphson Method (Recursive) ===\n');
    tic;
    
    % Parameters
    f = @(x) x^3 - x - 2;
    df = @(x) 3*x^2 - 1;
    x0 = 2;
    err = 5e-4;
    max_iter = 100;
    
    % Recursive Newton-Raphson
    x = newton_recursive_func(f, df, x0, err, max_iter, 1);
    
    % Results
    time_taken = toc;
    xref = fzero(f, 1.6);
    
    fprintf('Root: %.4f\n', x);
    fprintf('Reference root: %.4f\n', xref);
    fprintf('Computation time: %.4f seconds\n', time_taken);
    fprintf('Error: %.6f\n', abs(x - xref));
    
    % Save results
    save("newton_recursive.mat", "x", "time_taken", "xref");
end

function x = newton_recursive_func(f, df, x, err, max_iter, iter)
    % Check maximum iterations
    if iter > max_iter
        warning('Maximum iterations reached');
        x = NaN;
        return;
    end
    
    % Newton-Raphson iteration
    x_new = x - f(x)/df(x);
    fprintf('Iteration %d: x = %.4f\n', iter, x_new);
    
    % Check convergence
    if abs(x_new - x) < err
        x = x_new;
    else
        x = newton_recursive_func(f, df, x_new, err, max_iter, iter + 1);
    end
end