# load_npy.rb
require 'numo/narray'
require 'json'

def load_npy(filepath)
  arr = nil
  open(filepath) do |f|
    # f.read(8)
    magic = f.read(6)
    # if magic != "\x93NUMPY"
    if !(magic[0].ord == 0x93 && magic[1..-1] == "NUMPY")
      p magic
      return
    end
    f.read(2)   # pass
    l = f.read(2).unpack('v1')[0]
    # puts l
    dic_src = f.read(l)
    dic_src.gsub!("'", "\"")
    dic_src.gsub!("True", "true")
    dic_src.gsub!("False", "false")
    dic_src.gsub!(/\((\d+(,\s\d+)*),?\)/) { "[#{$1}]" }
    dic_src.gsub!(", }", "}")
    # p dic_src
    dic = JSON.parse(dic_src)
    cls = case dic["descr"]
    when "|i1"
      Numo::Int8
    when "<i2"
      Numo::Int16
    when "<i4"
      Numo::Int32
    when "<i8"
      Numo::Int64
    when "|u1"
      Numo::UInt8
    when "<u2"
      Numo::UInt16
    when "<u4"
      Numo::UInt32
    when "<u8"
      Numo::UInt64
    when "<f4"
      Numo::SFloat
    when "<f8"
      Numo::DFloat
    else
      raise NotImplementedError("The npy descr \"#{dic["descr"]}\" is not supported.")
    end
    fortran_order = dic["fortran_order"]
    shape = dic["shape"]
    arr = cls.from_binary(f.read)
    if shape.size > 1
      if fortran_order
        arr = arr.reshape(*shape.reverse).transpose
      else
        arr = arr.reshape(*shape)
      end
    end
  end
  arr
end

# if $0 == __FILE__
#   w1 = load_npy("W1.npy")
#   p w1[0, true]
#   b3 = load_npy("b3.npy")
#   p b3
#   a_u8 = load_npy("a_u8.npy")
#   p a_u8
# end