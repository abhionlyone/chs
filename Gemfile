source 'https://rubygems.org'
ruby '2.5.1'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.3'
gem 'redis', '~> 4.1'
gem 'sidekiq', '~> 5.2', '>= 5.2.7'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'faker', :git => 'https://github.com/stympy/faker.git', :branch => 'master'
end

group :development do
  gem 'annotate', git: 'https://github.com/ctran/annotate_models.git'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end