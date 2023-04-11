seLine=strel('line',40,90);
seDisk=strel('disk',2);
seDisk2=strel('disk',6);
seDisk3=strel('disk',15);
seDisk4=strel('disk',5);

%Image reading
A=imread('images/bottle_crate_12.png');

%Tresholding for bright full white bottle caps
kapakliA=im2bw(A,.99);
imshow(kapakliA);

%Image filling by holes for bright bottle caps, If any without full circle
diskKA = imfill(kapakliA,"holes");
imshow(diskKA);

%Closing for improve connectivity
KAclosed = imclose(diskKA,seDisk);
imshow(KAclosed);
%Opening for just remain the circles
KAopened = imopen(diskKA,seDisk3);
imshow(KAopened);



%First treshold with low treshold
backgroundofA=im2bw(A,0.20);
imshow(backgroundofA);

%Secon treshold with higher treshold
frontofA=im2bw(A,0.38);
imshow(frontofA);

%Opening with 'line' structring element to leave just the brightest areas
openedBA= imopen(backgroundofA,seLine);
imshow(openedBA);

%Subtracting the left bright areas after opening from second(higher) treshold
subtractedA=imsubtract(frontofA,openedBA);
imshow(subtractedA);

%Filling circles
diskA = imfill(subtractedA,"holes");
imshow(diskA);

%Remove the elements that is not a full circle
lastA= imopen(diskA,seDisk3);
imshow(lastA);

%This part is for fixing matrix pixel values after subtracting. 
%Converting -1 values to 0.
for ii=1:size(lastA,1)
    for jj=1:size(lastA,2)
        % get pixel value
        pixel=lastA(ii,jj);
          % check pixel value and assign new value
          if pixel<0
              lastA(ii,jj)=0;
          end
          % save new pixel value in thresholded image
      end
  end

%Combining the results between bright full bottle cans and normal circles
sumofA = or(lastA,KAopened);
imshow(sumofA)


