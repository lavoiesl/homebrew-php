require './Abstract/php5'

class Php54Inclued < AbstractPhp5
  homepage 'http://pecl.php.net/package/inclued'
  url 'http://pecl.php.net/get/inclued-0.1.3.tgz'
  md5 '303f6ddba800be23d0e06a7259b75a2e'
  head 'https://svn.php.net/repository/pecl/inclued/trunk', :using => :svn

  depends_on 'autoconf' => :build

  def install
    Dir.chdir "inclued-#{version}" unless ARGV.build_head?

    # See https://github.com/mxcl/homebrew/pull/5947
    ENV.universal_binary

    system "phpize"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    prefix.install "modules/inclued.so"
    write_config_file unless ARGV.include? "--without-config-file"
  end
end
