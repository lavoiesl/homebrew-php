require './Abstract/php5'

class Php53Xcache < AbstractPhp5
  homepage 'http://xcache.lighttpd.net'
  url 'http://xcache.lighttpd.net/pub/Releases/2.0.0/xcache-2.0.0.tar.bz2'
  md5 '0e30cdff075c635e475d70a5c37d0252'

  depends_on 'autoconf' => :build

  def extension_type; "zend_extension"; end

  def install
    # See https://github.com/mxcl/homebrew/issues/issue/69
    ENV.universal_binary unless Hardware.is_64_bit?

    system "phpize"
    system "./configure", "--prefix=#{prefix}",
                          "--disable-debug",
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/xcache.so"
    write_config_file unless ARGV.include? "--without-config-file"
  end
end
