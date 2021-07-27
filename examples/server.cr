require "../src/rtp.cr"

server = Rtp::Server.new("localhost", 1337)

loop do
  addr, packet = server.receive
  puts packet.inspect
  server.send(packet, addr)
end

