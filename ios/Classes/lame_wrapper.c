#include <lame/lame.h>

#define FFI_EXPORT __attribute__((visibility("default"))) __attribute__((used))

// Global wrapper functions matching your Dart FFI bindings

FFI_EXPORT lame_global_flags* lame_init_wrapper(void) {
    return lame_init();
}

FFI_EXPORT int lame_set_in_samplerate_wrapper(lame_global_flags* gfp, int value) {
    return lame_set_in_samplerate(gfp, value);
}

FFI_EXPORT int lame_set_out_samplerate_wrapper(lame_global_flags* gfp, int value) {
    return lame_set_out_samplerate(gfp, value);
}

FFI_EXPORT int lame_set_num_channels_wrapper(lame_global_flags* gfp, int value) {
    return lame_set_num_channels(gfp, value);
}

FFI_EXPORT int lame_set_brate_wrapper(lame_global_flags* gfp, int value) {
    return lame_set_brate(gfp, value);
}

FFI_EXPORT int lame_set_quality_wrapper(lame_global_flags* gfp, int value) {
    return lame_set_quality(gfp, value);
}

FFI_EXPORT int lame_set_VBR_wrapper(lame_global_flags* gfp, int value) {
    return lame_set_VBR(gfp, value);
}

FFI_EXPORT int lame_init_params_wrapper(lame_global_flags* gfp) {
    return lame_init_params(gfp);
}

FFI_EXPORT int lame_encode_buffer_wrapper(
        lame_global_flags* gfp,
        short int* buffer_l,
        short int* buffer_r,
        int nsamples,
        unsigned char* mp3buf,
        int mp3buf_size
) {
    return lame_encode_buffer(gfp, buffer_l, buffer_r, nsamples, mp3buf, mp3buf_size);
}

FFI_EXPORT int lame_encode_flush_wrapper(lame_global_flags* gfp, unsigned char* mp3buf, int size) {
    return lame_encode_flush(gfp, mp3buf, size);
}

FFI_EXPORT int lame_close_wrapper(lame_global_flags* gfp) {
    return lame_close(gfp);
}
