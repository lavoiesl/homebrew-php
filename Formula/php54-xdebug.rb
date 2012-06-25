require './Abstract/php5'

class Php54Xdebug < AbstractPhp5
  homepage 'http://xdebug.org'
  url 'http://xdebug.org/files/xdebug-2.2.0.tgz'
  md5 '27d8ad8224ffab04d12eecb5997a4f5d'

  depends_on 'autoconf' => :build

  def extension_type; "zend_extension"; end

  def install
    Dir.chdir "xdebug-#{version}"

    # See https://github.com/mxcl/homebrew/issues/issue/69
    ENV.universal_binary

    system "phpize"
    system "./configure", "--prefix=#{prefix}",
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file unless ARGV.include? "--without-config-file"
  end
end
