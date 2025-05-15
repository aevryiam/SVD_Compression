% Select an image
[filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp','Image Files'}, 'Select an image');
if isequal(filename,0)
    disp('User cancelled.');
    return;
end
img = imread(fullfile(pathname, filename));

% If the image is in color, convert it to grayscale.
if size(img, 3) == 3
    img_gray = rgb2gray(img);
else
    img_gray = img;
end

img_double = double(img_gray);

% Select rank k
k = 1000;  % <<=== Adjust this as needed

% SVD
[U, S, V] = svd(img_double);
Ak = U(:,1:k) * S(1:k,1:k) * V(:,1:k)';

% Limit pixel values to [0, 255]
Ak = max(0, min(255, Ak));
Ak_uint8 = uint8(Ak);

% Save the compressed image as JPEG
output_filename = sprintf('svd_k%d_q50.jpg', k);
imwrite(Ak_uint8, output_filename, 'jpg', 'Quality', 50);
disp(['Image saved as ', output_filename]);

% Display both original and compressed images using subplot
figure;
subplot(1,2,1);
imshow(img_gray);
title('Original Grayscale');

subplot(1,2,2);
imshow(Ak_uint8);
title(sprintf('SVD Compressed (Rank-%d)', k));