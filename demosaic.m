clear; close all;

img=imread("photo.jpg");

%% Define RGB color
R=1; G=2; B=3; 

figure(1);
imshow(img);


%% The X-Trans pattern matrix 6x6
D=[ G B R G R B
    R G G B G G 
    B G G R G G 
    G R B G B R
    B G G R G G 
    R G G B G G];

%% The beyer pattern matrix 2x2
%D=[G R
 %  B G];

k = 6;

Red=not(D(:,:) ~=R);
Green=not(D(:,:) ~=G);
Blue=not(D(:,:) ~=B);

imR=img(:,:,1);
imG=img(:,:,2);
imB=img(:,:,3);

%% RED channel
for i=0:k:length(imR) -1
    for j=0:k:length(imR) -1
        for x=1:k
            for y=1:k
                imR(x+i,y+j)=double(imR(x+i,y+j))*Red(x,y);
            end
        end
    end
end

%% GREEN channel
for i=0:k:length(imR) -1
    for j=0:k:length(imR) -1
        for x=1:k
            for y=1:k
                imG(x+i,y+j)=double(imG(x+i,y+j))*Green(x,y);
            end
        end
    end
end

%% BLUE channel
for i=0:k:length(imB) -1
    for j=0:k:length(imB) -1
        for x=1:k
            for y=1:k
                imB(x+i,y+j)=double(imB(x+i,y+j))*Blue(x,y);
            end
        end
    end
end

il(:,:,1)=imR;
il(:,:,2)=imG;
il(:,:,3)=imB;
imshow(il);

% 3x3 martix
%{
R2 = [0.25 0.5 0.25;
     0.5  1   0.5;
     0.25 0.5 0.25];
 
B2 = [0.25 0.5 0.25;
     0.5  1   0.5;
     0.25 0.5 0.25];
 
G2 = [0    0.25 0;
     0.25 1    0.25;
     0    0.25 0];
%}

% 6x6 matrix
R2 = [0, 0,    0,   0,   0,    0;
     0, 0.25, 0.5, 0.5, 0.25, 0;
     0, 0.5,  1.0, 1.0, 0.5,  0;
     0, 0.5,  1.0, 1.0, 0.5,  0;
     0, 0.25, 0.5, 0.5, 0.25, 0;
     0, 0,    0,   0,   0,    0] .* 1/2;

G2 = [0, 0,    0,   0,   0,    0;
     0, 0.25, 0.5, 0.5, 0.25, 0;
     0, 0.5,  1.0, 1.0, 0.5,  0;
     0, 0.5,  1.0, 1.0, 0.5,  0;
     0, 0.25, 0.5, 0.5, 0.25, 0;
     0, 0,    0,   0,   0,    0] .* 1/5;

B2 = [0, 0,    0,   0,   0,    0;
     0, 0.25, 0.5, 0.5, 0.25, 0;
     0, 0.5,  1.0, 1.0, 0.5,  0;
     0, 0.5,  1.0, 1.0, 0.5,  0;
     0, 0.25, 0.5, 0.5, 0.25, 0;
     0, 0,    0,   0,   0,    0] .* 1/2;

[M, N, L] = size(il);

mR = zeros(M,N,3,'uint8');
mG = zeros(M,N,3,'uint8');
mB = zeros(M,N,3,'uint8');

%mR(:, :, 1)= Z(:, :, 1);
mR(: ,:, 1) = imfilter(il(:, :, 1), R2);
figure(3)
imshow(mR); 

%mG(:, : ,2)=Z(:, :, 2);
mG(:, :, 2) = imfilter(il(:, :, 2), G2);
figure(4)
imshow(mG); 

%mB(:, :, 3)=Z(:, :, 3);
mB(:, : ,3) = imfilter(il(:, : ,3), B2);
figure(5)
imshow(mB); 

%% The final image after demosaicing
figure(6)
imshow(mR + mB + mG); 