% bisection_recursive.m
function bisection_recursive()
    fprintf('=== Bisection Method (Recursive) ===\n');
    tic;
    
    % Parameters
    f = @(x) x^3 - x - 2;
    a = 1;
    b = 2;
    err = 5e-4;
    
    % Recursive bisection
    x = bisection_recursive_func(f, a, b, err);
    
    % Results
    time_taken = toc;
    xref = fzero(f, 1.6);
    
    fprintf('Root: %.4f\n', x);
    fprintf('Reference root: %.4f\n', xref);
    fprintf('Computation time: %.4f seconds\n', time_taken);
    fprintf('Error: %.6f\n', abs(x - xref));
    
    % Save results
    save("bisection_recursive.mat", "x", "time_taken", "xref");
end

function x = bisection_recursive_func(f, a, b, err)
    c = (a + b) / 2;
    
    % Base case
    if (b - a) <= err
        x = c;
        return;
    end
    
    % Recursive case
    if f(a) * f(c) < 0
        x = bisection_recursive_func(f, a, c, err);
    else
        x = bisection_recursive_func(f, c, b, err);
    end
end