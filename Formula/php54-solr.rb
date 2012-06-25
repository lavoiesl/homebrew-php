require './Abstract/php5'

class Php54Solr < AbstractPhp5
  homepage 'http://pecl.php.net/package/solr'
  url 'http://pecl.php.net/get/solr-1.0.2.tgz'
  md5 '1632144b462ab22b91d03e4d59704fab'
  head 'https://svn.php.net/repository/pecl/solr/trunk/', :using => :svn

  depends_on 'autoconf' => :build

  def install
    Dir.chdir "solr-#{version}" unless ARGV.build_head?

    # See https://github.com/mxcl/homebrew/pull/5947
    ENV.universal_binary

    system "phpize"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    prefix.install "modules/solr.so"
    write_config_file unless ARGV.include? "--without-config-file"
  end
end
