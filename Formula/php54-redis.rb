require './Abstract/php5'

def redis_installed?
  `which redis-server`.length > 0
end

class Php54Redis < AbstractPhp5
  homepage 'https://github.com/nicolasff/phpredis'
  url 'https://github.com/nicolasff/phpredis/tarball/2.2.0'
  md5 '9a89b0aeae1906bcfdc8a80d14d62405'
  head 'https://github.com/nicolasff/phpredis.git'

  depends_on 'autoconf' => :build
  depends_on 'redis' => :recommended unless redis_installed?

  fails_with :clang do
    build 318
    cause <<-EOS.undent
      argument to 'va_arg' is of incomplete type 'void'
      This is fixed in HEAD, and can be removed for the next release.
      EOS
  end unless ARGV.build_head?

  def install
    # See https://github.com/mxcl/homebrew/pull/5947
    ENV.universal_binary

    system "phpize"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    prefix.install "modules/redis.so"
    write_config_file unless ARGV.include? "--without-config-file"
  end
end
