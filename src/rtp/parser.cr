module Rtp
  module Parser
    extend self

    def encode(packet : Packet) : Bytes
      packet.to_slice
    end

    def decode(bytes : Bytes) : Packet
      Packet.from_slice(bytes)
    end
  end
end
