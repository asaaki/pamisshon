# encoding: utf-8

# development helpers for Pamisshon gem

def redis_cli(db=15)
  puts "Starting redis-cli with db = #{db} …"
  system "redis-cli -n #{db}"
  puts "Hopefully your session was successful."
  true
end
