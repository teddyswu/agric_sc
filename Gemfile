source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
gem "mysql2", '0.3.18' # DB 連結(類似 ODBC, JDBC)
gem "rufus-scheduler", "2.0.24"
gem "nokogiri",'1.6.7.1'         # 解析 html, 製作 xml 等..可用來作 xml 生成器跟爬蟲
gem "fog"              # 存取 AWS 服務的套件(圖片上傳至 s3, 遠端備份 DB 需要)
gem "devise", '3.4.0' # 先定版本號, 3.1.x 版有 bug, 未來穩定之後再把版本號拿掉
gem "cancan", '1.6.10'
gem "ckeditor", "4.2.3"
gem "paperclip", '4.3.0'
gem 'rails-html-sanitizer', '>= 1.0.4'
gem "dalli"

gem 'delayed_job_active_record'
gem "daemons"

gem 'will_paginate', '~> 3.1.0'
gem 'rails-jquery-tokeninput'

gem 'prawn'
gem 'prawn-table'
# 圖片上傳相關
gem "carrierwave", '0.10.0'     # 上傳圖片必要套件
gem "mini_magick", "3.6.0"      # 圖片處理的套件(縮圖、浮水印)
gem "flash_cookie_session"      # 多圖上傳必要套件
gem 'carrierwave-video-thumbnailer'
gem 'carrierwave-video'

gem "activerecord-import", "~> 0.4.1" # 一次新增多筆資料
gem "actionpack-action_caching", '1.1.1'
gem 'jquery-fileupload-rails', '0.4.6'
gem 'aws-sdk', '~> 1.66' # 連線 AWS 的 gem, 目前 paperclip 會使用

gem "omniauth-oauth"
gem "omniauth-facebook", '4.0.0'
# gem 'turbolinks'

group :assets do
	gem 'sass-rails', '~> 5.0'
	gem 'uglifier', '>= 1.3.0'
	gem 'coffee-rails', '~> 4.1.0'
end

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem "pry", '0.10.1'
  gem "magic_encoding" # 1.9
  gem "rvm-capistrano"
  # gem "capistrano" ,:git => "https://github.com/capistrano/capistrano.git" # 站台部屬
  gem "capistrano" , '2.15.4' # 站台部屬 升級 rails 4 加上版本號
end

