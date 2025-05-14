# SVD Image Compression Application (MATLAB)

This project demonstrates image compression using **Singular Value Decomposition (SVD)** in MATLAB. The application allows users to compress an image by selecting a desired rank value, balancing between image quality and compression ratio.

## Features

- Load and display images.
- Compress images using SVD based on user-defined rank.
- Visualize original and compressed images side by side.
- Save compressed images.

## How It Works

1. **SVD Decomposition:**  
    The image matrix is decomposed into three matrices: `U`, `S`, and `V` using MATLAB's `svd()` function.

2. **Rank Selection:**  
    The user selects a rank `k`. Only the top `k` singular values and corresponding vectors are kept.

3. **Reconstruction:**  
    The compressed image is reconstructed as:  
    `A_k = U(:,1:k) * S(1:k,1:k) * V(:,1:k)'`

4. **Compression:**  
    Lower rank values result in higher compression but more loss of detail.

## Usage

1. Open the MATLAB script or app.
2. Load an image.
3. Choose the desired rank value (in the code).
4. View and save the compressed result.

## Requirements

- MATLAB R2021a or newer (I'm using R2021a, maybe the older version can run it because it is a simple program)

## License

This project is for educational purposes.