function figureadjust(size)
%figureadjust ���łɃv���b�g�����}�̃t�H���g�T�C�Y�E���̑����𒲐�����
%   Powerpoint�ɃT�C�Y�𒲐����ē\��t����ꍇ�Ɏg�p����
%   ���ݎg�p�ł���̂́C100%��75%�C50%�̂�

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
        error('�T�C�Y�Ƃ��Ďg�p�ł��Ȃ����̂��^�����܂����D')
end

set(gca, 'FontSize', fontsize)
set(get(gca, 'XLabel'), 'FontSize', fontsize)
set(get(gca, 'YLabel'), 'FontSize', fontsize)
set(get(gca, 'Title'), 'FontSize', fontsize)
set(gca, 'LineWidth', linewidth)
set(get(gca, 'Children'), 'LineWidth', linewidth)
set(get(gca, 'Children'), 'MarkerSize', markersize)
end

