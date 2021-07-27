require "socket"
require "./packet.cr"

module Rtp
  class Server
    # TODO: do something with buffer, in current realization is sort of bad design
    def initialize(@host : String, @port : Int32, @buffer_size = 1024)
      @socket = UDPSocket.new
      @socket.bind @host, @port
    end

    def receive : Tuple(Socket::IPAddress, Packet)
      buffer = Bytes.new(@buffer_size)
      memory = IO::Memory.new(buffer)

      _size, addr = @socket.receive(buffer)
      {addr, memory.read_bytes(Packet)}
    end

    def send(packet : Packet, addr)
      buffer = Bytes.new(@buffer_size)
      memory = IO::Memory.new(buffer)

      memory.write_bytes(packet)
      @socket.send(buffer, addr)
    end
  end
end
