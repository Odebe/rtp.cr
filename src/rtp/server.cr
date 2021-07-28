require "socket"
require "./packet.cr"
require "./parser.cr"

module Rtp
  class Server
    # TODO: do something with buffer, in current realization is sort of bad design
    def initialize(@host : String, @port : Int32, @buffer_size = 1024)
      @socket = UDPSocket.new
      @socket.bind @host, @port
    end

    def receive : Tuple(Socket::IPAddress, Packet)
      buffer = Bytes.new(@buffer_size)
      _size, addr = @socket.receive(buffer)
      {addr, Parser.decode(buffer)}
    end

    def send(packet : Packet, addr)      
      bytes = Parser.encode(packet)
      @socket.send(bytes, addr)
    end
  end
end
