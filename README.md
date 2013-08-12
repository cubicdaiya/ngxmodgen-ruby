[![Build Status](https://travis-ci.org/cubicdaiya/ngxmodgen.png?branch=travis)](https://travis-ci.org/cubicdaiya/ngxmodgen)

# ngxmodgen

ngxmodgen is the code generator for a nginx module

## Installation

Add this line to your application's Gemfile:

    gem 'ngxmodgen'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ngxmodgen

## Usage

    $ NGINX_MODULE_NAME=hoge
    $ ngxcodegen -n $NGINX_MODULE_NAME                # generate ngx_http_hoge_module.c and config
    $ ngxcodegen -n $NGINX_MODULE_NAME -t http        # generate ngx_http_hoge_module.c and config
    $ ngxcodegen -n $NGINX_MODULE_NAME -t http_filter # generate ngx_http_hoge_filter_module.c and config

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
