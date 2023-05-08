# -*- coding: utf-8 -*-

require "cbor" unless defined? CBOR

module CBOR
  module Dcbor

    module Object_Dcbor_CBOR
      def cbor_prepare_dcbor
        self
      end
      def to_dcbor
        cbor_prepare_dcbor.to_cbor
      end
    end
    Object.send(:include, Object_Dcbor_CBOR)

    module Integer_Dcbor_CBOR
      def cbor_prepare_dcbor
        zigzag, tagnum = if self < 0
                           [-1-self, 3]
                         else
                           [self, 2]
                         end
        bytes = zigzag.digits(256)
        if bytes.size + 2 < self.to_cbor.size
          CBOR::Tagged.new(tagnum, bytes.pack("C*").reverse!)
        else
          self
        end
      end
    end
    Integer.send(:include, Integer_Dcbor_CBOR)

    module Float_Dcbor_CBOR
      def cbor_prepare_dcbor
        int = self.to_i
        if int == self && int.to_cbor.size < self.to_cbor.size
          int
        else
          self
        end
      end
    end
    Float.send(:include, Float_Dcbor_CBOR)

    module Array_Dcbor_CBOR
      def cbor_prepare_dcbor
        map(&:cbor_prepare_dcbor)
      end
    end
    Array.send(:include, Array_Dcbor_CBOR)

    module Hash_Dcbor_CBOR
      def cbor_prepare_dcbor
        Hash[map {|k, v|
                  k = k.cbor_prepare_dcbor
                  v = v.cbor_prepare_dcbor
                  cc = k.to_cbor # already prepared
                  [cc, k, v]}.
             sort.map{|cc, k, v| [k, v]}]
      end
    end
    Hash.send(:include, Hash_Dcbor_CBOR)

    module Tagged_Dcbor_CBOR
      def cbor_prepare_dcbor
        CBOR::Tagged.new(tag, value.cbor_prepare_dcbor)
      end
    end
    CBOR::Tagged.send(:include, Tagged_Dcbor_CBOR)
  end
end
