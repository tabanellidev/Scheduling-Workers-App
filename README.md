# Setup rbenv

### Install
```
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src && cd ..
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
```
### Setup
```
~/.rbenv/bin/rbenv init
# Load rbenv automatically by appending
# the following to ~/.bashrc:
eval "$(rbenv init - bash)"
```

```
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - bash)"
```
### Reload and Update
```
bash -l
rbenv -v
rbenv 1.2.0-6-g304cb7b
```

### Get ruby-build
```
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
```

### Additional install for Ubuntu/Debian/Mint
https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
```
apt-get install autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
```

### Install Ruby-Version
```
rbenv install 3.3.3
ruby -v
```

# Complete Setup
```
bundle install
rails db:migrate
```

# Start
```
bundle exec puma -C config/puma.rb -b tcp://127.0.0.1:3001
```
