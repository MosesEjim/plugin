// shout_wrapper.h
#ifdef __cplusplus
extern "C" {
#endif

int shout_init_wrapper();
void* shout_new_wrapper();
int shout_set_host_wrapper(void* shout, const char* host);
int shout_set_port_wrapper(void* s, int port);
int shout_set_password_wrapper(void* s, const char* password);
int shout_set_mount_wrapper(void* s, const char* mount);
int shout_set_protocol_wrapper(void* s, int proto);
int shout_set_user_wrapper(void* s, const char* user);
int shout_set_format_wrapper(void* s, int fmt);
int shout_open_wrapper(void* s); 
int shout_send_wrapper(void* s, const unsigned char* data, int len);
int shout_get_connected_wrapper(void* s);
int shout_set_nonblocking_wrapper(void* s, int val);
int shout_close_wrapper(void* s); 
int shout_sync_wrapper(void* s);
int shout_get_errno_wrapper(void* s);
const char* shout_get_error_wrapper(void* s);
const char* shout_version_wrapper(int* major, int* minor, int* patch);
void shout_set_tls_wrapper(void* s, int mode);

#ifdef __cplusplus
}
#endif