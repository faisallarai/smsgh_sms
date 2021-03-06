require "smsgh_sms/version"
require 'cgi'
require 'curb-fu'

module SmsghSms
  @@api_username = nil
  @@api_password = nil
  @@api_client_id = nil
  @@api_client_secret = nil
  @@api_senderid = "SMSGHAPI"

  # Expects :msg, :to and an optional :from param
  # The :from param defaults to @@api_senderid when its omitted
  def self.push(options={})

    sender_id = options[:from].nil? ? @@api_senderid : options[:from]
    response = nil

    raise ArgumentError, ':msg and :to params expected' if options[:msg].nil? || options[:to].nil?

    if @@api_username != nil && @@api_password != nil
      response = CurbFu.get({:host => 'api.smsgh.com', :path => '/v2/messages/send'}, { :from => sender_id, :to => options[:to], :text => options[:msg], :username => @@api_username, :password => @@api_password })
    end

    if @@api_client_id != nil && @@api_client_secret != nil
      response = CurbFu.get({:host => 'api.smsgh.com', :path => '/v3/messages/send', :protocol => 'http'}, { :From => sender_id, :To => options[:to], :Content => options[:msg], :ClientId => @@api_client_id, :ClientSecret => @@api_client_secret })
    end

    {:status => response.status, :notice => response.body}

  end


  def self.api_username=(api_username); @@api_username = api_username; end
  def self.api_username; @@api_username; end

  def self.api_password=(api_password); @@api_password = api_password; end
  def self.api_password; @@api_password; end

  def self.api_client_id=(api_client_id); @@api_client_id = api_client_id; end
  def self.api_client_id; @@api_client_id; end

  def self.api_client_secret=(api_client_secret); @@api_client_secret = api_client_secret; end
  def self.api_client_secret; @@api_client_secret; end

  def self.api_senderid=(api_senderid); @@api_senderid = api_senderid; end
  def self.api_senderid; @@api_senderid; end

end
