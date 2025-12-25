#ifndef FLUTTER_AUDIO_STREAMER_H
#define FLUTTER_AUDIO_STREAMER_H

#ifdef __cplusplus
extern "C" {
#endif

// lifecycle
int fas_init();
int fas_start();
int fas_stop();
int fas_dispose();

// configuration
int fas_set_stream_info(
    const char* host,
    int port,
    const char* mount,
    const char* password
);

// audio input
int fas_push_pcm(
    const short* left,
    const short* right,
    int samples
);

#ifdef __cplusplus
}
#endif

#endif
