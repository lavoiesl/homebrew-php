require './Abstract/php5'

class Php54Xhprof < AbstractPhp5
  homepage 'https://github.com/facebook/xhprof'
  url 'https://github.com/facebook/xhprof/tarball/270b75dddf871271fe81ed416e122bd158a883f6'
  md5 '7a33371d7aeea57a808919deade28028'
  head 'https://github.com/facebook/xhprof.git'
  version '270b75d'

  depends_on 'autoconf' => :build
  depends_on 'pcre'

  def install
    Dir.chdir "extension" do
      # See https://github.com/mxcl/homebrew/pull/5947
      ENV.universal_binary

      system "phpize"
      system "./configure", "--prefix=#{prefix}"
      system "make"
      prefix.install "modules/xhprof.so"
    end

    prefix.install %w(xhprof_html xhprof_lib)
    write_config_file unless ARGV.include? "--without-config-file"
  end
end
