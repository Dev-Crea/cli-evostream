require 'bundler/setup'

PACKAGE_NAME = 'CLI-Evostream'.freeze
VERSION = '1.0.0'.freeze
TRAVELING_RUBY_VERSION = '20150210-2.1.5'.freeze

desc 'Tools for admin EvoStream server'
task package: ['package:linux:x86', 'package:linux:x86_64', 'package:osx']

# rubocop:disable Metrics/BlockLength
namespace :package do
  namespace :linux do
    desc 'Package your app for Linux x86'
    task x86: "packaging/traveling-ruby-#{TRAVELING_RUBY_VERSION}" \
      '-linux-x86.tar.gz' do
      create_package('linux-x86')
    end

    desc 'Package your app for Linux x86_64'
    task x86_64: "packaging/traveling-ruby-#{TRAVELING_RUBY_VERSION}" \
      '-linux-x86_64.tar.gz' do
      create_package('linux-x86_64')
    end
  end

  desc 'Package your app for OS X'
  task osx: "packaging/traveling-ruby-#{TRAVELING_RUBY_VERSION}" \
    '-osx.tar.gz' do
    create_package('osx')
  end

  desc 'Install gems to local directory'
  task :bundle_install do
    if RUBY_VERSION !~ /^2\.1\./
      abort "You can only 'bundle install' using Ruby 2.1, because that's " \
        'what Traveling Ruby uses.'
    end
    sh 'rm -rf packaging/tmp'
    sh 'mkdir packaging/tmp'
    sh 'cp Gemfile Gemfile.lock packaging/tmp/'
    Bundler.with_clean_env do
      sh 'cd packaging/tmp && env BUNDLE_IGNORE_CONFIG=1 bundle install ' \
        '--path ../vendor --without development'
    end
    sh 'rm -rf packaging/tmp'
    sh 'rm -f packaging/vendor/*/*/cache/*'
  end
end
# rubocop:enable Metrics/BlockLength

file "packaging/traveling-ruby-#{TRAVELING_RUBY_VERSION}-linux-x86.tar.gz" do
  download_runtime('linux-x86')
end

file "packaging/traveling-ruby-#{TRAVELING_RUBY_VERSION}-linux-x86_64.tar.gz" do
  download_runtime('linux-x86_64')
end

file "packaging/traveling-ruby-#{TRAVELING_RUBY_VERSION}-osx.tar.gz" do
  download_runtime('osx')
end

def create_package(target)
  @target = target
  @package_dir = "#{PACKAGE_NAME}-#{VERSION}-#{@target}"
  prepare_folder
  uncompress_traveling_ruby
  add_files
end

def prepare_folder
  sh "rm -rf #{@package_dir}"
  sh "mkdir -p #{@package_dir}/lib/app"
  sh "mkdir #{@package_dir}/lib/ruby"
end

def add_files
  %w[cli.rb argument.rb command.rb evostream_cli.rb help].each do |file|
    sh "cp #{file} #{@package_dir}/lib/app"
  end

  sh "cp packaging/wrapper.sh #{@package_dir}/cli"
  sh "cp -pR packaging/vendor #{@package_dir}/lib/"
  sh "cp Gemfile Gemfile.lock #{@package_dir}/lib/vendor/"
  sh "mkdir #{@package_dir}/lib/vendor/.bundle"
  sh "cp packaging/bundler-config #{@package_dir}/lib/vendor/.bundle/config"

  sh "cp packaging/wrapper.sh #{@package_dir}/cli"
  dir_only unless ENV['DIR_ONLY']
end

def dir_only
  sh "tar -czf #{@package_dir}.tar.gz #{@package_dir}"
  sh "rm -rf #{@package_dir}"
end

def uncompress_traveling_ruby
  sh "tar -xzf packaging/traveling-ruby-#{TRAVELING_RUBY_VERSION}-#{@target}" \
    ".tar.gz -C #{@package_dir}/lib/ruby"
end

def download_runtime(target)
  sh 'cd packaging && curl -L -O --fail https://d6r77u77i8pq3.cloudfront.net/' \
    "releases/traveling-ruby-#{TRAVELING_RUBY_VERSION}-#{@target}.tar.gz"
end
