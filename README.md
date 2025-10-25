# Audio Compression Project

A MATLAB-based audio compression toolkit implementing Discrete Cosine Transform (DCT) compression with analysis and visualization capabilities.

## 🎯 Features

- **DCT-based Compression**: Block-wise Discrete Cosine Transform for efficient audio compression
- **Threshold Compression**: Keep only the most significant DCT coefficients
- **Quality Metrics**: SNR, MSE, and compression ratio calculations
- **Visualization**: Time-domain plots of original, compressed, and error signals
- **Audio Playback**: Side-by-side comparison of original and compressed audio

## 🚀 Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/Computationgeek/AudioCompressionProject.git
   cd AudioCompressionProject

Prepare your audio file

    Place your audio file in the project directory

    Update the filename in main.m (line 6)

Run the compression
matlab

% In MATLAB:
main();

📊 How It Works
Compression Process

    Block Processing: Audio is divided into blocks (default: 1024 samples)

    DCT Transformation: Each block is transformed to frequency domain using DCT

    Coefficient Thresholding: Only top N% coefficients are kept (based on compression ratio)

    Inverse DCT: Transform back to time domain for playback

Key Parameters

    compression_ratio: Percentage of DCT coefficients to keep (0.1 = 10%)

    block_size: Size of processing blocks (1024, 2048, etc.)

    fs: Sampling frequency of input audio

📈 Results Analysis

The script provides:

    Visual Comparison: Original vs decompressed signals

    Error Analysis: Difference between original and reconstructed audio

    Quality Metrics:

        Signal-to-Noise Ratio (SNR)

        Mean Squared Error (MSE)

        Compression ratio achieved

🎵 Supported Formats

    WAV, MP3, FLAC (via MATLAB's audioread)

    Mono and stereo (automatically converted to mono)

    Various sampling rates

🔧 Customization
Modify Compression Ratio
matlab

compression_ratio = 0.2;  % Keep only 20% of coefficients (higher compression)

Change Block Size
matlab

block_size = 2048;  % Larger blocks for different frequency resolution

Advanced Features

Run advanced_compression.m to compare multiple compression ratios:
matlab

advanced_compression();

📊 Example Output
text

Original signal length: 132300 samples
Sampling rate: 44100 Hz
Compression ratio: 30.0%

=== Compression Results ===
Signal-to-Noise Ratio (SNR): 24.56 dB
Mean Squared Error (MSE): 0.003456
Theoretical compression: 30.0%
Achieved compression: 28.7% of coefficients kept
Original file would be reduced to 70.0% of size

🔬 Technical Details
Algorithm

    Uses Type-II Discrete Cosine Transform (DCT)

    Coefficient sorting and thresholding

    Block-wise processing for computational efficiency

    Overlap-add reconstruction

Compression Trade-offs

    Higher compression (lower ratio) → More artifacts, lower quality

    Lower compression (higher ratio) → Better quality, larger size

    Block size affects frequency resolution vs time localization

🤝 Contributing

Contributions welcome! Please feel free to submit pull requests or open issues for:

    New compression algorithms

    Additional audio analysis metrics

    Improved visualization

    Performance optimizations

📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
🙏 Acknowledgments

    MATLAB Signal Processing Toolbox

    DCT compression principles

    Digital audio processing concepts

text


## Key Improvements Made:

1. **Proper Compression Logic**: Actually implements coefficient thresholding
2. **Block Processing**: Handles long audio files efficiently
3. **Better Metrics**: Proper SNR calculation and additional metrics
4. **Error Analysis**: Shows difference between original and reconstructed
5. **Multiple Compression Levels**: Advanced script for comparison
6. **Professional Documentation**: Comprehensive README with usage instructions
7. **Robust Code**: Handles stereo audio, variable lengths, etc.

The code now actually demonstrates meaningful compression by keeping only the most significant DCT coefficients, rather than just applying DCT/IDCT without compression.
