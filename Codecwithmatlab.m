[original_signal, fs] = audioread('Add Your Audio.wav');

compression_ratio = 0.5;
blockSize = 1024;

compressed_signal = dct(original_signal);
decompressed_signal = idct(compressed_signal);

% Calculate SNR
SNR = snr(original_signal, decompressed_signal);

t_original = (0:length(original_signal)-1) / fs;
t_compressed = (0:length(compressed_signal)-1) / fs;
t_decompressed = (0:length(decompressed_signal)-1) / fs;

figure;
subplot(3,1,1);
plot(t_original, original_signal);
title('Original Audio Signal');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(3,1,2);
plot(t_compressed, compressed_signal);
title('Compressed Audio Signal');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(3,1,3);
plot(t_decompressed, decompressed_signal);
title('Decompressed Audio Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Display SNR
disp(['Signal-to-Noise Ratio (SNR): ', num2str(SNR), ' dB']);

% Play original audio for 30 seconds
disp('Playing Original Audio...');
soundsc(original_signal(1:min(30*fs, length(original_signal))), fs);
pause(30); % Pause for 30 seconds

% Play compressed audio for 30 seconds
disp('Playing Compressed Audio...');
soundsc(compressed_signal(1:min(30*fs, length(compressed_signal))), fs);
pause(30); % Pause for 30 seconds

% Play decompressed audio for 30 seconds
disp('Playing Decompressed Audio...');
soundsc(decompressed_signal(1:min(30*fs, length(decompressed_signal))), fs);
pause(30); % Pause for 30 seconds
