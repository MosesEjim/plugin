#include <shout/shout.h>
#include <stdio.h>

// Initialization
int shout_init_wrapper(void) {
    printf("✅ shout_init_wrapper called\n");
    shout_init();
    printf("✅ shout_init_wrapper called\n");
    return 1;
}

// Create new shout instance
void* shout_new_wrapper(void) {
    return shout_new();
}

// Set host
int shout_set_host_wrapper(void* s, const char* host) {
    return shout_set_host(s, host);
}

// Set port
int shout_set_port_wrapper(void* s, int port) {
    return shout_set_port(s, port);
}

// Set password
int shout_set_password_wrapper(void* s, const char* password) {
    return shout_set_password(s, password);
}

// Set mount point
int shout_set_mount_wrapper(void* s, const char* mount) {
    return shout_set_mount(s, mount);
}

// Set protocol
int shout_set_protocol_wrapper(void* s, int proto) {
    return shout_set_protocol(s, proto);
}

// Set user
int shout_set_user_wrapper(void* s, const char* user) {
    return shout_set_user(s, user);
}

// Set content format
int shout_set_format_wrapper(void* s, int fmt) {
    return shout_set_format(s, fmt);
}

// Open connection
int shout_open_wrapper(void* s) {
    return shout_open(s);
}

// Send data
int shout_send_wrapper(void* s, const unsigned char* data, int len) {
    return shout_send(s, data, len);
}

// Check if connected
int shout_get_connected_wrapper(void* s) {
    return shout_get_connected(s);
}

// Set non-blocking
int shout_set_nonblocking_wrapper(void* s, int val) {
    return shout_set_nonblocking(s, val);
}

// Close connection
int shout_close_wrapper(void* s) {
    return shout_close(s);
}

// Sync
int shout_sync_wrapper(void* s) {
    shout_sync(s);
    return 1;
}

// Get errno
int shout_get_errno_wrapper(void* s) {
    return shout_get_errno(s);
}

// Get error message
const char* shout_get_error_wrapper(void* s) {
    return shout_get_error(s);
}

// Get library version
const char* shout_version_wrapper(int* major, int* minor, int* patch) {
    return shout_version(major, minor, patch);
}

// Set TLS mode
void shout_set_tls_wrapper(void* s, int mode) {
    shout_set_tls(s, mode);
}
