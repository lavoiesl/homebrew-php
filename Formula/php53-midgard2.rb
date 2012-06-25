require './Abstract/php5'

class Php53Midgard2 < AbstractPhp5
  homepage 'http://www.midgard-project.org'
  head 'https://github.com/midgardproject/midgard-php5.git', :branch => 'ratatoskr'
  url 'https://github.com/midgardproject/midgard-php5/tarball/10.05.6'
  md5 'ba43c97c4c3c940d1b9b331986f33ee6'

  depends_on 'autoconf' => :build
  depends_on 'pkg-config' => :build
  depends_on 'midgard2'

  def install
    # See https://github.com/mxcl/homebrew/pull/5947
    ENV.universal_binary

    system "phpize"
    system "./configure", "--prefix=#{prefix}",
                          "--with-php-config=/usr/bin/php-config"
    system "make"
    prefix.install "modules/midgard2.so"
    write_config_file unless ARGV.include? "--without-config-file"
  end
end
