#ifndef LAME_WRAPPER_H
#define LAME_WRAPPER_H

#include <lame/lame.h>

#ifdef __cplusplus
extern "C" {
#endif

// Initialization
lame_global_flags* lame_init_wrapper(void);

// Configuration
int lame_set_in_samplerate_wrapper(lame_global_flags* gfp, int value);
int lame_set_out_samplerate_wrapper(lame_global_flags* gfp, int value);
int lame_set_num_channels_wrapper(lame_global_flags* gfp, int value);
int lame_set_brate_wrapper(lame_global_flags* gfp, int value);
int lame_set_quality_wrapper(lame_global_flags* gfp, int value);
int lame_set_VBR_wrapper(lame_global_flags* gfp, int value);

// Finalize params
int lame_init_params_wrapper(lame_global_flags* gfp);

// Encoding
int lame_encode_buffer_wrapper(
    lame_global_flags* gfp,
    short int* buffer_l,
    short int* buffer_r,
    int nsamples,
    unsigned char* mp3buf,
    int mp3buf_size
);

// Flush & close
int lame_encode_flush_wrapper(
    lame_global_flags* gfp,
    unsigned char* mp3buf,
    int size
);

int lame_close_wrapper(lame_global_flags* gfp);

#ifdef __cplusplus
}
#endif

#endif /* LAME_WRAPPER_H */
