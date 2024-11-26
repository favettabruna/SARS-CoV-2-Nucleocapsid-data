%clear
%clc
close all

% Upload image
A = ReadImage6D('20211022 50uM N + 2uM GFP-M im3.czi');
metadata = A{2};
image6d = A{1};

%%
% Save image
Image = image6d(1,1,1,1,:,:);
Image = mat2gray(Image);
Image = squeeze(Image);
%Image = mat2gray(Image, [0 1]);

% Show image
figure;
imshow(Image,'Border','tight')

%%

c = improfile

d = improfile


e = improfile


f = improfile



g = improfile

h = improfile

i = improfile


j = improfile


k = improfile


l = improfile

%%
one = imresize(c,[100/41]);
two = imresize(d,[100/39.2]);
three = imresize(e,[100/38]);
four = imresize(f,[100/49]);
five = imresize(g,[100/42]);
six = imresize(h,[100/44.2]);
seven = imresize(i,[100/51]);
eight = imresize(j,[100/64]);
nine = imresize(k,[100/69]);
ten = imresize(l,[100/90]);
% 
av = [one(:,1) two(:,1) three(:,1) four(:,1) five(:,1) six(:,1) seven(:,1) ];
MN = mean(av,2);
%%

x = linspace(-1.3,1.3,100);
figure;
hold on
plot(x,one,'k')
plot(x,two,'k')
plot(x,three,'k')
plot(x,four,'k')
plot(x,five,'k')
plot(x,six,'k')
plot(x,seven,'k')
plot(x,eight,'k')
plot(x,nine,'k')
plot(x,ten,'k')
xlim([-1.3 1.3])
ylim([0 1])
%%
figure;
plot(x,MN,'k')
%%
x = linspace(0,100,100);
m = mean(MN(30:66,1))


av2 = [eight(:,1) nine(:,1) ten(:,1) ];
MN2 = mean(av2,2);
m2 = mean(MN2(1:100,1))
figure;
plot(x,MN2,'k')

%%

% Remove noise, threshold, fill holes, remove border
Image2 = imdiffusefilt(Image);
Image2 = imbinarize(Image2,0.38);
%Image2 = (Image2-1).*-1;
Image2 = imfill(Image2,'holes');
Image3 = imclearborder(Image2);

%SE = ones(10,10);
%Image3 = imerode(Image3,SE);

figure;
imshow(Image3,'Border','tight')

%%
figure;
imshow(Image,'Border','tight')

% Find Circles
[centers,radii,metric] = imfindcircles(Image3,[8 100],'Sensitivity',0.8);
viscircles(centers,radii);

%% Loop over all circles found and find the line profile across the middle

% Re-open fluorescent image

figure;


F = Image;

allcs = {};
figure;
imshow(F)
hold on

for i = 1:length(radii)
    if radii(i) > 15
        
        x = [centers(i,1)-radii(i)-radii(i)./3 centers(i,1)+radii(i)+radii(i)./3];
        y = [centers(i,2) centers(i,2)];
    
        x2 = [centers(i,1) centers(i,1)];
        y2 = [centers(i,2)-radii(i)-radii(i)./3 centers(i,2)+radii(i)+radii(i)./3];
    
        c = improfile(F,x,y)';
        allcs = [allcs; c];

        plot(x,y,'r')

        c = improfile(F,x2,y2)';
        allcs = [allcs; c];

        plot(x2,y2,'b')
    end
    
end

%Plot profile
 profile = allcs{2,1}; % Change 2 to number between 1:total number of circles
 figure;
 plot(profile)
 
 %%
 
figure;
hold on

c = 1;
for ii = 1:94

    allcsR(ii,:) = imresize(allcs{ii,1},[1 100]);
    
    if allcsR(ii,1)<0.4
        if allcsR(ii,100)<0.4
            plot(allcsR(ii,:))
            LP2(c,:) = allcsR(ii,:);
            c = c+1;
        end
    end
  
end


%%

average = mean(LP2,1);
x = linspace(-1,1,100);
figure;
plot(average)
ylim([0 1])
%xlabel('Distance (µm)')
%ylabel('Intensity (a.u.)')
%title('Pixel Profile')

%%

one = imresize(c,[100/101]);
x = linspace(-1,1,100);
figure;
plot(x,one,'k')
ylim([0 1])
