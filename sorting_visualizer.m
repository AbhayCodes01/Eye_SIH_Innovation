%% ============================================================
%  SORTING ALGORITHM PERFORMANCE ANALYZER & VISUALIZER
%  Topic: Algorithm Analysis using MATLAB
%  Algorithms: Bubble Sort, Selection Sort, Insertion Sort,
%              Merge Sort, Quick Sort
%% ============================================================

clc;
clear all;
close all;

%% -----------------------------------------------------------
%  STEP 1: Define input sizes to test
%% -----------------------------------------------------------
input_sizes = [50, 100, 200, 500, 1000, 2000];
num_sizes   = length(input_sizes);

% Store time results
time_bubble    = zeros(1, num_sizes);
time_selection = zeros(1, num_sizes);
time_insertion = zeros(1, num_sizes);
time_merge     = zeros(1, num_sizes);
time_quick     = zeros(1, num_sizes);

fprintf('Running sorting algorithms... please wait.\n\n');
fprintf('%-10s %-12s %-12s %-12s %-12s %-12s\n', ...
    'Size', 'Bubble', 'Selection', 'Insertion', 'Merge', 'Quick');
fprintf('%s\n', repmat('-', 1, 70));

%% -----------------------------------------------------------
%  STEP 2: Time each algorithm across all input sizes
%% -----------------------------------------------------------
for i = 1:num_sizes
    n   = input_sizes(i);
    arr = randperm(n);  % Random permutation of 1..n

    % Bubble Sort
    t = tic;
    bubbleSort(arr);
    time_bubble(i) = toc(t);

    % Selection Sort
    t = tic;
    selectionSort(arr);
    time_selection(i) = toc(t);

    % Insertion Sort
    t = tic;
    insertionSort(arr);
    time_insertion(i) = toc(t);

    % Merge Sort
    t = tic;
    mergeSort(arr);
    time_merge(i) = toc(t);

    % Quick Sort
    t = tic;
    quickSort(arr, 1, length(arr));
    time_quick(i) = toc(t);

    fprintf('%-10d %-12.5f %-12.5f %-12.5f %-12.5f %-12.5f\n', ...
        n, time_bubble(i), time_selection(i), time_insertion(i), ...
        time_merge(i), time_quick(i));
end

%% -----------------------------------------------------------
%  STEP 3: Plot Time Comparison
%% -----------------------------------------------------------
figure('Name','Sorting Algorithm Comparison','NumberTitle','off','Position',[100 100 1200 800]);

subplot(2,2,1);
plot(input_sizes, time_bubble,    '-o', 'LineWidth', 2, 'Color', [0.85 0.33 0.10], 'MarkerFaceColor', [0.85 0.33 0.10]);
hold on;
plot(input_sizes, time_selection, '-s', 'LineWidth', 2, 'Color', [0.47 0.67 0.19], 'MarkerFaceColor', [0.47 0.67 0.19]);
plot(input_sizes, time_insertion, '-^', 'LineWidth', 2, 'Color', [0.00 0.45 0.74], 'MarkerFaceColor', [0.00 0.45 0.74]);
plot(input_sizes, time_merge,     '-d', 'LineWidth', 2, 'Color', [0.63 0.08 0.18], 'MarkerFaceColor', [0.63 0.08 0.18]);
plot(input_sizes, time_quick,     '-p', 'LineWidth', 2, 'Color', [0.49 0.18 0.56], 'MarkerFaceColor', [0.49 0.18 0.56]);
hold off;
xlabel('Input Size (n)'); ylabel('Time (seconds)');
title('All Algorithms - Time vs Input Size','FontWeight','bold');
legend('Bubble','Selection','Insertion','Merge','Quick','Location','northwest');
grid on;

subplot(2,2,2);
bar_data = [time_bubble; time_selection; time_insertion; time_merge; time_quick]';
bar(input_sizes, bar_data);
xlabel('Input Size (n)'); ylabel('Time (seconds)');
title('Grouped Bar Chart Comparison','FontWeight','bold');
legend('Bubble','Selection','Insertion','Merge','Quick','Location','northwest');
grid on;

