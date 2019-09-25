```sh
# Gemfile作成
$ bundle init

# https://medium.com/@hsdeekshith/using-mysql2-gem-in-aws-lambda-for-ruby-7f9456bf2ca5
cd rds-access-func
docker build -t lambda-ruby2.5-sales-dashboard .
docker run --rm -it -v $PWD:/var/task -w /var/task lambda-ruby2.5-sales-dashboard
bundle config --local build.mysql2 --with-mysql2-config=/usr/lib64/mysql/mysql_config
bundle config --local silence_root_warning true
bundle install --path vendor/bundle --clean
mkdir -p /var/task/lib
cp -a /usr/lib64/mysql/*.so.* /var/task/lib/
```
