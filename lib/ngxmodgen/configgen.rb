class NginxModuleConfigGenerator

  def initialize(module_name)
    @module_name = module_name
  end

  def generate
    <<"EOS"
ngx_addon_name=ngx_http_#{@module_name}_module
HTTP_MODULES="$HTTP_MODULES ngx_http_#{@module_name}_module"
NGX_ADDON_SRCS="$NGX_ADDON_SRCS $ngx_addon_dir/ngx_http_#{@module_name}_module.c"
EOS
  end

  def filter_generate
    <<"EOS"
ngx_addon_name=ngx_http_#{@module_name}_module
HTTP_FILTER_MODULES="$HTTP_FILTER_MODULES ngx_http_#{@module_name}_filter_module"
NGX_ADDON_SRCS="$NGX_ADDON_SRCS $ngx_addon_dir/ngx_http_#{@module_name}_filter_module.c"
EOS
  end

end
