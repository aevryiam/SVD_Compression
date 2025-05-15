% Select an image file
[filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp','Image Files'}, 'Select an image');
if isequal(filename,0)
    disp('User cancelled.');
    return;
end
img = imread(fullfile(pathname, filename));
img = double(img);  % convert to double for SVD

% Select rank k
k = 1000;  % <<=== Change this value to adjust the rank according to your needs

% Split RGB channels
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

% SVD and compress each channel
[Ur, Sr, Vr] = svd(R);
Rk = Ur(:,1:k) * Sr(1:k,1:k) * Vr(:,1:k)';

[Ug, Sg, Vg] = svd(G);
Gk = Ug(:,1:k) * Sg(1:k,1:k) * Vg(:,1:k)';

[Ub, Sb, Vb] = svd(B);
Bk = Ub(:,1:k) * Sb(1:k,1:k) * Vb(:,1:k)';

% Make sure the pixel values ​​are valid [0, 255]
Rk = max(0, min(255, Rk));
Gk = max(0, min(255, Gk));
Bk = max(0, min(255, Bk));

% Merge the compressed channels back into an RGB image
compressed_img = uint8(cat(3, Rk, Gk, Bk));
original_img = uint8(img);  % Convert back to uint8 for display

% Display original and compressed images side by side
figure;
subplot(1,2,1);
imshow(original_img);
title('Original Image');

subplot(1,2,2);
imshow(compressed_img);
title(sprintf('Rank-%d Compression Result', k));

% Save compressed image
imwrite(compressed_img, sprintf('rgb_compression_k%d.jpg', k));
disp(['Image saved as rgb_compression_k' num2str(k) '.jpg']);