subplot(2,2,3);
plot(input_sizes, time_merge, '-d', 'LineWidth', 2.5, 'Color', [0.63 0.08 0.18], 'MarkerFaceColor', [0.63 0.08 0.18]);
hold on;
plot(input_sizes, time_quick, '-p', 'LineWidth', 2.5, 'Color', [0.49 0.18 0.56], 'MarkerFaceColor', [0.49 0.18 0.56]);
hold off;
xlabel('Input Size (n)'); ylabel('Time (seconds)');
title('Efficient Algorithms: Merge vs Quick Sort','FontWeight','bold');
legend('Merge Sort','Quick Sort','Location','northwest');
grid on;

subplot(2,2,4);
final_times = [time_bubble(end), time_selection(end), time_insertion(end), time_merge(end), time_quick(end)];
algo_names  = {'Bubble','Selection','Insertion','Merge','Quick'};
colors = [0.85 0.33 0.10; 0.47 0.67 0.19; 0.00 0.45 0.74; 0.63 0.08 0.18; 0.49 0.18 0.56];
b = bar(final_times, 'FaceColor', 'flat');
b.CData = colors;
set(gca, 'XTickLabel', algo_names);
ylabel('Time (seconds)');
title(sprintf('Final Comparison at n = %d', input_sizes(end)),'FontWeight','bold');
grid on;

sgtitle('Sorting Algorithm Visualizer — Performance Analysis', ...
    'FontSize', 14, 'FontWeight', 'bold');

%% -----------------------------------------------------------
%  STEP 4: Summary in Command Window
%% -----------------------------------------------------------
fprintf('\n========== FINAL RESULTS AT n = %d ==========\n', input_sizes(end));
fprintf('Bubble Sort    : %.5f sec\n', time_bubble(end));
fprintf('Selection Sort : %.5f sec\n', time_selection(end));
fprintf('Insertion Sort : %.5f sec\n', time_insertion(end));
fprintf('Merge Sort     : %.5f sec\n', time_merge(end));
fprintf('Quick Sort     : %.5f sec\n', time_quick(end));

[~, idx] = min(final_times);
fprintf('\n>>> Fastest Algorithm: %s Sort\n', algo_names{idx});
fprintf('==============================================\n');

disp('Done! All algorithms compared successfully.');

%% -----------------------------------------------------------
%%  LOCAL FUNCTIONS — All sorting algorithms below
%% -----------------------------------------------------------

function arr = bubbleSort(arr)
    n = length(arr);
    for i = 1:n-1
        for j = 1:n-i
            if arr(j) > arr(j+1)
                temp     = arr(j);
                arr(j)   = arr(j+1);
                arr(j+1) = temp;
            end
        end
    end
end

function arr = selectionSort(arr)
    n = length(arr);
    for i = 1:n-1
        min_idx = i;
        for j = i+1:n
            if arr(j) < arr(min_idx)
                min_idx = j;
            end
        end
        temp         = arr(i);
        arr(i)       = arr(min_idx);
        arr(min_idx) = temp;
    end
end

function arr = insertionSort(arr)
    n = length(arr);
    for i = 2:n
        key = arr(i);
        j   = i - 1;
        while j >= 1 && arr(j) > key
            arr(j+1) = arr(j);
            j = j - 1;
        end
        arr(j+1) = key;
    end
end

function arr = mergeSort(arr)
    if length(arr) <= 1
        return;
    end
    mid   = floor(length(arr)/2);
    left  = mergeSort(arr(1:mid));
    right = mergeSort(arr(mid+1:end));
    arr   = merge(left, right);
end

function result = merge(left, right)
    result = [];
    i = 1; j = 1;
    while i <= length(left) && j <= length(right)
        if left(i) <= right(j)
            result(end+1) = left(i);  i = i + 1;
        else
            result(end+1) = right(j); j = j + 1;
        end
    end
    result = [result, left(i:end), right(j:end)];
end

function arr = quickSort(arr, low, high)
    if low < high
        [arr, pi] = partition(arr, low, high);
        arr = quickSort(arr, low, pi-1);
        arr = quickSort(arr, pi+1, high);
    end
end

function [arr, pi] = partition(arr, low, high)
    pivot = arr(high);
    i     = low - 1;
    for j = low:high-1
        if arr(j) <= pivot
            i        = i + 1;
            temp     = arr(i);
            arr(i)   = arr(j);
            arr(j)   = temp;
        end
    end
    temp       = arr(i+1);
    arr(i+1)   = arr(high);
    arr(high)  = temp;
    pi         = i + 1;
end
