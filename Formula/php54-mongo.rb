require './Abstract/php5'

class Php54Mongo < AbstractPhp5
  homepage 'http://pecl.php.net/package/mongo'
  url 'http://pecl.php.net/get/mongo-1.2.10.tgz'
  md5 'e74fd1b235278a895795f19692923a16'
  head 'https://github.com/mongodb/mongo-php-driver.git'

  depends_on 'autoconf' => :build

  def install
    Dir.chdir "mongo-#{version}" unless ARGV.build_head?

    # See https://github.com/mxcl/homebrew/pull/5947
    ENV.universal_binary

    system "phpize"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    prefix.install "modules/mongo.so"
    write_config_file unless ARGV.include? "--without-config-file"
  end
end
