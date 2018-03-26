#!/opt/puppetlabs/puppet/bin/ruby

require 'puppet'
require 'json'
require 'net/http'
require 'openssl'

Puppet.initialize_settings

def connection(host, port = 8140)
  settings = Puppet.settings.values(:production, :master)
  auth = {
    key:    settings.interpolate(:hostprivkey),
    cert:   settings.interpolate(:hostcert),
    cacert: settings.interpolate(:localcacert),
  }

  http = Net::HTTP.new(host, port)
  http.use_ssl = true
  http.cert = OpenSSL::X509::Certificate.new(File.read(auth[:cert]))
  http.key  = OpenSSL::PKey::RSA.new(File.read(auth[:key]))
  http.ca_file = auth[:cacert]
  http
end

host = Puppet.settings.values(:production, :agent).interpolate(:server)
req = Net::HTTP::Get.new('/puppet/v3/environments')
res = connection(host).request(req)

STDOUT.write(JSON.pretty_generate JSON.parse(res.body)["environments"].keys)
