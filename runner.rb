#!/usr/bin/env ruby

# require 'bundler'
# Bundler.require
require "net/http"
require 'json'

class SiteChecker
  def do_query(url)
    uri = URI.parse(url)
    begin
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.open_timeout = 5
        http.read_timeout = 5
        http.get(uri.request_uri)
      end
 
      case response
      when Net::HTTPSuccess
        @success += 1
      else
        # puts [uri.to_s, response.value].join(" : ")
      end
    rescue => e
      puts "-%s: %s" % [url, e.to_s]
      return
    end
    puts "-%s: %d" % [url, response.code] # status code
  end

  def read_config
    puts "Reading config..."
    config_file = "config.json"
    unless File.exist?( config_file ) then
      puts "Config file is not found so example file is generated."
      File.open(config_file, 'w') do |file|
        hash = { "Sites" => [ "https://www.google.com/"]}
        str = JSON.pretty_generate(hash)
        file.write(str)
      end
    end

    File.open(config_file) do |file|
      @sites = JSON.load(file, nil, {:symbolize_names => true, :create_additions => false})
      # p @sites
      p @sites[:Sites]
    end
  end

  def show_result
    puts "-Total: %d, Success: %d, Failure: %d" % [@total, @success, @total-@success]
  end

  def do_all_queries
    # Set up config
    read_config
    # Counters for result
    @total =  @sites[:Sites].count
    @success = 0

    puts "Checking site..."
    @sites[:Sites].each do |site|
      do_query site
    end

    # Result
    show_result
  end
end

sc = SiteChecker.new
sc.do_all_queries

