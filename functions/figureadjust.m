function figureadjust(size)
%figureadjust すでにプロットした図のフォントサイズ・線の太さを調整する
%   Powerpointにサイズを調整して貼り付ける場合に使用する
%   現在使用できるのは，100%と75%，50%のみ

switch size
    case 100
        fontsize = 20;
        linewidth = 2;
        markersize = 10;
    case 75
        fontsize = 28;
        linewidth = 2;
        markersize = 12.5;
    case 50
        fontsize = 34;
        linewidth = 2.5;
        markersize = 15;
    otherwise
        error('サイズとして使用できないものが与えられました．')
end

set(gca, 'FontSize', fontsize)
set(get(gca, 'XLabel'), 'FontSize', fontsize)
set(get(gca, 'YLabel'), 'FontSize', fontsize)
set(get(gca, 'Title'), 'FontSize', fontsize)
set(gca, 'LineWidth', linewidth)
set(get(gca, 'Children'), 'LineWidth', linewidth)
set(get(gca, 'Children'), 'MarkerSize', markersize)
end

