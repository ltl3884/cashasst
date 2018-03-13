require 'net/http'
require 'digest/md5'
class Huobi::Base
	
	attr_accessor :access_key, :secret_key, :account_id

  API_URL = "https://api.huobi.pro"
  #API_URL = "https://api.huobipro.com"

	def initialize(account_name, signature_version = "2")
      @access_key = AppConfig.instance["#{account_name}_akey"]
      @secret_key = AppConfig.instance["#{account_name}_skey"]
      @signature_version = signature_version
      @uri = URI.parse(API_URL)
      @timeout = 40 #sec
      @header = {
        'Content-Type'=> 'application/json',
        'Accept' => 'application/json',
        'Accept-Language' => 'zh-CN',
        'User-Agent'=> 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36'
      }
  end

  private
  def access_huobi(path, params, request_method)
    begin
      h =  {
        "AccessKeyId" => @access_key,
        "SignatureMethod" => "HmacSHA256",
        "SignatureVersion" => @signature_version,
        "Timestamp" => Time.now.getutc.strftime("%Y-%m-%dT%H:%M:%S")
      }
      h = h.merge(params) if request_method == "GET"
      data = "#{request_method}\napi.huobi.pro\n#{path}\n#{Rack::Utils.build_query(hash_sort(h))}"
      h["Signature"] = sign(data)
      url = "#{API_URL}#{path}?#{Rack::Utils.build_query(h)}"
      req = Net::HTTP::Get.new(url, @header) if request_method == "GET"
      if request_method == "POST"
        req = Net::HTTP::Post.new(url, @header) 
        req.body = JSON.dump(params)
      end
      res = Net::HTTP.start(@uri.host, @uri.port, :use_ssl => @uri.scheme == 'https', :open_timeout => @timeout) do |http|
        http.request(req)
      end
      response = res.body
      result = JSON.parse(response)
      puts result.to_json
      result
    rescue Net::OpenTimeout => e
      e = {"status" => "error", "err-msg" => "timeout"}
      puts e.to_json
      e
    end
    
  end

  def sign(data)
    Base64.encode64(OpenSSL::HMAC.digest('sha256', @secret_key, data)).gsub("\n","")
  end

  def hash_sort(ha)
    Hash[ha.sort_by{|key, val|key}]
  end

end