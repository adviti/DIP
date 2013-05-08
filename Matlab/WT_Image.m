clear all
close all
clc

I = imread('../ornus/1505.jpg');
I = rgb2gray(I);
figure;
image(wcodemat(I, 256));
axis equal

[cA,cH,cV,cD] = dwt2(I, 'db1');
figure
subplot(2, 2, 1)
image(uint8(wcodemat(cA,256)))
axis equal
subplot(2, 2, 2)
image(uint8(wcodemat(cH,256)))
axis equal
subplot(2, 2, 3)
image(uint8(wcodemat(cV,256)))
axis equal
subplot(2, 2, 4)
image(uint8(wcodemat(cD,256)))
axis equal

ImageHF = idwt2(cA*0, cH, cV, cD, 'db1');
figure
image(uint8(wcodemat(ImageHF, 256)))
axis equal
