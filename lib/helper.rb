module Helper

  class << self

    def force_encoding(str)
      str = str.unpack('C*').pack('U*')
      str
    end

  end

end