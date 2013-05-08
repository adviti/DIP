clear all
close all
clc

I = imread('../ornus/1505.jpg');
I = rgb2gray(I);
figure;
imshow(I);
axis equal

[C, S] = wavedec2(I, 5, 'db1');

cA = appcoef2(C, S, 'db1', 5);
cH = detcoef2('h', C, S, 5);
cV = detcoef2('v', C, S, 5);
cD = detcoef2('d', C, S, 5);

figure
subplot(2, 2, 1)
imshow(uint8(wcodemat(cA,256)))
axis equal
subplot(2, 2, 2)
imshow(uint8(wcodemat(cH,256)))
axis equal
subplot(2, 2, 3)
imshow(uint8(wcodemat(cV,256)))
axis equal
subplot(2, 2, 4)
imshow(uint8(wcodemat(cD,256)))
axis equal