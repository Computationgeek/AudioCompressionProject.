function main()
    % Audio Compression using DCT with Thresholding
    % Updated with proper compression logic and analysis
    
    % Read audio file
    [original_signal, fs] = audioread('your_audio.wav');
    
    % Convert to mono if stereo
    if size(original_signal, 2) > 1
        original_signal = mean(original_signal, 2);
    end
    
    % Parameters
    compression_ratio = 0.3;  % Keep only 30% of coefficients
    block_size = 1024;
    
    fprintf('Original signal length: %d samples\n', length(original_signal));
    fprintf('Sampling rate: %d Hz\n', fs);
    fprintf('Compression ratio: %.1f%%\n', compression_ratio * 100);
    
    % Process signal in blocks
    [compressed_signal, decompressed_signal] = processAudioBlocks(original_signal, block_size, compression_ratio);
    
    % Calculate metrics
    SNR = snr(original_signal, original_signal - decompressed_signal);
    MSE = mean((original_signal - decompressed_signal).^2);
    compression_achieved = (1 - (length(find(compressed_signal ~= 0)) / length(compressed_signal))) * 100;
    
    % Time vectors
    t_original = (0:length(original_signal)-1) / fs;
    t_decompressed = (0:length(decompressed_signal)-1) / fs;
    
    % Plot results
    plotResults(t_original, original_signal, decompressed_signal, original_signal - decompressed_signal);
    
    % Display metrics
    fprintf('\n=== Compression Results ===\n');
    fprintf('Signal-to-Noise Ratio (SNR): %.2f dB\n', SNR);
    fprintf('Mean Squared Error (MSE): %.6f\n', MSE);
    fprintf('Theoretical compression: %.1f%%\n', compression_ratio * 100);
    fprintf('Achieved compression: %.1f%% of coefficients kept\n', (100 - compression_achieved));
    fprintf('Original file would be reduced to %.1f%% of size\n', (1 - compression_ratio) * 100);
    
    % Play audio samples
    playAudioSamples(original_signal, decompressed_signal, fs);
end

function [compressed, decompressed] = processAudioBlocks(signal, block_size, ratio)
    % Process audio in blocks using DCT compression
    
    num_blocks = ceil(length(signal) / block_size);
    compressed = zeros(size(signal));
    decompressed = zeros(size(signal));
    
    for i = 1:num_blocks
        start_idx = (i-1) * block_size + 1;
        end_idx = min(i * block_size, length(signal));
        
        block = signal(start_idx:end_idx);
        
        % Apply DCT
        dct_coeffs = dct(block);
        
        % Compression: Keep only the most significant coefficients
        num_keep = round(length(dct_coeffs) * ratio);
        [~, sorted_indices] = sort(abs(dct_coeffs), 'descend');
        keep_indices = sorted_indices(1:num_keep);
        
        % Create compressed version (sparse representation)
        compressed_block = zeros(size(dct_coeffs));
        compressed_block(keep_indices) = dct_coeffs(keep_indices);
        
        % Decompress
        decompressed_block = idct(compressed_block);
        
        % Store results
        compressed(start_idx:end_idx) = compressed_block;
        decompressed(start_idx:end_idx) = decompressed_block;
    end
end

function plotResults(t_original, original, decompressed, error)
    % Plot the audio signals and error
    
    figure('Position', [100, 100, 1200, 900]);
    
    % Original signal
    subplot(3,1,1);
    plot(t_original, original, 'b', 'LineWidth', 1);
    title('Original Audio Signal', 'FontSize', 12, 'FontWeight', 'bold');
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;
    
    % Decompressed signal
    subplot(3,1,2);
    plot(t_original, decompressed, 'r', 'LineWidth', 1);
    title('Decompressed Audio Signal', 'FontSize', 12, 'FontWeight', 'bold');
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;
    
    % Error signal
    subplot(3,1,3);
    plot(t_original, error, 'g', 'LineWidth', 1);
    title('Error (Original - Decompressed)', 'FontSize', 12, 'FontWeight', 'bold');
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;
    
    sgtitle('Audio Compression using DCT with Thresholding', 'FontSize', 14, 'FontWeight', 'bold');
end

function playAudioSamples(original, decompressed, fs)
    % Play audio samples for comparison
    
    duration = 10; % seconds
    samples = min(duration * fs, length(original));
    
    fprintf('\n=== Audio Playback ===\n');
    
    % Original audio
    fprintf('Playing original audio (%d seconds)...\n', duration);
    soundsc(original(1:samples), fs);
    pause(duration + 1);
    
    % Decompressed audio
    fprintf('Playing decompressed audio (%d seconds)...\n', duration);
    soundsc(decompressed(1:samples), fs);
    pause(duration + 1);
    
    fprintf('Playback completed.\n');
end

% Run the main function
main();
