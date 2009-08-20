#!/usr/bin/env ruby

%w(rubygems daemons).each { |g| require g }

Daemons.run('bflocobot.rb')