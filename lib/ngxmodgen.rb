require "ngxmodgen/version"
require "ngxmodgen/configgen"
require "ngxmodgen/srcgen"

require 'optparse'

op = OptionParser.new

module_name = ""
module_type = "http"

op.on('-n', '--name NAME', "nginx module name") {|s|
  module_name = s
}

op.on('-t', '--type [TYPE]', "module type(default: #{module_type})") {|s|
  module_type = s
}

op.parse!(ARGV)

if module_name == ""
  e = OptionParser::ParseError.new;
  raise e, "module name was not specified"
end

config_gen = NginxModuleConfigGenerator.new(module_name)
src_gen    = NginxModuleSourceGenerator.new(module_name)

if module_type == "http"
  File.open('config', 'w') {|f| f.write(config_gen.generate()) }
  File.open("#{src_gen.module_name}.c", 'w') {|f| f.write(src_gen.generate()) }
  puts "#{src_gen.module_name}.c and config is generated"
elsif module_type == "http_filter"
  File.open('config', 'w') {|f| f.write(config_gen.filter_generate()) }
  File.open("#{src_gen.filter_module_name}.c", 'w') {|f| f.write(src_gen.filter_generate()) }
  puts "#{src_gen.filter_module_name}.c and config is generated"
else
  puts "module type is invalid. Input 'http' or 'http_filter'"
  exit(1)
end

