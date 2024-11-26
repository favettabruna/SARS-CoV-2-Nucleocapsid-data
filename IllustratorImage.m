clc

%Upload image
A = ReadImage6D('20230803 8 uM rgg-rgg imc1.czi');
metadata = A{2};
image6d = A{1}; 

% Create grayscale image
Image = image6d(1,1,1,1,:,:);
Image = squeeze(Image);
Image = mat2gray(Image,[1 65536]);
%65536

Im = im2double(Image);
Im = mat2gray(Im, [0 1]);

figure;
imshow(Im,'Border','tight')

% green image small

Image5 = Image(170:170+149,60:60+149);
I = im2double(Image5);
Ib = mat2gray(I, [0 1]);

A = zeros(150);
D(:,:,1) = A;
D(:,:,2) = Ib;
D(:,:,3) = A;

Mask = zeros(150);
Mask(135:140,90:90+54)=1;

Image6 = D + Mask;

figure;
imshow(Image6,'Border','tight')

% Regular image

% Create grayscale image
Image = image6d(1,1,1,3,:,:);
Image = squeeze(Image);
Image = mat2gray(Image,[1 65536]);
%65536

Im = im2double(Image);
Im = mat2gray(Im, [0 1]);

figure;
imshow(Im,'Border','tight')

Image3 = Image(170:170+149,60:60+149);
I = im2double(Image3);
Ib = mat2gray(I, [0 0.12]);

Mask = zeros(150);
Mask(135:140,90:90+54)=1;


I2 = Ib+Mask;

figure;
imshow(I2,'Border','tight')

c = Im + I2;

figure;
imshow(c,'Border','tight')


%% Mag image small

Image3 = Image(250:250+149,100:100+149);
I = im2double(Image3);
Ib = mat2gray(I, [0 0.65]);

A = zeros(150);
D(:,:,1) = Ib;
D(:,:,2) = A;
D(:,:,3) = Ib;

Mask = zeros(150);
Mask(135:140,90:90+44)=1;

Image4 = D + Mask;

figure;
imshow(Image4,'Border','tight')


%%
data = bfopen('nov 29 filtered with polyA timelapse1.czi');
omeMeta = data{1,4};
%%
time = omeMeta.getPlaneDeltaT(0,0)
time2 = omeMeta.getPlaneDeltaT(0,3707)
%%
voxelSizeX = omeMeta.getPixelsPhysicalSizeX(0)% in μm

%%

ImageS2 = mat2gray(ImageS, [0 0.5]);
figure;
imshow(ImageS2,'Border','tight')
%%
RGB1(:,:,1) = ImageS;
RGB1(:,:,2) = ImageS;
RGB1(:,:,3) = ImageS;

figure;
imshow(RGB1,'Border','tight')
%%

max(Image(700:700+274,600:600+274))

%% Green image

Image2 = Image(470:470+399,10:10+399);
Image2 = mat2gray(Image2, [0 1]);

IRGB = repmat(Image2, [1,1,3]);
A = zeros(400);
R = zeros(400);
R(:,:,1) = A; 
R(:,:,2) = Image2;
R(:,:,3) = A;

Mask = zeros(400);
Mask(380:383,330:380)=1;

Image4 = R + Mask;

figure;
imshow(Image4,'Border','tight')

%% Green image Camera

Image2 = Image(180:180+274,100:100+274);
Image2 = mat2gray(Image2, [0 1]);

IRGB = repmat(Image2, [1,1,3]);
A = zeros(275);
R(:,:,1) = A; 
R(:,:,2) = Image2;
R(:,:,3) = A;

Mask = zeros(275);
Mask(245:250,200:254)=1;

Image4 = R + Mask;

figure;
imshow(Image4,'Border','tight')

%% red image
Image = image6d(1,20,1,1,:,:);
Image = squeeze(Image);
Image = mat2gray(Image);

Image2 = Image(210:210+69,105:105+69);
Image2 = mat2gray(Image2, [0 0.7]);

