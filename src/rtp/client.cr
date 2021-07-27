require "socket"
require "./packet.cr"

module Rtp
  class Client
    # TODO: do something with buffer, in current realization is sort of bad design
    def initialize(@host : String, @port : Int32, @buffer_size = 1024)
      @socket = UDPSocket.new
    end

    def close : Void
      @socket.close
    end

    def connect! : Void
      @socket.connect @host, @port
    end

    def receive : Packet
      buffer = Bytes.new(@buffer_size)
      memory = IO::Memory.new(buffer)

      @socket.receive(buffer)
      memory.read_bytes(Packet)
    end

    def send(packet : Packet) : Void
      buffer = Bytes.new(@buffer_size)
      memory = IO::Memory.new(buffer)

      memory.write_bytes(packet)
      @socket.send(buffer)
    end
  end
end
