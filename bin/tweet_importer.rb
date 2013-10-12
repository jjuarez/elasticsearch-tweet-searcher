#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'tweetsearcher'


TweetSearcher::Cli.run(:file =>Choice.choices[:file])