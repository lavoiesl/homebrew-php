require './Abstract/php5'

class Php54Mcrypt < AbstractPhp5
  homepage 'http://php.net/manual/en/book.mcrypt.php'
  url 'http://www.php.net/get/php-5.4.3.tar.bz2/from/this/mirror'
  md5 '51f9488bf8682399b802c48656315cac'
  version '5.4.3'

  depends_on 'autoconf' => :build
  depends_on 'mcrypt'

  def install
    Dir.chdir "ext/mcrypt"

    # See https://github.com/mxcl/homebrew/pull/5947
    ENV.universal_binary unless Hardware.is_64_bit?

    system "phpize"
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--with-mcrypt=#{Formula.factory('mcrypt').prefix}"
    system "make"
    prefix.install "modules/mcrypt.so"
    write_config_file unless ARGV.include? "--without-config-file"
  end
end
