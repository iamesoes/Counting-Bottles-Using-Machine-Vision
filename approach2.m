img=imread('images/bottle_crate_24.png'); %read image

thImg = imbinarize(img,.524); %convert image to a binary image based on threshold
bwImg = bwareaopen(thImg,50); %remove small objects

cannyImg = edge(bwImg,'canny',[]); % Canny edge detection

min_rad = 17; %for normal bottles
max_rad = 42; %for flipped bottles
[centers, radii, metric] = imfindcircles(cannyImg, [min_rad, max_rad]); %search for circles with given radii
figure
imshowpair(cannyImg,img,'montage'); %show given two image at the same time

viscircles(centers, radii, 'EdgeColor', 'b'); %show detected circles