IRGB = repmat(Image2, [1,1,3]);
A = zeros(70);
C = zeros(70);
C(:,:,1) = Image2; 
C(:,:,2) = A;
C(:,:,3) = A;

Mask = zeros(70);
Mask(64:66,55:65)=1;

Image3 = C + Mask;

M = Image3 .*3;

figure;
imshow(Image3,'Border','tight')



%%

% Load/create your starting images:
pixelvalues = Image4;           % Color overlay
I1 = RGB1;  % Grayscale underlay
[r, c, d] = size(pixelvalues);
I1 = I1(1:r, 1:c, 1:d);

PixelInt = mean(double(pixelvalues), 3);
threshold = 0.1;
mask = repmat((PixelInt > threshold), [1 1 3]);

% Combine images:
I1(mask) = pixelvalues(mask);
figure;
imshow(I1);

%second time
pixelvalues = Image3;           % Color overlay
I1 = I1;  % Grayscale underlay
[r, c, d] = size(pixelvalues);
I1 = I1(1:r, 1:c, 1:d);

PixelInt = mean(double(pixelvalues), 3);
threshold = 0.08;
mask = repmat((PixelInt > threshold), [1 1 3]);

% Combine images:
I1(mask) = pixelvalues(mask);
figure;
imshow(I1,'Border','tight')

%%

video = VideoWriter('20211103 LAF-1 with beads 100uL timelapse camera.avi'); %create the video object
video.FrameRate = 0.5;
open(video); %open the file for writing
for ii=1:10 %where N is the number of images
    Image = image6d(1,ii,1,1,:,:);
    I = mat2gray(Image);
    I = squeeze(I);

  writeVideo(video,I); %write the image to file
end
close(video); %close the file

%%
%%
t = Tiff('20210422 3um rggrgg 30um gstgfprgg im4 timelapse newrgg.tif');
Image = read(t);
Image = mat2gray(Image);
Image = mat2gray(Image,[0 0.95]);
figure;
imshow(Image,'Border','tight')

%% Green image small

Image2 = Image(830:830+149,570:570+149);
Image2 = mat2gray(Image2, [0 0.6]);

A = zeros(150);
D(:,:,1) = A;
D(:,:,2) = Image2; 
D(:,:,3) = A;

Mask = zeros(150);
Mask(135:140,85:85+59)=1;

%Mask = zeros(50);
%Mask(40:45,35:35+11)=1;

Image3 = D + Mask;

figure;
imshow(Image3,'Border','tight')

%% Red image small

Image2 = Image(1:1+1023,1:1+1023);
Image2 = mat2gray(Image2, [0 1]);

A = zeros(1024);
D(:,:,1) =  A;
D(:,:,2) = Image2;
D(:,:,3) = A;

Mask = zeros(1024);
Mask(135:140,85:85+59)=1;

Mask = zeros(1024);
Mask(950:960,900:950)=1;

Image3 = D + Mask;

figure;
imshow(Image3,'Border','tight')

%% Regular image

Image2 = Image(1:1+149,200:200+149);
Image2 = mat2gray(Image2, [0 0.7]);
A = zeros(149);

Mask = zeros(150);
Mask(135:140,85:85+59)=1;

ImageS = Image2+Mask;

figure;
imshow(ImageS,'Border','tight')

%%
Image5 = Image3 + Image;
figure;
imshow(Image5,'Border','tight')

%% Green image X-small

Image2 = Image(250:250+74,230:230+74);
Image2 = mat2gray(Image2, [0 1]);

A = zeros(75);
C(:,:,1) = A;
C(:,:,2) = Image2; 
C(:,:,3) = A;

%Mask = zeros(150);
%Mask(135:140,85:85+59)=1;

Mask = zeros(75);
Mask(65:68,60:55+12)=1;

Image4 = C + Mask;

figure;
imshow(Image4,'Border','tight')