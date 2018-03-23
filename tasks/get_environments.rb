#!/opt/puppetlabs/puppet/bin/ruby

enviros = %x{/bin/ls -1 /etc/puppetlabs/code/environments/}.split("\n")
puts enviros
