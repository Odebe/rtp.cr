require "socket"
require "./packet.cr"
require "./parser.cr"

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
      bytes = Bytes.new(@buffer_size)
      @socket.receive(bytes)
      Parser.decode(bytes)
    end

    def send(packet : Packet) : Void
      bytes = Parser.encode(packet)
      @socket.send(bytes)
    end
  end
end
