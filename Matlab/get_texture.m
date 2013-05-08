function [ Tex ] = get_texture( Image )

    [cA,cH,cV,cD] = dwt2(Image, 'db1');
    Tex = idwt2(cA*0, cH, cV, cD, 'db1');
    Tex = uint8(wcodemat(Tex, 256));

end