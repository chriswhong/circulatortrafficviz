require 'net/http'
require 'rexml/document'
require 'win32/sound'
include Win32


# Build the feed's URI
uri = URI.parse('http://webservices.nextbus.com/service/publicXMLFeed?command=vehicleLocations&a=charm-city');

timestamp = Time.now.to_i

def repeat_every(interval)
  Thread.new do
    loop do
      start_time = Time.now
      yield
      elapsed = Time.now - start_time
      sleep([interval - elapsed, 0].max)
    end
  end
end

thread = repeat_every(15) do
# Request the twitter feed.
begin

  response = Net::HTTP.get_response(uri);
  if response.code != "200"
    raise
  end
rescue
  puts "Failed to pull feed."
 
end

begin
  xmlDoc = REXML::Document.new response.body
rescue
  puts "Received invalid XML."
 
end
writeFile = File.new "output.txt","a"

xmlDoc.elements.each("body/vehicle") {|vehicle|
print timestamp
writeFile.print timestamp
print ","
writeFile.print ","
puts vehicle.attributes['id']  + "," + vehicle.attributes['routeTag'] + "," + vehicle.attributes['lat'] + "," + vehicle.attributes['lon'] + "," + vehicle.attributes['speedKmHr']
writeFile.puts vehicle.attributes['id']  + "," + vehicle.attributes['routeTag'] + "," + vehicle.attributes['lat'] + "," + vehicle.attributes['lon'] + "," + vehicle.attributes['speedKmHr']

}
puts ""
puts "Updated at " + Time.now.to_s
puts ""

 Sound.play('chimes.wav')
end

puts "Waiting..."
thread.join