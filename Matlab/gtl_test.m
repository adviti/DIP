clear all
close all
clc

I = imread('../ornus/1505.jpg');
I = rgb2gray(I);
figure;
imshow(I);
axis equal

Tex = get_texture_lev(I, 1);
figure
imshow(uint8(wcodemat(Tex, 255)))