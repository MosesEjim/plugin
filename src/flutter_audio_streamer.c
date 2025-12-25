#include "flutter_audio_streamer.h"

#include "shout_wrapper.h"
#include "lame_wrapper.h"



static lame_global_flags* g_lame = NULL;
static shout_t* g_shout = NULL;

int fas_init() {
    g_lame = lame_init_wrapper();
    if (!g_lame) return -1;

    lame_set_in_samplerate_wrapper(g_lame, 44100);
    lame_set_out_samplerate_wrapper(g_lame, 44100);
    lame_set_num_channels_wrapper(g_lame, 2);
    lame_init_params_wrapper(g_lame);

    g_shout = shout_new_wrapper();
    return g_shout ? 0 : -2;
}

int fas_start() {
    return shout_open_wrapper(g_shout);
}

int fas_push_pcm(const short* l, const short* r, int samples) {
    unsigned char mp3buf[8192];

    int encoded = lame_encode_buffer_wrapper(
        g_lame,
        (short*)l,
        (short*)r,
        samples,
        mp3buf,
        sizeof(mp3buf)
    );

    if (encoded > 0) {
        return shout_send_wrapper(g_shout, mp3buf, encoded);
    }
    return encoded;
}

int fas_stop() {
    lame_encode_flush_wrapper(g_lame, NULL, 0);
    shout_close_wrapper(g_shout);
    return 0;
}

int fas_dispose() {
    lame_close_wrapper(g_lame);
    //shout_free_wrapper(g_shout);
    return 0;
}
