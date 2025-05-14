% Select an image file
[filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp','Image Files'}, 'Select an image');
if isequal(filename,0)
    disp('User cancels.');
    return;
end
img = imread(fullfile(pathname, filename));

% If the image is in color, convert it to grayscale.
if size(img, 3) == 3
    img = rgb2gray(img);
end

original_img = img;  % Save original grayscale for display
img = double(img);   % Convert to double for SVD

% Select rank k
k = 1000;  % <<=== Change this value to adjust the rank according to your needs

% SVD and compress the image
[U, S, V] = svd(img);
Ak = U(:,1:k) * S(1:k,1:k) * V(:,1:k)';

% Make sure the pixel values are valid [0, 255]
Ak = max(0, min(255, Ak));

% Convert to uint8 for display and saving
Ak_uint8 = uint8(Ak);

% Display original and compressed images side by side
figure;
subplot(1,2,1);
imshow(original_img);
title('Original Grayscale Image');

subplot(1,2,2);
imshow(Ak_uint8);
title(sprintf('Grayscale Rank-%d Compression Result', k));

% Save the compressed image
imwrite(Ak_uint8, sprintf('grayscale_compression_k%d.jpg', k));
disp(['Image saved as grayscale_compression_k' num2str(k) '.jpg']);
