% Select image
[filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp','Image Files'}, 'Select image');
if isequal(filename,0)
    disp('User cancelled.');
    return;
end
img = imread(fullfile(pathname, filename));
original_img = img;           % Save original for display
img = double(img);            % Convert to double for SVD

% Select rank k and JPEG quality
k = 500;            % SVD rank
jpeg_quality = 50;   % 0–100, lower means smaller size

% Split color channels
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

% Compress each channel using SVD
[Ur, Sr, Vr] = svd(R);
Rk = Ur(:,1:k) * Sr(1:k,1:k) * Vr(:,1:k)';

[Ug, Sg, Vg] = svd(G);
Gk = Ug(:,1:k) * Sg(1:k,1:k) * Vg(:,1:k)';

[Ub, Sb, Vb] = svd(B);
Bk = Ub(:,1:k) * Sb(1:k,1:k) * Vb(:,1:k)';

% Limit pixel values to 0–255
Rk = max(0, min(255, Rk));
Gk = max(0, min(255, Gk));
Bk = max(0, min(255, Bk));

% Combine into full RGB image
Ak_rgb = uint8(cat(3, Rk, Gk, Bk));

% Save as JPEG with specified quality
output_filename = sprintf('svd_rgb_k%d_q%d.jpg', k, jpeg_quality);
imwrite(Ak_rgb, output_filename, 'jpg', 'Quality', jpeg_quality);
disp(['Compressed RGB image saved as ', output_filename]);

% Display side-by-side using subplot
figure;
subplot(1,2,1);
imshow(original_img);
title('Original Image');

subplot(1,2,2);
imshow(Ak_rgb);
title(sprintf('Compressed (Rank %d | JPEG Q %d)', k, jpeg_quality));