require "bindata"

module Rtp
  class Packet < BinData
    endian big

    bit_field do
      # 0-1
      bits 2, :version
      # 2
      bool :padding
      # 3
      bool :extension
      # 4-7
      bits 4, :csrc_count, value: ->{ csrc_idents.size.to_u8 }
      # 8
      bool :marker
      # 8-15
      bits 7, :payload_type
    end
  
    uint16 :seq_num

    uint32 :timestamp
    uint32 :ssrc_ident

    array csrc_idents : UInt32 = [] of UInt32, onlyif: ->{ csrc_count > 0 }, length: ->{ csrc_count }

    # TODO: refactor later
    group :extensions, onlyif: ->{ extension } do
      uint16 :profile
      uint16 :length
      array idents : UInt32 = [] of UInt32, length: ->{ length }
    end
    
    remaining_bytes :payload
  end
end
