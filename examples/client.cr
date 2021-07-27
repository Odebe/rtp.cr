require "../src/rtp.cr"

client = Rtp::Client.new("localhost", 1337)
client.connect!

packet = Rtp::Packet.new
packet.version = 2
packet.padding = false
packet.extension = false
packet.csrc_count = 0
packet.marker = false
packet.payload_type = 9
packet.seq_num = 333
packet.timestamp = 123
packet.ssrc_ident = 1337
packet.payload = Bytes[1,2,3,4,5,6]

client.send(packet)

puts client.receive.inspect
client.close
