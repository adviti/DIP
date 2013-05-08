function [ Tex ] = get_texture_lev( I, lev )

    [C, S] = wavedec2(I, lev, 'db1');
    M = S(1, 1);
    N = S(1, 2);
    C(1:(M*N)) = 0;
    
    Tex = waverec2(C, S, 'db1');
end