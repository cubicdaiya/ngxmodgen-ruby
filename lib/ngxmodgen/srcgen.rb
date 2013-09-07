class NginxModuleSourceGenerator

  def initialize(module_name)
    @module_name = module_name
  end

  def generate
    <<"EOS"

#include <ngx_config.h>
#include <ngx_core.h>
#include <ngx_http.h>

static ngx_command_t ngx_http_#{@module_name}_commands[] = {
    /*
    {
        ngx_string("command_name"),
        NGX_HTTP_LOC_CONF|NGX_CONF_NOARGS,
        NULL,
        0,
        0,
        NULL
    },
    */
    ngx_null_command
};

static ngx_http_module_t ngx_http_#{@module_name}_module_ctx = {
    NULL,                              /* preconfiguration */
    NULL,                              /* postconfiguration */

    NULL,                              /* create main configuration */
    NULL,                              /* init main configuration */

    NULL,                              /* create server configuration */
    NULL,                              /* merge server configuration */

    NULL,                              /* create location configuration */
    NULL                               /* merge location configuration */
};

ngx_module_t ngx_http_#{@module_name}_module = {
    NGX_MODULE_V1,
    &ngx_http_#{@module_name}_module_ctx, /* module context */
    ngx_http_#{@module_name}_commands,    /* module directives */
    NGX_HTTP_MODULE,                      /* module type */
    NULL,                                 /* init master */
    NULL,                                 /* init module */
    NULL,                                 /* init process */
    NULL,                                 /* init thread */
    NULL,                                 /* exit thread */
    NULL,                                 /* exit process */
    NULL,                                 /* exit master */
    NGX_MODULE_V1_PADDING
};

EOS
  end

  def filter_generate
    <<"EOS"

#include <ngx_config.h>
#include <ngx_core.h>
#include <ngx_http.h>

static ngx_int_t ngx_http_#{@module_name}_filter_init(ngx_conf_t *cf);

static ngx_command_t ngx_http_#{@module_name}_commands[] = {
    /*
    {
        ngx_string("command_name"),
        NGX_HTTP_LOC_CONF|NGX_CONF_NOARGS,
        NULL,
        0,
        0,
        NULL
    },
    */
    ngx_null_command
};

static ngx_http_module_t  ngx_http_#{@module_name}_filter_module_ctx = {
    NULL,                                  /* preconfiguration */
    ngx_http_#{@module_name}_filter_init,  /* postconfiguration */

    NULL,                                  /* create main configuration */
    NULL,                                  /* init main configuration */

    NULL,                                  /* create server configuration */
    NULL,                                  /* merge server configuration */

    NULL,                                  /* create location configuration */
    NULL                                   /* merge location configuration */
};

ngx_module_t  ngx_http_#{@module_name}_filter_module = {
    NGX_MODULE_V1,
    &ngx_http_#{@module_name}_filter_module_ctx, /* module context */
    ngx_http_#{@module_name}_commands,           /* module directives */
    NGX_HTTP_MODULE,                             /* module type */
    NULL,                                        /* init master */
    NULL,                                        /* init module */
    NULL,                                        /* init process */
    NULL,                                        /* init thread */
    NULL,                                        /* exit thread */
    NULL,                                        /* exit process */
    NULL,                                        /* exit master */
    NGX_MODULE_V1_PADDING
};

static ngx_http_output_header_filter_pt  ngx_http_next_header_filter;
static ngx_http_output_body_filter_pt    ngx_http_next_body_filter;

static ngx_int_t ngx_http_#{@module_name}_header_filter(ngx_http_request_t *r)
{
    return ngx_http_next_header_filter(r);
}


static ngx_int_t ngx_http_#{@module_name}_body_filter(ngx_http_request_t *r, ngx_chain_t *in)
{
    return ngx_http_next_body_filter(r, in);
}

static ngx_int_t ngx_http_#{@module_name}_filter_init(ngx_conf_t *cf)
{
    ngx_http_next_header_filter = ngx_http_top_header_filter;
    ngx_http_top_header_filter = ngx_http_#{@module_name}_header_filter;

    ngx_http_next_body_filter = ngx_http_top_body_filter;
    ngx_http_top_body_filter = ngx_http_#{@module_name}_body_filter;

    return NGX_OK;
}

EOS
  end

  def module_name
    "ngx_http_#{@module_name}_module"
  end

  def filter_module_name
    "ngx_http_#{@module_name}_filter_module"
  end

end
