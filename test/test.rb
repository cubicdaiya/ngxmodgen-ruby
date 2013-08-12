require "minitest/autorun"
require "ngxmodgen/configgen"
require "ngxmodgen/srcgen"

class TestNgxmodgen < MiniTest::Test
  def setup
    @module_name = "hoge"
    @config_gen  = NginxModuleConfigGenerator.new(@module_name)
    @src_gen     = NginxModuleSourceGenerator.new(@module_name)
  end

  def teardown

  end

  def test_module_name
    assert_equal "ngx_http_hoge_module", @src_gen.module_name
  end

  def test_filter_module_name
    assert_equal "ngx_http_hoge_filter_module", @src_gen.filter_module_name
  end

  def test_http_module_config
    r = /^HTTP_MODULES/
    assert r.match(@config_gen.generate), "HTTP_MODULE is not included"
  end

  def test_http_filter_module_config
    r = /^HTTP_FILTER_MODULES/
    assert r.match(@config_gen.filter_generate), "HTTP_FILTER_MODULE is not included"
  end

end
